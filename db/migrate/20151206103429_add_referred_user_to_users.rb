class AddReferredUserToUsers < ActiveRecord::Migration
  def change
    add_reference :users, :referred_user, index: true
  end
end
