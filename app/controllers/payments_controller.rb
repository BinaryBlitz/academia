class PaymentsController < ApplicationController
  skip_before_action :restrict_access
  before_action :set_order, only: [:register, :process]
  before_action :set_payment, only: [:status]

  def create
    payment = @order.payment || @order.create_payment(payment_params)
    response = payment.payment_order_binding(payment_params[:binding_id])

    render json: response, status: :ok
  end

  def status
    @payment.check_status unless @payment.paid?

    if @payment.paid?
      render :success
    else
      render :failure
    end
  end

  private

  def set_order
    @order = current_user.orders.find(params[:id])
  end

  def set_payment
    options = { alfa_order_id: params[:orderId] }
    @payment = Payment.find_by(options) || PaymentRegistration.find_by!(options)
  end

  def payment_params
    params.require(:payment).permit(:binding_id)
  end
end
