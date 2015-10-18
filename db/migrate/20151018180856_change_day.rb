class ChangeDay < ActiveRecord::Migration
  def change
    remove_column :days, :day_of_week, :integer
    add_column :days, :date, :date
  end
end
