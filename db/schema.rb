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

ActiveRecord::Schema.define(:version => 20121004153000) do

  create_table "categories", :force => true do |t|
    t.string "name"
    t.string "type"
  end

  add_index "categories", ["name"], :name => "index_categories_on_name"
  add_index "categories", ["type"], :name => "index_categories_on_type"

  create_table "families", :force => true do |t|
    t.string   "name",       :null => false
    t.integer  "head_id",    :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "families", ["head_id"], :name => "index_families_on_head_id"
  add_index "families", ["name"], :name => "index_families_on_name"

  create_table "invites", :force => true do |t|
    t.integer  "family_id",                           :null => false
    t.integer  "user_id"
    t.string   "email"
    t.boolean  "is_sent_to_email", :default => false, :null => false
    t.integer  "created_by",                          :null => false
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
  end

  add_index "invites", ["created_by"], :name => "index_invites_on_created_by"
  add_index "invites", ["family_id", "user_id"], :name => "index_invites_on_family_id_and_user_id", :unique => true
  add_index "invites", ["family_id"], :name => "index_invites_on_family_id"
  add_index "invites", ["user_id"], :name => "index_invites_on_user_id"

  create_table "operations", :force => true do |t|
    t.string   "type"
    t.integer  "amount"
    t.integer  "category_id"
    t.integer  "user_id"
    t.integer  "created_by",  :null => false
    t.text     "comment"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "family_id",   :null => false
  end

  add_index "operations", ["category_id"], :name => "index_operations_on_category_id"
  add_index "operations", ["created_by"], :name => "index_operations_on_created_by"
  add_index "operations", ["type"], :name => "index_operations_on_type"
  add_index "operations", ["user_id"], :name => "index_operations_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "login"
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "family_id"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["family_id"], :name => "index_users_on_family_id"
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
