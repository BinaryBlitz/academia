class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :phone_number
      t.string :password_digest
      t.string :vk_id
      t.string :fb_id

      t.timestamps null: false
    end
  end
end
