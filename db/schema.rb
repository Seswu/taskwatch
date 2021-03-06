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

ActiveRecord::Schema.define(version: 20160317142411) do

  create_table "logs", force: :cascade do |t|
    t.string   "taskname",   limit: 255
    t.datetime "start"
    t.datetime "stop"
    t.boolean  "active"
    t.text     "settings"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "session_id"
  end

  add_index "logs", ["session_id"], name: "index_logs_on_session_id"

  create_table "sessions", force: :cascade do |t|
    t.string   "token_id",   limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "tasks", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.text     "settings"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "session_id"
    t.datetime "activated"
  end

  add_index "tasks", ["session_id"], name: "index_tasks_on_session_id"

end
