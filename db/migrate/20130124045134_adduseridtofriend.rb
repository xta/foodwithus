class Adduseridtofriend < ActiveRecord::Migration
  def change
    add_column :friends, :user_id, :integer
  end
end
