class RemoveImageFromIngredients < ActiveRecord::Migration[5.0]
  def change
    remove_column :ingredients, :image, :string
  end
end
