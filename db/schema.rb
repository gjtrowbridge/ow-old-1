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

ActiveRecord::Schema.define(:version => 20110802222620) do

  create_table "activities", :force => true do |t|
    t.string   "name",           :limit => 100,                 :null => false
    t.string   "organization",                  :default => ""
    t.text     "description",                                   :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id",                                       :null => false
    t.text     "how_to_sign_up"
  end

  add_index "activities", ["user_id"], :name => "index_activities_on_user_id"

  create_table "costs", :force => true do |t|
    t.float    "dollar_amount",                    :null => false
    t.float    "unit_number",   :default => 1.0,   :null => false
    t.string   "unit_name",     :default => "day", :null => false
    t.integer  "activity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "costs", ["activity_id"], :name => "index_costs_on_activity_id"

  create_table "locations", :force => true do |t|
    t.string   "address",     :null => false
    t.string   "city",        :null => false
    t.text     "note"
    t.integer  "activity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "locations", ["activity_id"], :name => "index_locations_on_activity_id"

  create_table "users", :force => true do |t|
    t.string   "username",               :limit => 50,                  :null => false
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.integer  "failed_attempts",                       :default => 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["unlock_token"], :name => "index_users_on_unlock_token", :unique => true

end
