class CreateWorkingHours < ActiveRecord::Migration
  def change
    create_table :working_hours do |t|
      t.integer :starts_at
      t.integer :ends_at

      t.timestamps null: false
    end
  end
end
