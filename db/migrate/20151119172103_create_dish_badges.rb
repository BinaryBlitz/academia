class CreateDishBadges < ActiveRecord::Migration
  def change
    create_table :dish_badges do |t|
      t.belongs_to :dish, index: true
      t.belongs_to :badge, index: true

      t.timestamps null: false
    end
  end
end
