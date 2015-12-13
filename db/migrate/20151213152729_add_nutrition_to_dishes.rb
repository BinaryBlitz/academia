class AddNutritionToDishes < ActiveRecord::Migration
  def change
    add_column :dishes, :proteins, :float
    add_column :dishes, :fats, :float
    add_column :dishes, :carbohydrates, :float
    add_column :dishes, :calories, :float
  end
end
