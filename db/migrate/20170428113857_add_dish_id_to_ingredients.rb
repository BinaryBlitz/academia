class AddDishIdToIngredients < ActiveRecord::Migration[5.0]
  def change
    add_reference :ingredients, :dish, foreign_key: true
  end
end
