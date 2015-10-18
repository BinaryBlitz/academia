class AddSubtitleToDishes < ActiveRecord::Migration
  def change
    add_column :dishes, :subtitle, :string
  end
end
