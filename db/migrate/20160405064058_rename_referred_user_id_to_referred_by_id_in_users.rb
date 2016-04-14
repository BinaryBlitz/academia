class RenameReferredUserIdToReferredByIdInUsers < ActiveRecord::Migration
  def change
    rename_column :users, :referred_user_id, :referred_by_id
  end
end
