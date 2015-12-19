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

ActiveRecord::Schema.define(version: 20151217042913) do

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "categories_products", id: false, force: :cascade do |t|
    t.integer "product_id"
    t.integer "category_id"
  end

  add_index "categories_products", ["category_id"], name: "index_categories_products_on_category_id"
  add_index "categories_products", ["product_id"], name: "index_categories_products_on_product_id"

  create_table "compositions", force: :cascade do |t|
    t.float    "quantity"
    t.integer  "retail_option_id"
    t.integer  "ingredient_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "compositions", ["ingredient_id"], name: "index_compositions_on_ingredient_id"
  add_index "compositions", ["retail_option_id"], name: "index_compositions_on_retail_option_id"

  create_table "ingredients", force: :cascade do |t|
    t.integer  "product_id"
    t.integer  "supply_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "ingredients", ["product_id"], name: "index_ingredients_on_product_id"
  add_index "ingredients", ["supply_id"], name: "index_ingredients_on_supply_id"

  create_table "products", force: :cascade do |t|
    t.string   "name"
    t.string   "image_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "retail_options", force: :cascade do |t|
    t.string   "name"
    t.string   "short_name"
    t.text     "description"
    t.float    "price"
    t.integer  "product_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "retail_options", ["product_id"], name: "index_retail_options_on_product_id"

  create_table "supplies", force: :cascade do |t|
    t.string   "name"
    t.float    "price"
    t.string   "unity"
    t.float    "stock"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name",                         null: false
    t.string   "password_digest",              null: false
    t.string   "email",                        null: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.string   "auth_token",      default: ""
  end

  add_index "users", ["auth_token"], name: "index_users_on_auth_token", unique: true
  add_index "users", ["email"], name: "index_users_on_email", unique: true

end
