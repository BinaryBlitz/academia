class DropDays < ActiveRecord::Migration[5.0]
  def change
    drop_table :days
  end
end
