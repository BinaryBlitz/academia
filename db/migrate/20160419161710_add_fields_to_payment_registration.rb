class AddFieldsToPaymentRegistration < ActiveRecord::Migration
  def change
    add_column :payment_registrations, :binding_id, :string
    add_column :payment_registrations, :card_number, :string
  end
end
