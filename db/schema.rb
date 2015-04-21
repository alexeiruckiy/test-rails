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

ActiveRecord::Schema.define(version: 20150421174224) do

  create_table "documents", force: true do |t|
    t.string   "name",        null: false
    t.string   "description"
    t.integer  "user_id"
    t.integer  "pages_count"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "entity_id"
  end

  add_index "documents", ["entity_id"], name: "index_documents_on_entity_id"
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

  create_table "roles", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles_users", id: false, force: true do |t|
    t.integer "role_id", null: false
    t.integer "user_id", null: false
  end

  add_index "roles_users", ["role_id", "user_id"], name: "index_roles_users_on_role_id_and_user_id"

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "encrypted_password",   default: "", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "entity_id"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["entity_id"], name: "index_users_on_entity_id"

  create_table "validations", force: true do |t|
    t.string   "field"
    t.string   "rule"
    t.string   "message"
    t.integer  "entity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "validations", ["entity_id"], name: "index_validations_on_entity_id"

end
