class AddWeightToIngredients < ActiveRecord::Migration
  def change
    add_column :ingredients, :weight, :integer
  end
end
