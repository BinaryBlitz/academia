class Courier::OrdersController < Courier::CourierController
  def index
    @orders = current_courier.orders
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
