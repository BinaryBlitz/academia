class Admin::OrdersController < Admin::AdminController
  before_action :set_orders, only: [:index]
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  def index
  end

  def show
  end

  def edit
  end

  def update
    if @order.update(order_params)
      redirect_to [:admin, @order], notice: 'Заказ был успешно обновлен.'
    else
      render :edit
    end
  end

  def destroy
    @order.destroy
    redirect_to admin_orders_url, notice: 'Заказ был успешно удален.'
  end

  private

  def set_orders
    @orders = case params[:status]
              when 'on_the_way' then Order.on_the_way
              when 'delivered' then Order.delivered
              when 'unpaid' then Order.unpaid
              else Order.unassigned
              end
    @orders = @orders.order(scheduled_for: :desc).page(params[:page])
  end

  def set_order
    @order = Order.find(params[:id])
  end

  def order_params
    params.require(:order).permit(:address, :status)
  end
end
