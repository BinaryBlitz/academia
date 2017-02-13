# == Schema Information
#
# Table name: line_items
#
#  id         :integer          not null, primary key
#  order_id   :integer
#  dish_id    :integer
#  quantity   :integer          default("1")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class LineItem < ActiveRecord::Base
  belongs_to :order, inverse_of: :line_items
  belongs_to :dish

  validates :order, presence: true
  validates :dish, presence: true
  validates :quantity, presence: true

  def total_price
    dish.price * quantity
  end
end
