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

ActiveRecord::Schema.define(version: 20170218163445) do

  create_table "api_race_requests", force: :cascade do |t|
    t.integer  "race_id"
    t.integer  "runner_id"
    t.datetime "requested_at"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "api_request_loggers", force: :cascade do |t|
    t.string   "api_request"
    t.string   "api_response"
    t.integer  "api_id"
    t.string   "api_errors"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "code"
    t.string   "message"
  end

  create_table "next_race_loggers", force: :cascade do |t|
    t.string   "error"
    t.datetime "logged_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "race_apis", force: :cascade do |t|
    t.string   "key"
    t.string   "url"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.boolean  "live_update", default: false
  end

  create_table "race_courses", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "race_runners", force: :cascade do |t|
    t.integer  "race_id"
    t.integer  "runner_id"
    t.datetime "requested_at"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "races", force: :cascade do |t|
    t.decimal  "distance",       precision: 5, scale: 2
    t.datetime "time"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.integer  "race_course_id"
    t.datetime "requested_at"
  end

  create_table "runners", force: :cascade do |t|
    t.integer  "number"
    t.string   "horse_name"
    t.string   "jockey_name"
    t.string   "form"
    t.decimal  "odds",        precision: 5, scale: 2
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

end
