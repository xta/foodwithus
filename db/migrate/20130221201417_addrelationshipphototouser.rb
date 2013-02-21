class Addrelationshipphototouser < ActiveRecord::Migration
  def change
    add_column :users, :relationship, :string
    add_column :users, :photo_prefix, :string
    add_column :users, :photo_suffix, :string
  end
end
