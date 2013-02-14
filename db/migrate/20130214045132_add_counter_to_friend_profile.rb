class AddCounterToFriendProfile < ActiveRecord::Migration
  def change
    add_column :user_profiles, :count, :integer
  end
end
