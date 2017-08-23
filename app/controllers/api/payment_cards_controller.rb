class API::PaymentCardsController < API::APIController
  def create
    @payment_registration = current_user.payment_registrations.create
    response = @payment_registration.register

    render json: response, status: :ok
  end

  def index
    @payment_cards = current_user.payment_cards
  end
end
