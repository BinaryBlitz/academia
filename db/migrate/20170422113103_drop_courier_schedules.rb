class DropCourierSchedules < ActiveRecord::Migration[5.0]
  def change
    drop_table :courier_schedules
  end
end
