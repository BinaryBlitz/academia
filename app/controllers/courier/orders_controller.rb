class Courier::OrdersController < Courier::CourierController
  def index
    @orders = current_courier.orders
  end

  def assign
    @order = Order.unassigned.find(params[:id])
    @order.update(courier: current_courier)
    head :ok
  end
end
