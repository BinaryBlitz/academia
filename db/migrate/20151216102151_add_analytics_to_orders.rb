class AddAnalyticsToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :revenue, :integer
    add_column :orders, :discount, :integer
    add_column :orders, :balance_discount, :integer
  end
end
