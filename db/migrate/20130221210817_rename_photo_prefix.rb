class RenamePhotoPrefix < ActiveRecord::Migration
  def change
    rename_column :users, :photo_prefix, :photo
    rename_column :friends, :photo_prefix, :photo
  end
end
