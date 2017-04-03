class RemoveLunchAndStuffFromDishes < ActiveRecord::Migration[5.0]
  def change
    remove_column :dishes, :lunch, :boolean, default: false
    remove_column :dishes, :stuff, :boolean, default: false
  end
end
