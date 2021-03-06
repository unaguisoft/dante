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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170803193510) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cities", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "features", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "investment_photos", force: :cascade do |t|
    t.string   "file_uid"
    t.string   "file_name"
    t.integer  "investment_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["investment_id"], name: "index_investment_photos_on_investment_id", using: :btree
  end

  create_table "investments", force: :cascade do |t|
    t.string   "title",                                 null: false
    t.text     "details",                               null: false
    t.string   "address",                               null: false
    t.boolean  "should_display_on_web", default: false
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

  create_table "owners", force: :cascade do |t|
    t.string   "first_name", null: false
    t.string   "last_name",  null: false
    t.string   "phones"
    t.string   "cellphone",  null: false
    t.string   "email",      null: false
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_owners_on_user_id", using: :btree
  end

  create_table "photos", force: :cascade do |t|
    t.string   "file_uid"
    t.string   "file_name"
    t.integer  "property_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "sort_position"
    t.index ["property_id"], name: "index_photos_on_property_id", using: :btree
  end

  create_table "posts", force: :cascade do |t|
    t.string   "title"
    t.string   "subtitle"
    t.text     "body"
    t.string   "image_uid"
    t.string   "image_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "properties", force: :cascade do |t|
    t.integer  "kind",                    limit: 2,                 null: false
    t.integer  "status",                  limit: 2,                 null: false
    t.bigint   "price_in_cents",                                    null: false
    t.integer  "currency",                limit: 2,                 null: false
    t.boolean  "should_display_price",              default: false
    t.bigint   "expenses_cost_in_cents"
    t.integer  "property_status",         limit: 2,                 null: false
    t.integer  "property_kind",           limit: 2,                 null: false
    t.string   "year"
    t.integer  "number_of_floors",        limit: 2
    t.bigint   "built_area"
    t.bigint   "semi_built_area"
    t.bigint   "total_area"
    t.string   "perimeter"
    t.string   "address",                                           null: false
    t.text     "description"
    t.string   "title",                                             null: false
    t.integer  "number_of_rooms",         limit: 2
    t.integer  "number_of_bedrooms",      limit: 2,                 null: false
    t.integer  "number_of_bathrooms",     limit: 2,                 null: false
    t.integer  "number_of_toilets",       limit: 2
    t.boolean  "should_display_on_web",             default: false, null: false
    t.boolean  "should_highlight_on_web",           default: false, null: false
    t.integer  "city_id",                                           null: false
    t.integer  "owner_id",                                          null: false
    t.integer  "user_id"
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.bigint   "open_area"
    t.boolean  "bankable",                          default: false
    t.string   "google_maps_address"
    t.index ["city_id"], name: "index_properties_on_city_id", using: :btree
    t.index ["owner_id"], name: "index_properties_on_owner_id", using: :btree
    t.index ["user_id"], name: "index_properties_on_user_id", using: :btree
  end

  create_table "property_features", force: :cascade do |t|
    t.integer "property_id", null: false
    t.integer "feature_id",  null: false
    t.index ["feature_id"], name: "index_property_features_on_feature_id", using: :btree
    t.index ["property_id"], name: "index_property_features_on_property_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                        null: false
    t.string   "name",                         null: false
    t.string   "crypted_password"
    t.string   "salt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "role",             default: 0
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
  end

  add_foreign_key "investment_photos", "investments"
  add_foreign_key "owners", "users"
  add_foreign_key "photos", "properties"
  add_foreign_key "properties", "cities"
  add_foreign_key "properties", "owners"
  add_foreign_key "properties", "users"
  add_foreign_key "property_features", "features"
  add_foreign_key "property_features", "properties"
end
