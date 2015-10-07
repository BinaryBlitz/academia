class CreateDishesIngredients < ActiveRecord::Migration
  def change
    create_table :dishes_ingredients, id: false do |t|
      t.belongs_to :dish, index: true
      t.belongs_to :ingredient, index: true
    end
  end
end
