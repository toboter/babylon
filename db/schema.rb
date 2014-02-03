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

ActiveRecord::Schema.define(:version => 20140131164348) do

  create_table "actions", :force => true do |t|
    t.integer  "person_id"
    t.integer  "predicate_id"
    t.date     "actable_date"
    t.string   "actable_type"
    t.integer  "actable_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.integer  "creator_id"
    t.integer  "updater_id"
  end

  add_index "actions", ["person_id"], :name => "index_actions_on_person_id"
  add_index "actions", ["predicate_id"], :name => "index_actions_on_predicate_id"

  create_table "affiliations", :force => true do |t|
    t.integer  "person_id"
    t.integer  "institution_id"
    t.datetime "from"
    t.datetime "to"
    t.boolean  "primary"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "creator_id"
    t.integer  "updater_id"
  end

  add_index "affiliations", ["institution_id"], :name => "index_affiliations_on_institution_id"
  add_index "affiliations", ["person_id"], :name => "index_affiliations_on_person_id"

  create_table "assets", :force => true do |t|
    t.string   "assetfile"
    t.string   "name"
    t.integer  "parent_id"
    t.string   "content_type"
    t.string   "file_size"
    t.string   "file_name"
    t.integer  "file_author"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.string   "md5hash"
    t.text     "caption"
    t.string   "date_taken"
    t.float    "latitude"
    t.float    "longitude"
    t.integer  "width"
    t.integer  "height"
    t.string   "camera"
    t.string   "camera_make"
    t.string   "flash"
    t.string   "focal_length"
    t.string   "exposure"
    t.string   "f_number"
    t.string   "iso"
    t.string   "license"
  end

  create_table "authorships", :force => true do |t|
    t.integer  "person_name_id"
    t.integer  "reference_id"
    t.integer  "predicate_id"
    t.integer  "position"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
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
    t.string   "edition"
    t.string   "abbreviation"
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

  create_table "citations", :force => true do |t|
    t.integer  "reference_id"
    t.string   "ref_target"
    t.integer  "citable_id"
    t.string   "citable_type"
    t.integer  "predicate_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.integer  "creator_id"
    t.integer  "updater_id"
  end

  add_index "citations", ["reference_id"], :name => "index_citations_on_reference_id"

  create_table "clusters", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.integer  "speaker_id"
    t.integer  "cluster_admin_id"
  end

  create_table "collections", :force => true do |t|
    t.integer  "institution_id"
    t.string   "name"
    t.string   "shortcut"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "creator_id"
    t.integer  "updater_id"
  end

  add_index "collections", ["institution_id"], :name => "index_collections_on_institution_id"

  create_table "comment_hierarchies", :id => false, :force => true do |t|
    t.integer "ancestor_id",   :null => false
    t.integer "descendant_id", :null => false
    t.integer "generations",   :null => false
  end

  add_index "comment_hierarchies", ["ancestor_id", "descendant_id", "generations"], :name => "comment_anc_desc_udx", :unique => true
  add_index "comment_hierarchies", ["descendant_id"], :name => "comment_desc_idx"

  create_table "comments", :force => true do |t|
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.text     "content"
    t.integer  "parent_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.integer  "creator_id"
    t.integer  "updater_id"
  end

  create_table "documents", :force => true do |t|
    t.string   "title"
    t.string   "documentable_type"
    t.integer  "documentable_id"
    t.string   "document_type"
    t.text     "content"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.text     "abstract"
  end

  add_index "documents", ["documentable_id", "documentable_type"], :name => "index_documents_on_documentable_id_and_documentable_type"

  create_table "editorships", :force => true do |t|
    t.integer  "book_id"
    t.integer  "person_name_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.integer  "position"
  end

  add_index "editorships", ["book_id"], :name => "index_editorships_on_book_id"
  add_index "editorships", ["person_name_id"], :name => "index_editorships_on_person_id"

  create_table "friendly_id_slugs", :force => true do |t|
    t.string   "slug",                         :null => false
    t.integer  "sluggable_id",                 :null => false
    t.string   "sluggable_type", :limit => 40
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type"], :name => "index_friendly_id_slugs_on_slug_and_sluggable_type", :unique => true
  add_index "friendly_id_slugs", ["sluggable_id"], :name => "index_friendly_id_slugs_on_sluggable_id"
  add_index "friendly_id_slugs", ["sluggable_type"], :name => "index_friendly_id_slugs_on_sluggable_type"

  create_table "groups", :force => true do |t|
    t.string   "name"
    t.integer  "cluster_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.integer  "speaker_id"
    t.integer  "group_admin_id"
  end

  add_index "groups", ["cluster_id"], :name => "index_groups_on_area_id"

  create_table "institution_hierarchies", :id => false, :force => true do |t|
    t.integer "ancestor_id",   :null => false
    t.integer "descendant_id", :null => false
    t.integer "generations",   :null => false
  end

  add_index "institution_hierarchies", ["ancestor_id", "descendant_id", "generations"], :name => "institution_anc_desc_udx", :unique => true
  add_index "institution_hierarchies", ["descendant_id"], :name => "institution_desc_idx"

  create_table "institutions", :force => true do |t|
    t.string   "name"
    t.string   "phone"
    t.string   "fax"
    t.string   "uri"
    t.string   "street"
    t.string   "zip"
    t.string   "city"
    t.string   "country"
    t.integer  "parent_id"
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "slug"
  end

  add_index "institutions", ["slug"], :name => "index_institutions_on_slug", :unique => true

  create_table "item_classification_hierarchies", :id => false, :force => true do |t|
    t.integer "ancestor_id",   :null => false
    t.integer "descendant_id", :null => false
    t.integer "generations",   :null => false
  end

  add_index "item_classification_hierarchies", ["ancestor_id", "descendant_id", "generations"], :name => "item_classification_anc_desc_udx", :unique => true
  add_index "item_classification_hierarchies", ["descendant_id"], :name => "item_classification_desc_idx"

  create_table "item_classifications", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "parent_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "creator_id"
    t.integer  "updater_id"
  end

  create_table "items", :force => true do |t|
    t.integer  "collection_id"
    t.string   "inventory_number"
    t.string   "inventory_number_index"
    t.datetime "accession_date"
    t.integer  "context_id"
    t.string   "title"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.integer  "classification_id"
  end

  add_index "items", ["collection_id"], :name => "index_items_on_collection_id"

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

  create_table "pages", :force => true do |t|
    t.string   "permalink"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "creator_id"
    t.integer  "updater_id"
  end

  add_index "pages", ["permalink"], :name => "index_pages_on_permalink"

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
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.string   "phone"
    t.string   "fax"
    t.string   "uri"
    t.boolean  "show_inst_address"
  end

  add_index "people", ["slug"], :name => "index_people_on_slug", :unique => true

  create_table "person_names", :force => true do |t|
    t.integer  "person_id"
    t.string   "first_name"
    t.string   "last_name"
    t.boolean  "primary"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "creator_id"
    t.integer  "updater_id"
  end

  create_table "predicates", :force => true do |t|
    t.string   "name"
    t.string   "inverse_name"
    t.text     "description"
    t.string   "scope_type"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.integer  "creator_id"
    t.integer  "updater_id"
  end

  create_table "projects", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.integer  "projectable_id"
    t.string   "projectable_type"
  end

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
    t.boolean  "babylon_specific"
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

  create_table "tag_hierarchies", :id => false, :force => true do |t|
    t.integer "ancestor_id",   :null => false
    t.integer "descendant_id", :null => false
    t.integer "generations",   :null => false
  end

  add_index "tag_hierarchies", ["ancestor_id", "descendant_id", "generations"], :name => "tag_anc_desc_udx", :unique => true
  add_index "tag_hierarchies", ["descendant_id"], :name => "tag_desc_idx"

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.integer  "creator_id"
    t.integer  "updater_id"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"

  create_table "tags", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.integer  "parent_id"
  end

  create_table "todo_dependencies", :force => true do |t|
    t.integer  "todo_id"
    t.integer  "depends_on_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.integer  "creator_id"
    t.integer  "updater_id"
  end

  add_index "todo_dependencies", ["todo_id"], :name => "index_todo_dependencies_on_todo_id"

  create_table "todos", :force => true do |t|
    t.string   "name"
    t.date     "due_to"
    t.integer  "project_id"
    t.integer  "assigned_id"
    t.boolean  "completed"
    t.date     "starts_at"
    t.integer  "depends_on"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "creator_id"
    t.integer  "updater_id"
  end

  add_index "todos", ["project_id"], :name => "index_todos_on_project_id"

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
