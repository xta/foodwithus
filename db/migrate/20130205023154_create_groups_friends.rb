class CreateGroupsFriends < ActiveRecord::Migration
  def change
    create_table :groups_friends do |t|

      t.timestamps
    end
  end
end
