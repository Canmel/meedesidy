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

ActiveRecord::Schema.define(version: 20170306120715) do

  create_table "budgets", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cars", force: :cascade do |t|
    t.string   "car_no",         limit: 255
    t.string   "vin",            limit: 255
    t.string   "color",          limit: 255
    t.integer  "geren_id",       limit: 4
    t.integer  "status",         limit: 4,   default: 1
    t.integer  "creater_id",     limit: 4
    t.integer  "updater_id",     limit: 4
    t.integer  "company_id",     limit: 4
    t.integer  "driver_id",      limit: 4
    t.integer  "operate_type",   limit: 4,   default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "distance",       limit: 4,   default: 0
    t.float    "balance",        limit: 53,  default: 0.0
    t.integer  "charge_rule_id", limit: 4
    t.integer  "change_status",  limit: 4,   default: 0
  end

  create_table "change_records", force: :cascade do |t|
    t.integer  "station_id",      limit: 4
    t.integer  "drive_distance",  limit: 4,  default: 0
    t.integer  "charge_distance", limit: 4,  default: 0
    t.integer  "total_distance",  limit: 4,  default: 0
    t.integer  "company_id",      limit: 4
    t.integer  "driver_id",       limit: 4
    t.integer  "car_id",          limit: 4
    t.integer  "change_count",    limit: 4,  default: 1
    t.float    "expend_balance",  limit: 24, default: 0.0
    t.float    "expend_gift",     limit: 24, default: 0.0
    t.float    "expend_count",    limit: 24, default: 0.0
    t.integer  "status",          limit: 4,  default: 1
    t.integer  "change_type",     limit: 4,  default: 1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "companies", force: :cascade do |t|
    t.string   "name",          limit: 255
    t.string   "addr",          limit: 255
    t.string   "phone",         limit: 255
    t.string   "contact_name",  limit: 255
    t.string   "contact_phone", limit: 255
    t.string   "sort_name",     limit: 255
    t.integer  "status",        limit: 4,   default: 1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "drivers", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "id_card_no", limit: 255
    t.string   "phone",      limit: 255
    t.string   "entry_time", limit: 255
    t.string   "desc",       limit: 255
    t.integer  "sex",        limit: 4
    t.integer  "status",     limit: 4,   default: 1
    t.integer  "company_id", limit: 4
    t.integer  "updater",    limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "id_card",    limit: 255, default: ""
  end

  create_table "finances", force: :cascade do |t|
    t.float    "fee",         limit: 24,  default: 0.0
    t.integer  "car_id",      limit: 4
    t.integer  "log_type",    limit: 4
    t.string   "account_num", limit: 255
    t.string   "remark",      limit: 255
    t.integer  "operater",    limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "gerens", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.integer  "seat_num",   limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "status",     limit: 4,   default: 1
  end

  create_table "icons", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "code",       limit: 255
    t.integer  "status",     limit: 4,   default: 1
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  create_table "logs", force: :cascade do |t|
    t.integer  "log_type",   limit: 4
    t.integer  "operater",   limit: 4
    t.integer  "status",     limit: 4,   default: 1
    t.integer  "car_id",     limit: 4
    t.integer  "driver_id",  limit: 4
    t.integer  "company_id", limit: 4
    t.string   "remark",     limit: 255, default: ""
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "menus", force: :cascade do |t|
    t.string   "name",          limit: 255
    t.string   "desc",          limit: 255
    t.string   "source",        limit: 255
    t.integer  "parent_id",     limit: 4
    t.integer  "resource_id",   limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "status",        limit: 4
    t.integer  "resource_type", limit: 4
    t.integer  "icon_id",       limit: 4
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name",          limit: 255
    t.integer  "resource_id",   limit: 4
    t.string   "resource_type", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "desc",          limit: 255
    t.integer  "level",         limit: 4
    t.integer  "status",        limit: 4
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
  add_index "roles", ["name"], name: "index_roles_on_name", using: :btree

  create_table "roles_menus", id: false, force: :cascade do |t|
    t.integer "role_id", limit: 4
    t.integer "menu_id", limit: 4
  end

  create_table "settlementers", force: :cascade do |t|
    t.string  "name",          limit: 255
    t.string  "desc",          limit: 255
    t.integer "free_distance", limit: 4,   default: 0
    t.integer "min_distance",  limit: 4,   default: 0
    t.integer "max_distance",  limit: 4,   default: 0
    t.float   "price",         limit: 24,  default: 0.0
    t.integer "charger",       limit: 4,   default: 0
    t.string  "account_num",   limit: 255
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "name",                   limit: 255
    t.string   "group",                  limit: 255
    t.integer  "status",                 limit: 4,   default: 1
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "users_roles", id: false, force: :cascade do |t|
    t.integer "user_id", limit: 4
    t.integer "role_id", limit: 4
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", using: :btree

end
