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

ActiveRecord::Schema.define(version: 20150617125341) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authors", force: :cascade do |t|
    t.string   "firstname"
    t.string   "lastname"
    t.text     "biography"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "books", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.decimal  "price",       precision: 5, scale: 2
    t.integer  "stock"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "books", ["title"], name: "index_books_on_title", unique: true, using: :btree

  create_table "categories", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "categories", ["title"], name: "index_categories_on_title", unique: true, using: :btree

  create_table "customers", force: :cascade do |t|
    t.string   "email"
    t.string   "password_digest"
    t.string   "firstname"
    t.string   "lastname"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "customers", ["email"], name: "index_customers_on_email", unique: true, using: :btree

  create_table "ratings", force: :cascade do |t|
    t.integer  "score"
    t.text     "review"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
