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

ActiveRecord::Schema.define(:version => 20141011135619) do

  create_table "actions", :force => true do |t|
    t.integer  "predicate_id"
    t.string   "actable_type"
    t.integer  "actable_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.string   "target"
    t.integer  "source_id"
  end

  add_index "actions", ["predicate_id"], :name => "index_actions_on_predicate_id"

  create_table "activities", :force => true do |t|
    t.integer  "user_id"
    t.string   "action"
    t.integer  "trackable_id"
    t.string   "trackable_type"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.text     "changes_content"
    t.string   "targetable_type"
    t.integer  "targetable_id"
  end

  add_index "activities", ["targetable_id"], :name => "index_activities_on_targetable_id"
  add_index "activities", ["trackable_id"], :name => "index_activities_on_trackable_id"
  add_index "activities", ["user_id"], :name => "index_activities_on_user_id"

  create_table "affiliations", :force => true do |t|
    t.integer  "person_id"
    t.integer  "institution_id"
    t.datetime "from"
    t.datetime "to"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.boolean  "primary"
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
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
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
    t.integer  "copyright_institution_id"
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
    t.text     "description"
    t.text     "contact"
  end

  create_table "collection_field_values", :force => true do |t|
    t.string   "field_value"
    t.integer  "collection_field_id"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.text     "description"
  end

  add_index "collection_field_values", ["collection_field_id"], :name => "index_collection_field_values_on_collection_field_id"

  create_table "collection_fields", :force => true do |t|
    t.string   "field_type"
    t.boolean  "required"
    t.integer  "collection_id"
    t.string   "name"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.integer  "predicate_id"
  end

  add_index "collection_fields", ["collection_id"], :name => "index_collection_fields_on_collection_id"

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
    t.integer  "issue_id"
    t.text     "content"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "creator_id"
    t.integer  "updater_id"
  end

  create_table "documents", :force => true do |t|
    t.string   "title"
    t.string   "documentable_type"
    t.integer  "documentable_id"
    t.string   "document_type"
    t.text     "content"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.text     "abstract"
    t.string   "documentfile"
    t.string   "documentfile_content_type"
    t.string   "documentfile_name"
    t.datetime "documentfile_upload_date"
    t.string   "documentfile_size"
    t.string   "documentfile_md5hash"
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
    t.text     "description"
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

  create_table "issues", :force => true do |t|
    t.string   "name"
    t.integer  "issuable_id"
    t.string   "issuable_type"
    t.boolean  "closed"
    t.integer  "assigned_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.integer  "sequential_id"
  end

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

  create_table "item_connections", :force => true do |t|
    t.integer  "item_id"
    t.integer  "inverse_item_id"
    t.integer  "predicate_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.integer  "creator_id"
    t.integer  "updater_id"
  end

  add_index "item_connections", ["inverse_item_id"], :name => "index_item_connections_on_inverse_item_id"
  add_index "item_connections", ["item_id"], :name => "index_item_connections_on_item_id"
  add_index "item_connections", ["predicate_id"], :name => "index_item_connections_on_predicate_id"

  create_table "items", :force => true do |t|
    t.integer  "collection_id"
    t.integer  "inventory_number"
    t.string   "inventory_number_index"
    t.integer  "context_id"
    t.string   "title"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.integer  "classification_id"
    t.text     "description"
    t.string   "slug"
    t.integer  "excavation_id"
    t.integer  "dissov_id"
    t.integer  "mds_id"
    t.string   "excavation_prefix"
    t.hstore   "properties"
    t.integer  "cover_asset_id"
  end

  add_index "items", ["collection_id"], :name => "index_items_on_collection_id"
  add_index "items", ["properties"], :name => "index_items_on_properties"
  add_index "items", ["slug"], :name => "index_items_on_slug", :unique => true

  create_table "lists", :force => true do |t|
    t.string   "name"
    t.boolean  "forkable"
    t.integer  "forked_from_id"
    t.boolean  "featured"
    t.text     "description"
    t.integer  "project_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.boolean  "accept_duplicates"
  end

  add_index "lists", ["project_id"], :name => "index_lists_on_project_id"

  create_table "locations", :force => true do |t|
    t.string   "address"
    t.float    "latitude"
    t.float    "longitude"
    t.integer  "locatable_id"
    t.string   "locatable_type"
    t.integer  "predicate_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "creator_id"
    t.integer  "updater_id"
  end

  add_index "locations", ["locatable_id", "locatable_type"], :name => "index_locations_on_locatable_id_and_locatable_type"
  add_index "locations", ["predicate_id"], :name => "index_locations_on_predicate_id"

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
    t.text     "cv"
    t.text     "general"
  end

  add_index "people", ["slug"], :name => "index_people_on_slug", :unique => true

  create_table "person_names", :force => true do |t|
    t.integer  "person_id"
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.boolean  "primary"
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
    t.integer  "project_id"
  end

  create_table "project_references", :force => true do |t|
    t.integer  "project_id"
    t.integer  "reference_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.integer  "creator_id"
    t.integer  "updater_id"
  end

  create_table "project_study_field_values", :force => true do |t|
    t.string   "field_value"
    t.text     "description"
    t.integer  "project_study_field_id"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
    t.integer  "creator_id"
    t.integer  "updater_id"
  end

  add_index "project_study_field_values", ["project_study_field_id"], :name => "index_project_study_field_values_on_project_study_field_id"

  create_table "project_study_fields", :force => true do |t|
    t.string   "field_type"
    t.boolean  "required"
    t.integer  "project_id"
    t.string   "name"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.integer  "predicate_id"
  end

  add_index "project_study_fields", ["project_id"], :name => "index_project_study_fields_on_project_id"

  create_table "projects", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.integer  "projectable_id"
    t.string   "projectable_type"
    t.boolean  "show_references"
    t.boolean  "featured"
    t.text     "description"
    t.string   "project_type"
    t.string   "map_type"
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
    t.text     "comment"
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

  create_table "snippets", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "snippet_type"
    t.boolean  "pinned"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.text     "content"
  end

  create_table "source_hierarchies", :id => false, :force => true do |t|
    t.integer "ancestor_id",   :null => false
    t.integer "descendant_id", :null => false
    t.integer "generations",   :null => false
  end

  add_index "source_hierarchies", ["ancestor_id", "descendant_id", "generations"], :name => "source_anc_desc_udx", :unique => true
  add_index "source_hierarchies", ["descendant_id"], :name => "source_desc_idx"

  create_table "sources", :force => true do |t|
    t.integer  "author_id"
    t.string   "source_type"
    t.date     "original_date"
    t.string   "format"
    t.integer  "institution_id"
    t.text     "comment"
    t.integer  "parent_id"
    t.string   "condition"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.string   "name"
  end

  create_table "studies", :force => true do |t|
    t.integer  "list_id"
    t.string   "studyable_type"
    t.integer  "studyable_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.hstore   "properties"
  end

  add_index "studies", ["list_id"], :name => "index_studies_on_list_id"
  add_index "studies", ["properties"], :name => "index_studies_on_properties"

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
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
  end

  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
