class AddDeviceTokenToCouriers < ActiveRecord::Migration
  def change
    add_column :couriers, :device_token, :string
    add_column :couriers, :platform, :string
  end
end
