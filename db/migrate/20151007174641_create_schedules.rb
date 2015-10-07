class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      t.belongs_to :day, index: true
      t.belongs_to :dish, index: true

      t.timestamps null: false
    end
  end
end
