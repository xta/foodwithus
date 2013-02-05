class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :fsq_id
      t.string :name
      t.string :plural_name
      t.string :short_name

      t.timestamps
    end
  end
end
