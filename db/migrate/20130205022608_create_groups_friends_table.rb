class CreateGroupsFriendsTable < ActiveRecord::Migration

  def change
    create_table :groups_friends do |t|
      t.integer :group_id
      t.integer :friend_id

      t.timestamps
    end
  end

end
