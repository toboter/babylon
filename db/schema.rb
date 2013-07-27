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

ActiveRecord::Schema.define(:version => 20130727122115) do

  create_table "areas", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "creator_id"
    t.integer  "updater_id"
  end

  create_table "assets", :force => true do |t|
    t.string   "assetfile"
    t.string   "name"
    t.integer  "parent_id"
    t.string   "content_type"
    t.string   "file_size"
    t.string   "file_name"
    t.integer  "file_author"
    t.datetime "file_datetime"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.integer  "creator_id"
    t.integer  "updater_id"
  end

  create_table "authorships", :force => true do |t|
    t.integer  "person_id"
    t.integer  "reference_id"
    t.integer  "predicate_id"
    t.integer  "position"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.integer  "creator_id"
    t.integer  "updater_id"
  end

  create_table "books", :force => true do |t|
    t.string   "title"
    t.string   "volume"
    t.string   "place"
    t.string   "publisher"
    t.string   "year"
    t.string   "book_type"
    t.boolean  "unpublished"
    t.integer  "serial_id"
    t.string   "book_identifier"
    t.string   "uri"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.integer  "creator_id"
    t.integer  "updater_id"
  end

  create_table "buckets", :force => true do |t|
    t.string   "attachable_type"
    t.integer  "attachable_id"
    t.string   "name"
    t.integer  "cover_asset_id"
    t.boolean  "name_fixed"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.integer  "creator_id"
    t.integer  "updater_id"
  end

  create_table "editorships", :force => true do |t|
    t.integer  "book_id"
    t.integer  "person_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "creator_id"
    t.integer  "updater_id"
  end

  add_index "editorships", ["book_id"], :name => "index_editorships_on_book_id"
  add_index "editorships", ["person_id"], :name => "index_editorships_on_person_id"

  create_table "engagements", :force => true do |t|
    t.integer  "person_id"
    t.datetime "start"
    t.datetime "end"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "creator_id"
    t.integer  "updater_id"
  end

  create_table "groups", :force => true do |t|
    t.string   "name"
    t.integer  "area_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "creator_id"
    t.integer  "updater_id"
  end

  add_index "groups", ["area_id"], :name => "index_groups_on_area_id"

  create_table "memberships", :force => true do |t|
    t.integer  "user_id"
    t.integer  "project_id"
    t.string   "role"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "creator_id"
    t.integer  "updater_id"
  end

  add_index "memberships", ["project_id"], :name => "index_memberships_on_project_id"
  add_index "memberships", ["user_id"], :name => "index_memberships_on_user_id"

  create_table "pailfuls", :force => true do |t|
    t.integer  "asset_id"
    t.integer  "bucket_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "creator_id"
    t.integer  "updater_id"
  end

  add_index "pailfuls", ["asset_id"], :name => "index_pailfuls_on_asset_id"
  add_index "pailfuls", ["bucket_id"], :name => "index_pailfuls_on_bucket_id"

  create_table "people", :force => true do |t|
    t.integer  "user_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "grade"
    t.string   "nickname"
    t.datetime "date_of_birth"
    t.datetime "date_of_death"
    t.string   "profession"
    t.string   "gender"
    t.string   "public_email"
    t.string   "slug"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.integer  "creator_id"
    t.integer  "updater_id"
  end

  add_index "people", ["slug"], :name => "index_people_on_slug", :unique => true

  create_table "projects", :force => true do |t|
    t.string   "name"
    t.integer  "group_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "creator_id"
    t.integer  "updater_id"
  end

  add_index "projects", ["group_id"], :name => "index_projects_on_group_id"

  create_table "references", :force => true do |t|
    t.string   "title"
    t.datetime "original_date"
    t.string   "alternative_author"
    t.string   "slug"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.string   "first_page"
    t.string   "last_page"
    t.integer  "book_id"
    t.string   "uri"
  end

  add_index "references", ["slug"], :name => "index_references_on_slug", :unique => true

  create_table "roles", :force => true do |t|
    t.integer  "user_id"
    t.string   "role"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "creator_id"
    t.integer  "updater_id"
  end

  create_table "serials", :force => true do |t|
    t.string   "name"
    t.string   "shortcut"
    t.string   "serial_identifier"
    t.string   "uri"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.string   "serial_type"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "username"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
