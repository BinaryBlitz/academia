class RemoveForeignKeyOnOrdersAndDeliveryPoints < ActiveRecord::Migration
  def up
    remove_foreign_key 'orders', 'delivery_points'
  end

  def down
    add_foreign_key 'orders', 'delivery_points'
  end
end
