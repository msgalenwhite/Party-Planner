class ChangeFriendsName < ActiveRecord::Migration
  def change
    rename_column :friends, :last_location, :last_name
  end
end
