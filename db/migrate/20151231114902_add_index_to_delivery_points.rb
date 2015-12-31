class AddIndexToDeliveryPoints < ActiveRecord::Migration
  def change
    add_index :delivery_points, [:latitude, :longitude]
  end
end
