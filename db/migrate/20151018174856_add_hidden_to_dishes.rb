class AddHiddenToDishes < ActiveRecord::Migration
  def change
    add_column :dishes, :hidden, :boolean, default: false
  end
end
