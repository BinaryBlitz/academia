class AddAlfaDataToUsers < ActiveRecord::Migration
  def change
    add_column :users, :alfa_binding_id, :string
    add_column :users, :card_number, :string
  end
end
