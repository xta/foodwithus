# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130225234404) do

  create_table "categories", :force => true do |t|
    t.string   "fsq_id"
    t.string   "name"
    t.string   "plural_name"
    t.string   "short_name"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "categories", ["fsq_id"], :name => "index_categories_on_fsq_id"
  add_index "categories", ["name"], :name => "index_categories_on_name"
  add_index "categories", ["plural_name"], :name => "index_categories_on_plural_name"
  add_index "categories", ["short_name"], :name => "index_categories_on_short_name"

  create_table "friend_profiles", :force => true do |t|
    t.integer  "friend_id"
    t.integer  "category_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "count"
  end

  add_index "friend_profiles", ["category_id"], :name => "index_friend_profiles_on_category_id"
  add_index "friend_profiles", ["friend_id"], :name => "index_friend_profiles_on_friend_id"

  create_table "friends", :force => true do |t|
    t.integer  "uid"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "relationship"
    t.string   "photo"
    t.string   "email"
    t.string   "homecity"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.integer  "user_id"
  end

  add_index "friends", ["first_name"], :name => "index_friends_on_first_name"
  add_index "friends", ["last_name"], :name => "index_friends_on_last_name"
  add_index "friends", ["photo"], :name => "index_friends_on_photo"
  add_index "friends", ["uid"], :name => "index_friends_on_uid"
  add_index "friends", ["user_id"], :name => "index_friends_on_user_id"

  create_table "groups", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "user_id"
  end

  add_index "groups", ["name"], :name => "index_groups_on_name"
  add_index "groups", ["user_id"], :name => "index_groups_on_user_id"

  create_table "groups_friends", :force => true do |t|
    t.integer  "group_id"
    t.integer  "friend_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "groups_friends", ["friend_id"], :name => "index_groups_friends_on_friend_id"
  add_index "groups_friends", ["group_id"], :name => "index_groups_friends_on_group_id"

  create_table "user_profiles", :force => true do |t|
    t.integer  "user_id"
    t.integer  "category_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "count"
  end

  add_index "user_profiles", ["category_id"], :name => "index_user_profiles_on_category_id"
  add_index "user_profiles", ["count"], :name => "index_user_profiles_on_count"
  add_index "user_profiles", ["user_id"], :name => "index_user_profiles_on_user_id"

  create_table "users", :force => true do |t|
    t.integer  "uid"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "token"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.string   "provider"
    t.string   "location"
    t.string   "relationship"
    t.string   "photo"
  end

  add_index "users", ["first_name"], :name => "index_users_on_first_name"
  add_index "users", ["last_name"], :name => "index_users_on_last_name"
  add_index "users", ["photo"], :name => "index_users_on_photo"
  add_index "users", ["token"], :name => "index_users_on_token"
  add_index "users", ["uid"], :name => "index_users_on_uid"

end
