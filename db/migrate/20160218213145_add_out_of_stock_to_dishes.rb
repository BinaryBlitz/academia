class AddOutOfStockToDishes < ActiveRecord::Migration
  def change
    add_column :dishes, :out_of_stock, :boolean, default: false
  end
end
