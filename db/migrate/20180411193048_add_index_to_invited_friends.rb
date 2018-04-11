class AddIndexToInvitedFriends < ActiveRecord::Migration
  def create
    add_index :invited_friends, [:friend_id, :party_id], unique: true
  end
end
