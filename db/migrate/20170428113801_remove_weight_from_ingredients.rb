class RemoveWeightFromIngredients < ActiveRecord::Migration[5.0]
  def change
    remove_column :ingredients, :weight, :integer
  end
end
