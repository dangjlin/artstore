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

ActiveRecord::Schema.define(version: 20151022092359) do

  create_table "cart_items", force: :cascade do |t|
    t.integer  "cart_id"
    t.integer  "product_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "quantity",   default: 1
  end

  create_table "carts", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "consults", force: :cascade do |t|
    t.date     "check_date1"
    t.string   "check_date2"
    t.string   "check_type"
    t.string   "doc_name"
    t.string   "patient_no_string"
    t.integer  "patient_no_only"
    t.string   "time_slot"
    t.string   "room_no"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "futurequotes", force: :cascade do |t|
    t.date     "check_date"
    t.string   "commodity_type"
    t.float    "open_price"
    t.float    "highest_price"
    t.float    "lowest_price"
    t.float    "close_price"
    t.float    "volume"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "futurevolumes", force: :cascade do |t|
    t.date     "check_date"
    t.string   "commodity_type"
    t.integer  "foreign_unsettle_volume"
    t.integer  "total_unsettle_volume"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "order_infos", force: :cascade do |t|
    t.integer  "order_id"
    t.string   "billing_name",     limit: 255
    t.string   "billing_address",  limit: 255
    t.string   "shipping_name",    limit: 255
    t.string   "shipping_address", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "order_items", force: :cascade do |t|
    t.string   "product_name", limit: 255
    t.float    "price"
    t.integer  "quantity"
    t.integer  "order_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "orders", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "total",                      default: 0
    t.boolean  "paid",                       default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "token",          limit: 255
    t.string   "payment_method", limit: 255
    t.string   "aasm_state",     limit: 255, default: "order_placed"
  end

  add_index "orders", ["aasm_state"], name: "index_orders_on_aasm_state"
  add_index "orders", ["token"], name: "index_orders_on_token"

  create_table "photos", force: :cascade do |t|
    t.integer  "product_id"
    t.string   "image",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "products", force: :cascade do |t|
    t.string   "title",       limit: 255
    t.text     "description"
    t.integer  "quantity",                default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "price",                   default: 0.0
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name",          limit: 255
    t.integer  "resource_id"
    t.string   "resource_type", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
  add_index "roles", ["name"], name: "index_roles_on_name"

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "",    null: false
    t.string   "encrypted_password",     limit: 255, default: "",    null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_admin",                           default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "users_roles", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"

end
