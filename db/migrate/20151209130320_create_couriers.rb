class CreateCouriers < ActiveRecord::Migration
  def change
    create_table :couriers do |t|
      t.string :name
      t.string :phone_number
      t.string :password_digest
      t.belongs_to :delivery_point, index: true

      t.timestamps null: false
    end
  end
end
