class CreatePaymentRegistrations < ActiveRecord::Migration
  def change
    create_table :payment_registrations do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.string :alfa_order_id
      t.string :alfa_form_url
      t.boolean :paid, default: false

      t.timestamps null: false
    end
  end
end
