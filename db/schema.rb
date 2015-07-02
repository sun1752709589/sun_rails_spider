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

ActiveRecord::Schema.define(version: 20150702084756) do

  create_table "articles", force: :cascade do |t|
    t.string   "name",         limit: 255
    t.string   "base_url",     limit: 255
    t.text     "content",      limit: 4294967295
    t.string   "author",       limit: 255
    t.integer  "read_num",     limit: 4
    t.string   "article_type", limit: 255
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  create_table "companies", force: :cascade do |t|
    t.string   "name",             limit: 255
    t.integer  "industry_id",      limit: 4
    t.integer  "nature_id",        limit: 4
    t.integer  "scale_id",         limit: 4
    t.text     "detail_introduce", limit: 65535
    t.string   "website",          limit: 255
    t.string   "zip_code",         limit: 255
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "detail_info_url",  limit: 255
    t.string   "address",          limit: 255
  end

  create_table "industries", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "description", limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "natures", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "description", limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "scales", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "description", limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id",     limit: 4
    t.integer  "company_id", limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "tags", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

end
