class CreateFriends < ActiveRecord::Migration
  def change
    create_table :friends do |t|
      t.string :first_name, null: false
      t.string :last_location, null:false

      t.timestamps null:false
    end
  end
end
