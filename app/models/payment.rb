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
#

class Payment < ActiveRecord::Base
  include Alfabank
  belongs_to :order

  validates_numericality_of :price, greater_than: 0
  validates_presence_of :order_id

  before_validation :set_price, on: :create

  delegate :user_id, to: :order
  delegate :line_items, to: :order

  private

  def set_price
    self.price = order.total_price
  end
end
