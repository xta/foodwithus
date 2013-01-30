class RemoveGroupDescriptionColumn < ActiveRecord::Migration
  def up
    remove_column :groups, :description
  end

  def down
    add_column :groups, :description, :string
  end
end
