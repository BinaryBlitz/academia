class AddOutOfStockToDishes < ActiveRecord::Migration[5.0]
  def change
    add_column :dishes, :out_of_stock, :boolean, default: false
  end
end
