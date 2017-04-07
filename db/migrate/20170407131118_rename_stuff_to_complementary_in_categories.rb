class RenameStuffToComplementaryInCategories < ActiveRecord::Migration[5.0]
  def change
    rename_column :categories, :stuff, :complementary
  end
end
