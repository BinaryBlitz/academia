class CreateDishIngredients < ActiveRecord::Migration
  def change
    drop_table :dishes_ingredients
    create_table :dish_ingredients do |t|
      t.belongs_to :dish, index: true
      t.belongs_to :ingredient, index: true

      t.timestamps null: false
    end
  end
end
