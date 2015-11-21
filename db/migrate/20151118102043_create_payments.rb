class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.integer :price, null: false
      t.integer :order_id, null: false
      t.string :alfa_order_id
      t.string :alfa_form_url
      t.boolean :payed
      t.boolean :use_binding

      t.timestamps null: false
    end

    add_index :payments, :order_id
  end
end