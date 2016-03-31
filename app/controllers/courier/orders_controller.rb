class Courier::OrdersController < Courier::CourierController
  before_action :set_order, only: [:assign, :update]

  def index
    @orders = current_courier.available_orders.order(scheduled_for: :asc)
  end

  def assigned
    @orders = current_courier.orders.on_the_way.includes(:user)
    render :index
  end

  def assign
    raise Pundit::NotAuthorizedError unless current_policy.assign?

    if @order.update!(courier: current_courier)
      head :ok
    else
      render json: @order.errors, status: 422
    end
  end

  def update
    raise Pundit::NotAuthorizedError unless current_policy.update?

    if @order.update(order_params)
      head :ok
    else
      render json: @order.errors, status: 422
    end
  end

  private

  def set_order
    @order = Order.find(params[:id])
  end

  def current_policy
    Courier::OrderPolicy.new(current_courier, @order)
  end

  def order_params
    params.require(:order).permit(:status)
  end
end
