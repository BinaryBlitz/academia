class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.text :address
      t.belongs_to :user, index: true

      t.timestamps null: false
    end
  end
end
