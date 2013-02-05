class AddFriendsProfile < ActiveRecord::Migration

  def change
    create_table :friend_profiles do |t|
      t.integer :friend_id
      t.integer :category_id

      t.timestamps
    end
  end

end
