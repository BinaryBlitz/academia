class Courier::OrdersController < Courier::CourierController
  def index
    @orders = current_courier.delivery_point.orders.where(status: 'new')
  end

  def assigned
    @order = current_courier.orders
    render :index
  end

  def assign
    @order = Order.unassigned.find(params[:id])
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

  def order_params
    params.require(:order).permit(:status)
  end
end
