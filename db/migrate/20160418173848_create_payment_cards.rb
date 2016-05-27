class CreatePaymentCards < ActiveRecord::Migration
  def change
    create_table :payment_cards do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.string :number, null: false
      t.string :binding_id, null: false

      t.timestamps null: false
    end
  end
end
