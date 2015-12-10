class CreateDeliveryPoints < ActiveRecord::Migration
  def change
    create_table :delivery_points do |t|
      t.float :latitude
      t.float :longitude

      t.timestamps null: false
    end
  end
end
