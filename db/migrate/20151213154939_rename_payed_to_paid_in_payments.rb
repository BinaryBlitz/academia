class RenamePayedToPaidInPayments < ActiveRecord::Migration
  def up
    rename_column :payments, :payed, :paid
  end

  def down
    rename_column :payments, :paid, :payed
  end
end
