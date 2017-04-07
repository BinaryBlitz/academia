class AddStuffToCategories < ActiveRecord::Migration[5.0]
  def change
    add_column :categories, :stuff, :boolean, default: false
  end
end
