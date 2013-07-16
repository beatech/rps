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

ActiveRecord::Schema.define(version: 20130716151228) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "musics", force: true do |t|
    t.string   "title"
    t.integer  "level"
    t.string   "playtype"
    t.string   "difficulty"
    t.integer  "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "powers", force: true do |t|
    t.string   "score8"
    t.string   "title8"
    t.string   "score9"
    t.string   "title9"
    t.string   "score10"
    t.string   "title10"
    t.string   "score11"
    t.string   "clear11"
    t.string   "score12"
    t.string   "clear12"
    t.string   "score_total"
    t.string   "clear_total"
    t.string   "iidxid"
    t.date     "date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "scores", force: true do |t|
    t.string   "title"
    t.string   "playtype"
    t.string   "difficulty"
    t.string   "iidxid"
    t.integer  "exscore"
    t.integer  "bp"
    t.string   "rate"
    t.string   "clear"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "iidxid"
    t.string   "djname"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
