# == Schema Information
#
# Table name: orders
#
#  id                :integer          not null, primary key
#  address           :text
#  user_id           :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  status            :string
#  scheduled_for     :datetime
#  latitude          :float
#  longitude         :float
#  rating            :integer
#  review            :text
#  courier_id        :integer
#  revenue           :integer
#  discount          :integer
#  balance_discount  :integer
#  delivered_at      :datetime
#  delivery_point_id :integer
#

require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  setup do
    @order = orders(:order)
  end

  test 'valid' do
    assert @order.valid?
  end

  test 'delivery time is later than now' do
    order = @order.dup
    order.scheduled_for = 1.minute.ago
    assert order.invalid?

    @order.scheduled_for = 1.minute.ago
    assert @order.valid?
  end

  test 'delivery time is present' do
    order = orders(:deliver_now).dup
    assert order.valid?

    order.deliver_now = false
    order.scheduled_for = nil
    assert order.invalid?
  end
end
