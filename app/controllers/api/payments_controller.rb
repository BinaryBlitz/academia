class API::PaymentsController < API::APIController
  before_action :set_order, only: [:create]

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

  private

  def set_order
    @order = current_user.orders.find(params[:order_id])
  end

  def payment_params
    params.require(:payment).permit(:binding_id)
  end
end
