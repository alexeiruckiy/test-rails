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

ActiveRecord::Schema.define(version: 20140617175459) do

  create_table "api_keys", force: true do |t|
    t.string   "token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "api_keys", ["user_id"], name: "index_api_keys_on_user_id"

  create_table "documents", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "user_id"
    t.integer  "pages_count"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "documents", ["user_id"], name: "index_documents_on_user_id"

  create_table "entities", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pages", force: true do |t|
    t.integer  "number"
    t.string   "content"
    t.integer  "document_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "pages", ["document_id"], name: "index_pages_on_document_id"

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "entity_id"
  end

  add_index "users", ["entity_id"], name: "index_users_on_entity_id"

  create_table "validations", force: true do |t|
    t.string   "field"
    t.string   "rule"
    t.string   "message"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "entity_id"
  end

  add_index "validations", ["entity_id"], name: "index_validations_on_entity_id"

end
