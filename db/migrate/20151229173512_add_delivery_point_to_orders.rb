class AddDeliveryPointToOrders < ActiveRecord::Migration
  def change
    add_reference :orders, :delivery_point, index: true, foreign_key: true
  end
end
