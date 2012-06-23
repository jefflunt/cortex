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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120623144059) do

  create_table "stats", :force => true do |t|
    t.string  "group"
    t.string  "name"
    t.integer "value", :default => 0
  end

  add_index "stats", ["group"], :name => "index_stats_on_group"

  create_table "thought_histories", :force => true do |t|
    t.integer "thought_id"
    t.text    "text"
  end

  add_index "thought_histories", ["thought_id"], :name => "index_thought_histories_on_thought_id"

  create_table "thought_walls", :force => true do |t|
    t.string   "code"
    t.string   "title"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "custom_layout"
  end

  add_index "thought_walls", ["code"], :name => "index_thought_walls_on_code", :unique => true

  create_table "thoughts", :force => true do |t|
    t.integer  "thought_wall_id"
    t.text     "text"
    t.datetime "created_at",                                                 :null => false
    t.datetime "updated_at",                                                 :null => false
    t.integer  "up_votes",                :default => 0
    t.integer  "down_votes",              :default => 0
    t.integer  "manual_order"
    t.datetime "manual_order_updated_at", :default => '2012-06-08 01:31:34'
  end

  create_table "users", :force => true do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "nickname"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
