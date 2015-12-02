class AddFieldsToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :rating, :integer
    add_column :orders, :review, :text
  end
end
