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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20151009071352) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "categories", ["name"], name: "index_categories_on_name", unique: true, using: :btree

  create_table "items", force: :cascade do |t|
    t.string   "name"
    t.integer  "quantity"
    t.integer  "edizm_del"
    t.string   "gost"
    t.string   "description"
    t.integer  "tender_id"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "winner_id"
    t.string   "measure_unit", default: "шт.", null: false
  end

  create_table "managers", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.string   "password_digest_del"
    t.string   "remember_token_del"
    t.boolean  "admin_del",           default: false
    t.string   "crypted_password",    default: "",     null: false
    t.string   "password_salt",       default: "",     null: false
    t.string   "persistence_token",   default: "",     null: false
    t.string   "single_access_token", default: "",     null: false
    t.string   "perishable_token",    default: "",     null: false
    t.string   "role",                default: "read"
    t.integer  "login_count",         default: 0,      null: false
    t.integer  "failed_login_count",  default: 0,      null: false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
  end

  add_index "managers", ["email"], name: "index_managers_on_email", unique: true, using: :btree
  add_index "managers", ["remember_token_del"], name: "index_managers_on_remember_token_del", using: :btree

  create_table "measure_units", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "measure_units", ["name"], name: "index_measure_units_on_name", unique: true, using: :btree

  create_table "statuses_del", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "statuses_del", ["name"], name: "index_statuses_del_on_name", unique: true, using: :btree

  create_table "tender_categories", force: :cascade do |t|
    t.integer "tender_id"
    t.integer "category_id"
  end

  add_index "tender_categories", ["tender_id", "category_id"], name: "index_tender_categories_on_tender_id_and_category_id", unique: true, using: :btree

  create_table "tenders", force: :cascade do |t|
    t.string   "name"
    t.integer  "category_id_del"
    t.integer  "status_id",        default: 1
    t.string   "uslovie"
    t.string   "dopuslovie"
    t.datetime "data_start"
    t.datetime "data_end"
    t.integer  "manager_id"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.string   "fls_file_name"
    t.string   "fls_content_type"
    t.integer  "fls_file_size"
    t.datetime "fls_updated_at"
    t.integer  "etap",             default: 1
  end

  create_table "user_categories", force: :cascade do |t|
    t.integer "user_id"
    t.integer "category_id"
  end

  add_index "user_categories", ["user_id", "category_id"], name: "index_user_categories_on_user_id_and_category_id", unique: true, using: :btree

  create_table "user_items", force: :cascade do |t|
    t.decimal  "price"
    t.decimal  "first_price"
    t.integer  "delivery"
    t.string   "comm"
    t.integer  "user_tender_id"
    t.integer  "item_id"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.boolean  "selected_del",             default: false
    t.decimal  "first_price_second_stage"
    t.decimal  "total_price"
  end

  create_table "user_tenders", force: :cascade do |t|
    t.string   "description"
    t.string   "status"
    t.integer  "tender_id"
    t.integer  "user_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name",                                  null: false
    t.string   "crypted_password",                      null: false
    t.string   "password_salt",                         null: false
    t.string   "email",                                 null: false
    t.string   "persistence_token",                     null: false
    t.string   "single_access_token",                   null: false
    t.string   "perishable_token",                      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "company"
    t.string   "function"
    t.string   "phone"
    t.string   "adds"
    t.string   "www"
    t.integer  "category_id_del"
    t.string   "file_nds_file_name"
    t.string   "file_nds_content_type"
    t.integer  "file_nds_file_size"
    t.datetime "file_nds_updated_at"
    t.string   "file_reg_file_name"
    t.string   "file_reg_content_type"
    t.integer  "file_reg_file_size"
    t.datetime "file_reg_updated_at"
    t.boolean  "active",                default: false, null: false
    t.integer  "login_count",           default: 0,     null: false
    t.integer  "failed_login_count",    default: 0,     null: false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["perishable_token"], name: "index_users_on_perishable_token", using: :btree

end
