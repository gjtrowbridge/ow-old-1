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

ActiveRecord::Schema.define(:version => 20110716082407) do

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
    t.string   "username",        :limit => 50,                    :null => false
    t.string   "email",                         :default => ""
    t.string   "hashed_password",                                  :null => false
    t.string   "salt"
    t.boolean  "is_admin",                      :default => false
    t.boolean  "activated",                     :default => false
    t.string   "activation_key"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
