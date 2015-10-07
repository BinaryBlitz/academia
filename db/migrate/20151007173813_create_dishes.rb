class CreateDishes < ActiveRecord::Migration
  def change
    create_table :dishes do |t|
      t.string :name
      t.text :description
      t.integer :price
      t.string :image
      t.boolean :stuff, default: false
      t.boolean :lunch, default: false

      t.timestamps null: false
    end
  end
end
