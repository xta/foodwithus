class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.integer :uid
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :token

      t.timestamps
    end
  end
end
