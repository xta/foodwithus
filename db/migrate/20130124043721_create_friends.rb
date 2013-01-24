class CreateFriends < ActiveRecord::Migration
  def change
    create_table :friends do |t|
      t.integer :uid
      t.string :first_name
      t.string :last_name
      t.string :relationship
      t.string :photo_prefix
      t.string :photo_suffix
      t.string :email
      t.string :homecity

      t.timestamps
    end
  end
end
