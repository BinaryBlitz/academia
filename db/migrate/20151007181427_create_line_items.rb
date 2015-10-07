class CreateLineItems < ActiveRecord::Migration
  def change
    create_table :line_items do |t|
      t.belongs_to :order, index: true
      t.belongs_to :dish, index: true
      t.integer :quantity, default: 1

      t.timestamps null: false
    end
  end
end
