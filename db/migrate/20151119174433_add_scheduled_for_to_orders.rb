class AddScheduledForToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :scheduled_for, :datetime
  end
end
