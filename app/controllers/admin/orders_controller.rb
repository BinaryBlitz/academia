class Admin::OrdersController < Admin::AdminController
  before_action :set_admin_order, only: [:show, :edit, :update, :destroy]

  def index
    @orders = Order.unassigned.order(scheduled_for: :desc).page(params[:page])
  end

  def on_the_way
    @on_the_way = Order.on_the_way.order(scheduled_for: :desc).page(params[:page])
  end

  def delivered
    @delivered = Order.delivered.order(scheduled_for: :desc).page(params[:page])
  end

  def unpaid
    @unpaid = Order.unpaid.order(scheduled_for: :desc).page(params[:page])
  end

  def show
  end

  def new
    @order = Order.new
  end

  def edit
  end

  def create
    @order = Order.new(admin_order_params)

    if @order.save
      redirect_to [:admin, @order], notice: 'Заказ был успешно создан.'
    else
      render :new
    end
  end

  def update
    if @order.update(admin_order_params)
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

  def set_admin_order
    @order = Order.find(params[:id])
  end

  def admin_order_params
    params.require(:order).permit(:address, :status)
  end
end
