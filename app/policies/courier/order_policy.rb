class Courier::OrderPolicy < ApplicationPolicy
  attr_reader :courier, :order

  def initialize(courier, order)
    @courier = courier
    @order = order
  end

  def assign?
    order.courier.nil?
  end

  def update?
    order.courier == courier
  end
end
