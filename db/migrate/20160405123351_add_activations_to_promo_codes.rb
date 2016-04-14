class AddActivationsToPromoCodes < ActiveRecord::Migration
  def change
    add_column :promo_codes, :activations, :integer, default: 0
  end
end
