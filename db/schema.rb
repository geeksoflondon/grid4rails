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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20111008222322) do

  create_table "rooms", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "short_code"
    t.integer  "weighting"
    t.integer  "capacity"
    t.string   "facilities"
  end

  add_index "rooms", ["id"], :name => "index_rooms_on_id"

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "slots", :force => true do |t|
    t.integer  "room_id"
    t.integer  "timeslot_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "talk_id"
    t.boolean  "locked",      :default => false
    t.boolean  "global",      :default => false
  end

  add_index "slots", ["global"], :name => "index_slots_on_global"
  add_index "slots", ["id"], :name => "index_slots_on_id"
  add_index "slots", ["locked"], :name => "index_slots_on_locked"
  add_index "slots", ["room_id"], :name => "index_slots_on_room_id"
  add_index "slots", ["talk_id"], :name => "index_slots_on_talk_id"
  add_index "slots", ["timeslot_id"], :name => "index_slots_on_timeslot_id"

  create_table "talks", :force => true do |t|
    t.string   "title"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "speaker"
  end

  add_index "talks", ["id"], :name => "index_talks_on_id"

  create_table "timeslots", :force => true do |t|
    t.string   "name"
    t.datetime "start"
    t.datetime "end"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "assign_slots", :default => true
    t.string   "description"
  end

  add_index "timeslots", ["id"], :name => "index_timeslots_on_id"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "website"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email"
    t.string   "encrypted_password", :limit => 128
    t.string   "salt",               :limit => 128
    t.string   "confirmation_token", :limit => 128
    t.string   "remember_token",     :limit => 128
  end

  add_index "users", ["email"], :name => "index_users_on_email"
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

end
