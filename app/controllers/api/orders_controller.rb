class API::OrdersController < API::APIController
  before_action :set_order, except: [:index, :create]

  def index
    @orders = current_user.orders.visible
  end

  def show
  end

  def create
    @order = current_user.orders.build(order_params)

    if @order.save
      render :show, status: :created
    else
      render json: @order.errors, status: :unprocessable_entity
    end
  end

  def update
    if @order.update(order_params)
      head :ok
    else
      render json: @order.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @order.destroy
    head :no_content
  end

  def payment
    order_payment = (@order.payment || @order.create_payment(payment_params))
    response = order_payment.register

    render json: response, status: :ok
  end

  private

  def set_order
    @order = Order.find(params[:id])
  end

  def order_params
    params.require(:order).permit(
      :address, :scheduled_for, :latitude, :longitude,
      :rating, :review,
      line_items_attributes: [:dish_id, :quantity]
    )
  end

  def payment_params
    params.require(:payment).permit(:use_binding)
  end
end
