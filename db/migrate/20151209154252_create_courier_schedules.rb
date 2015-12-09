class CreateCourierSchedules < ActiveRecord::Migration
  def change
    create_table :courier_schedules do |t|
      t.belongs_to :day, index: true
      t.belongs_to :courier, index: true

      t.timestamps null: false
    end
  end
end
