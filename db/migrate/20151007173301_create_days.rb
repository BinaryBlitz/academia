class CreateDays < ActiveRecord::Migration
  def change
    create_table :days do |t|
      t.integer :day_of_week

      t.timestamps null: false
    end
  end
end
