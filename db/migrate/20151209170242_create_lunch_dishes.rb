class CreateLunchDishes < ActiveRecord::Migration
  def change
    create_table :lunch_dishes do |t|
      t.string :name
      t.integer :weight
      t.belongs_to :dish, index: true

      t.timestamps null: false
    end
  end
end
