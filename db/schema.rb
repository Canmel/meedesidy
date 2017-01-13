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

ActiveRecord::Schema.define(version: 20170113052548) do

  create_table "cars", force: :cascade do |t|
    t.string   "car_no",     limit: 255
    t.string   "vin",        limit: 255
    t.string   "color",      limit: 255
    t.integer  "geren_id",   limit: 4
    t.integer  "status",     limit: 4
    t.integer  "creater_id", limit: 4
    t.integer  "updater_id", limit: 4
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

  create_table "mains", force: :cascade do |t|
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
