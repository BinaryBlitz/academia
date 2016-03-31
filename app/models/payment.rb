# == Schema Information
#
# Table name: payments
#
#  id            :integer          not null, primary key
#  price         :integer          not null
#  order_id      :integer          not null
#  alfa_order_id :string
#  alfa_form_url :string
#  paid          :boolean
#  use_binding   :boolean
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  description   :string
#

class Payment < ActiveRecord::Base
  include Alfabank

  before_validation :set_price, on: :create
  before_validation :set_description, on: :create
  after_update :paid_callback

  belongs_to :order

  validates_numericality_of :price, greater_than: 0
  validates_presence_of :order_id

  delegate :user, to: :order
  delegate :user_id, to: :order
  delegate :line_items, to: :order

  private

  def set_price
    self.price = order.total_price
  end

  def set_description
    self.description = "Заказ №#{order_id}"
  end

  def paid_callback
    return unless paid?

    order.redeem_balance
    user.redeem_user_code
    order.set_paid
  end
end
