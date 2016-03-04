class AddOutOfStockToSchedules < ActiveRecord::Migration
  def change
    add_column :schedules, :out_of_stock, :boolean, default: false
  end
end
