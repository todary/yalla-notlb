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

ActiveRecord::Schema.define(version: 20160520120218) do

  create_table "friends", force: :cascade do |t|
    t.integer  "friend_id",  limit: 4
    t.integer  "user_id",    limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "friends", ["user_id"], name: "index_friends_on_user_id", using: :btree

  create_table "group_members", force: :cascade do |t|
    t.integer  "group_id",   limit: 4
    t.integer  "user_id",    limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "group_members", ["group_id"], name: "index_group_members_on_group_id", using: :btree
  add_index "group_members", ["user_id"], name: "index_group_members_on_user_id", using: :btree

  create_table "groups", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.integer  "user_id",    limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "groups", ["name"], name: "index_groups_on_name", unique: true, using: :btree
  add_index "groups", ["user_id"], name: "index_groups_on_user_id", using: :btree

  create_table "notifications", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.text     "content",    limit: 65535
    t.boolean  "status"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "notifications", ["user_id"], name: "index_notifications_on_user_id", using: :btree

  create_table "order_details", force: :cascade do |t|
    t.string   "item",       limit: 255
    t.integer  "amount",     limit: 4
    t.float    "price",      limit: 24
    t.text     "comment",    limit: 65535
    t.integer  "order_id",   limit: 4
    t.integer  "user_id",    limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "order_details", ["order_id"], name: "index_order_details_on_order_id", using: :btree
  add_index "order_details", ["user_id"], name: "index_order_details_on_user_id", using: :btree

  create_table "order_members", force: :cascade do |t|
    t.integer  "order_id",    limit: 4
    t.integer  "user_id",     limit: 4
    t.boolean  "status_user"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "order_members", ["order_id"], name: "index_order_members_on_order_id", using: :btree
  add_index "order_members", ["user_id"], name: "index_order_members_on_user_id", using: :btree

  create_table "orders", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "resturant",  limit: 255
    t.boolean  "status"
    t.integer  "user_id",    limit: 4
    t.string   "image",      limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "orders", ["user_id"], name: "index_orders_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name",                   limit: 255
    t.string   "email",                  limit: 255
    t.string   "password",               limit: 255
    t.string   "image",                  limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.string   "provider",               limit: 255
    t.string   "uid",                    limit: 255
    t.string   "avatar_file_name",       limit: 255
    t.string   "avatar_content_type",    limit: 255
    t.integer  "avatar_file_size",       limit: 4
    t.datetime "avatar_updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "friends", "users"
  add_foreign_key "group_members", "groups"
  add_foreign_key "group_members", "users"
  add_foreign_key "groups", "users"
  add_foreign_key "notifications", "users"
  add_foreign_key "order_details", "orders", on_update: :cascade, on_delete: :cascade
  add_foreign_key "order_details", "users", on_update: :cascade, on_delete: :cascade
  add_foreign_key "order_members", "orders"
  add_foreign_key "order_members", "users"
  add_foreign_key "orders", "users", on_update: :cascade, on_delete: :cascade
end
