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

ActiveRecord::Schema.define(version: 20180227053540) do

  create_table "delayed_jobs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "priority",                 default: 0, null: false
    t.integer  "attempts",                 default: 0, null: false
    t.text     "handler",    limit: 65535,             null: false
    t.text     "last_error", limit: 65535
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree
  end

  create_table "playlist_properties", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id",                     null: false
    t.string   "style",                       null: false
    t.string   "updown",                      null: false
    t.integer  "key"
    t.float    "danceability",     limit: 24
    t.float    "energy",           limit: 24
    t.float    "speechiness",      limit: 24
    t.float    "acousticness",     limit: 24
    t.float    "instrumentalness", limit: 24
    t.float    "liveness",         limit: 24
    t.float    "valence",          limit: 24
    t.integer  "duration_ms"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "track_analyzes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "track_id",                    null: false
    t.integer "key"
    t.float   "danceability",     limit: 24
    t.float   "energy",           limit: 24
    t.float   "speechiness",      limit: 24
    t.float   "acousticness",     limit: 24
    t.float   "instrumentalness", limit: 24
    t.float   "liveness",         limit: 24
    t.float   "valence",          limit: 24
    t.integer "duration_ms"
  end

  create_table "tracks", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name",          null: false
    t.string   "t_id",          null: false
    t.string   "artist_name"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "album_name"
    t.string   "album_id"
    t.string   "album_img_url"
    t.string   "preview_url"
    t.integer  "track_number"
    t.datetime "release_date"
    t.datetime "played_at"
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name",                                 default: "no_name", null: false
    t.datetime "created_at",                                               null: false
    t.datetime "updated_at",                                               null: false
    t.string   "email",                                default: "",        null: false
    t.string   "encrypted_password",                   default: "",        null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                        default: 0,         null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.text     "spo_hash",               limit: 65535
    t.string   "role"
    t.string   "spo_id"
    t.string   "img_url"
    t.string   "playlist_id"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

end
