class Courier::OrdersController < Courier::CourierController
  before_action :set_order, only: [:assign, :update]

  def index
    @orders = current_courier.delivery_point.orders.includes(:user).where(status: 'new').order(created_at: :desc)
  end

  def assigned
    @orders = current_courier.orders.includes(:user)
    render :index
  end

  def assign
    @order.update(courier: current_courier)
    head :ok
  end

  def update
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

  def order_params
    params.require(:order).permit(:status)
  end
end
