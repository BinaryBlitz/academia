# == Schema Information
#
# Table name: payment_registrations
#
#  id            :integer          not null, primary key
#  user_id       :integer
#  alfa_order_id :string
#  alfa_form_url :string
#  paid          :boolean          default(FALSE)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class PaymentRegistration < ActiveRecord::Base
  include Alfabank

  after_update :paid_callback

  def price
    1
  end

  def to_order_number
    "payment-registration-#{id}"
  end

  private

  def paid_callback
    return unless paid?

    add_payment_card
  end

  def add_payment_card
    user.payment_cards.find_or_create_by(payment_card_params)
  end

  def payment_card_params
    payment_card_params ||= begin
      status = check_status
      { binding_id: status[:binding_id], number: status[:card_number] }
    end
  end
end
