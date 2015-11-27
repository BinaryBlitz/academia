class OrdersController < ApplicationController
  before_action :set_order, except: [:index, :create]

  def index
    @orders = Order.all
  end

  def create
    @order = current_user.orders.build(order_params)

    if @order.save
      render :show, status: :created
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
    @url = order_payment.register_in_alfa

    format.json { render json: {url: @url} }
  end

  def payment_status
    @status = @order.payment.try(:check_status)

    format.json { render json: {status: @status} }
  end

  private

  def set_order
    @order = Order.find(params[:id])
  end

  def order_params
    params.require(:order).permit(
      :address, :scheduled_for, :latitude, :longitude, line_items_attributes: [:dish_id, :quantity]
    )
  end

  def payment_params
    params.require(:payment).permit(:use_binding)
  end
end
