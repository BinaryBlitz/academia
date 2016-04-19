class PaymentsController < ApplicationController
  skip_before_action :restrict_access, only: [:status]
  before_action :set_order, only: [:create]
  before_action :set_payment, only: [:status]

  def create
    payment_card = current_user.payment_cards.find_by(binding_id: payment_params[:binding_id])
    payment = @order.payment || @order.create_payment(use_binding: payment_card.present?)

    response = if payment_card.present?
      payment.register(use_binding: true)
      payment.payment_order_binding(payment_card.binding_id)
    else
      payment.register
    end

    render json: response, status: :ok
  end

  def status
    @payment.check_status(use_binding: @payment.use_binding?) unless @payment.paid?

    if @payment.paid?
      render :success
    else
      render :failure
    end
  end

  private

  def set_order
    @order = current_user.orders.find(params[:order_id])
  end

  def set_payment
    options = { alfa_order_id: params[:orderId] }
    @payment = Payment.find_by(options) || PaymentRegistration.find_by!(options)
  end

  def payment_params
    params.require(:payment).permit(:binding_id)
  end
end
