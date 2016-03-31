class AddDeliverNowToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :deliver_now, :boolean, default: true
  end
end
