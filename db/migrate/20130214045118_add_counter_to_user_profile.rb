class AddCounterToUserProfile < ActiveRecord::Migration
  def change
    add_column :friend_profiles, :count, :integer
  end
end
