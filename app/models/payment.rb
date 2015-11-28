# == Schema Information
#
# Table name: payments
#
#  id            :integer          not null, primary key
#  price         :integer          not null
#  order_id      :integer          not null
#  alfa_order_id :string
#  alfa_form_url :string
#  payed         :boolean
#  use_binding   :boolean
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Payment < ActiveRecord::Base
  RUB = 810
  KOPEYKI_IN_RUB = 100
  REGISTRATION_URL = "https://test.paymentgate.ru/testpayment/rest/register.do"
  CHECK_STATUS_URL = "https://test.paymentgate.ru/testpayment/rest/getOrderStatus.do"
  SUCCESS = 0

  belongs_to :order

  validates_numericality_of :price, greater_than: 0
  validates_presence_of :order_id

  before_validation :set_price, on: :create

  delegate :user, to: :order
  delegate :line_items, to: :order

  def register_in_alfa
    return alfa_form_url if alfa_order_id.present?
    response = JSON.parse(make_registration_request.parsed_response)

    if response.has_key? "orderId"
      set_alfa_data_from_response(response)
      alfa_form_url
    else
      logger.info "#{Time.zone.now.to_s}: p##{id} #{response['errorMessage']}"
      nil
    end
  end

  def check_status
    response = JSON.parse(make_status_request.parsed_response)

    if response["ErrorCode"] == SUCCESS
      update_attribute(:payed, true)
      set_user_binding_from_response(response) if response.has_key? "bindingId"
    end

    response["ErrorMessage"]
  end

  private

  def set_price
    self.price = line_items.inject(0) { |acc, li| acc + li.total_price }
  end

  def make_registration_request
    HTTParty.post(REGISTRATION_URL, body: generate_payment_params)
  end

  def make_status_request
    HTTParty.post(CHECK_STATUS_URL, body: generate_status_params)
  end

  def generate_status_params
    {
      userName: 'zdorovoepitanie-api',
      password: 'zdorovoepitanie',
      orderId: alfa_order_id
    }.map { |k, v| "#{k}=#{v}" }.join('&')
  end

  def generate_payment_params
    params = {
      userName: 'zdorovoepitanie-api',
      password: 'zdorovoepitanie',
      description: 'Здоровое питание',
      language: 'ru',
      orderNumber: "payment-test#{id}",
      amount: price * KOPEYKI_IN_RUB, # TODO: add balance
      currency: RUB,
      clientId: user.id,
      returnUrl: 'finish.html'
    }

    if use_binding?
      params.merge!(
        userName: 'zdorovoepitanie_auto-api',
        bindingId: user.alfa_binding_id
      )
    end

    params.map { |k, v| "#{k}=#{v}" }.join('&')
  end

  def set_alfa_data_from_response(response)
    update_attributes(
      alfa_order_id: response["orderId"],
      alfa_form_url: response["formUrl"]
    )
  end

  def set_user_binding_from_response(response)
    return if response["bindingId"] == user.alfa_binding_id

    user.update_attributes(
      alfa_binding_id: response["bindingId"],
      card_number: response["Pan"]
    )
  end
end
