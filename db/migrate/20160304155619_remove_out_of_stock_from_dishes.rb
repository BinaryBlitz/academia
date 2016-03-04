class RemoveOutOfStockFromDishes < ActiveRecord::Migration
  def change
    remove_column :dishes, :out_of_stock, :boolean, default: false
  end
end
