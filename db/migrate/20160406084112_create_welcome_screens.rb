class CreateWelcomeScreens < ActiveRecord::Migration
  def change
    create_table :welcome_screens do |t|
      t.string :image_open
      t.boolean :image_open_enabled, default: false
      t.string :image_closed
      t.boolean :image_closed_enabled, default: false

      t.timestamps null: false
    end
  end
end
