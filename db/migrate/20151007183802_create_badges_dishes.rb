class CreateBadgesDishes < ActiveRecord::Migration
  def change
    create_table :badges_dishes, id: false do |t|
      t.belongs_to :badge, index: true
      t.belongs_to :dish, index: true
    end
  end
end
