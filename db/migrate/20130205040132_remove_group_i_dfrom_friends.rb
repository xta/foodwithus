class RemoveGroupIDfromFriends < ActiveRecord::Migration
  def up
    remove_column :friends, :group_id
  end

  def down
    add_column :friends, :group_id, :integer
  end
end
