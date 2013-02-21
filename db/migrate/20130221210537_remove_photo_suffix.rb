class RemovePhotoSuffix < ActiveRecord::Migration
  def up
    remove_column :users, :photo_suffix
    remove_column :friends, :photo_suffix
  end

  def down
    add_column :users, :photo_suffix, :string
    add_column :friends, :photo_suffix, :string
  end
end
