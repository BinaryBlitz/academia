class CreateEdgePoints < ActiveRecord::Migration
  def change
    create_table :edge_points do |t|
      t.float :latitude
      t.float :longitude

      t.timestamps null: false
    end
  end
end
