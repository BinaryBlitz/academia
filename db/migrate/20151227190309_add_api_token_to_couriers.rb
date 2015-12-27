class AddApiTokenToCouriers < ActiveRecord::Migration
  def change
    add_column :couriers, :api_token, :string
  end
end
