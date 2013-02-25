class AddIndicesToTables < ActiveRecord::Migration

  add_index :categories, :fsq_id
  add_index :categories, :name
  add_index :categories, :plural_name
  add_index :categories, :short_name
  # add_index :categories, :created_at
  # add_index :categories, :updated_at

  add_index :friend_profiles, :friend_id
  add_index :friend_profiles, :category_id
  # add_index :friend_profiles, :created_at
  # add_index :friend_profiles, :updated_at
  # add_index :friend_profiles, :count

  add_index :friends, :uid
  add_index :friends, :first_name
  add_index :friends, :last_name
  # add_index :friends, :relationship
  add_index :friends, :photo
  # add_index :friends, :email
  # add_index :friends, :homecity
  # add_index :friends, :created_at
  # add_index :friends, :updated_at
  add_index :friends, :user_id

  add_index :groups, :name
  # add_index :groups, :created_at
  # add_index :groups, :updated_at
  add_index :groups, :user_id

  add_index :groups_friends, :group_id
  add_index :groups_friends, :friend_id
  # add_index :groups_friends, :created_at
  # add_index :groups_friends, :updated_at

  add_index :user_profiles, :user_id
  add_index :user_profiles, :category_id
  # add_index :user_profiles, :created_at
  # add_index :user_profiles, :updated_at
  add_index :user_profiles, :count

  add_index :users, :uid
  add_index :users, :first_name
  add_index :users, :last_name
  # add_index :users, :email
  add_index :users, :token
  # add_index :users, :created_at
  # add_index :users, :updated_at
  # add_index :users, :provider
  # add_index :users, :location
  # add_index :users, :relationship
  add_index :users, :photo

end
