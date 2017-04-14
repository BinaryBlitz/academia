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
#  binding_id    :string
#  card_number   :string
#

class PaymentRegistration < ActiveRecord::Base
  PAYMENT_REGISTRATION_OFFSET = 10000000

  include Alfabank

  after_update :paid_callback

  belongs_to :user

  def description
    "Регистрация платежа №#{id}"
  end

  def price
    1
  end

  def use_binding?
    false
  end

  def to_order_number
    PAYMENT_REGISTRATION_OFFSET + id
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
