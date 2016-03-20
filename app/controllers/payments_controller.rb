class PaymentsController < ApplicationController
  skip_before_action :restrict_access
  before_action :set_payment

  def status
    @payment.check_status unless @payment.paid?

    if @payment.paid?
      render :success
    else
      render :failure
    end
  end

  private

  def set_payment
    @payment = Payment.find_by!(alfa_order_id: params[:orderId])
  end
end
