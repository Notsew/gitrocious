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

ActiveRecord::Schema.define(version: 20141008015247) do

  create_table "groups", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "groups_repos", id: false, force: true do |t|
    t.integer "group_id", null: false
    t.integer "repo_id",  null: false
  end

  add_index "groups_repos", ["group_id", "repo_id"], name: "index_groups_repos_on_group_id_and_repo_id"
  add_index "groups_repos", ["repo_id", "group_id"], name: "index_groups_repos_on_repo_id_and_group_id"

  create_table "groups_users", id: false, force: true do |t|
    t.integer "group_id", null: false
    t.integer "user_id",  null: false
  end

  add_index "groups_users", ["group_id", "user_id"], name: "index_groups_users_on_group_id_and_user_id"
  add_index "groups_users", ["user_id", "group_id"], name: "index_groups_users_on_user_id_and_group_id"

  create_table "hooks", force: true do |t|
    t.string   "type"
    t.string   "text"
    t.integer  "repo_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "hooks", ["repo_id"], name: "index_hooks_on_repo_id"
  add_index "hooks", ["type"], name: "index_hooks_on_type"

  create_table "keys", force: true do |t|
    t.string   "value"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "keys", ["user_id"], name: "index_keys_on_user_id"
  add_index "keys", ["value"], name: "index_keys_on_value"

  create_table "repos", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "repos", ["name"], name: "index_repos_on_name"

  create_table "repos_users", id: false, force: true do |t|
    t.integer "repo_id", null: false
    t.integer "user_id", null: false
  end

  add_index "repos_users", ["repo_id", "user_id"], name: "index_repos_users_on_repo_id_and_user_id"
  add_index "repos_users", ["user_id", "repo_id"], name: "index_repos_users_on_user_id_and_repo_id"

  create_table "users", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["name"], name: "index_users_on_name"

end
