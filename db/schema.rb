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

ActiveRecord::Schema.define(version: 20150629131752) do

  create_table "active_member_numbers", force: :cascade do |t|
    t.string   "date_str",      limit: 255
    t.integer  "active_number", limit: 4
    t.string   "description",   limit: 255
    t.integer  "sex",           limit: 1
    t.integer  "channel_id",    limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "active_member_numbers", ["channel_id"], name: "index_active_member_numbers_on_channel_id", using: :btree
  add_index "active_member_numbers", ["date_str"], name: "index_active_member_numbers_on_date_str", using: :btree

  create_table "albums", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.integer  "member_id",  limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "albums", ["member_id"], name: "index_albums_on_member_id", using: :btree

  create_table "ali_pays", force: :cascade do |t|
    t.integer  "product_id",          limit: 4
    t.integer  "pay_id",              limit: 4
    t.string   "service",             limit: 255
    t.string   "v",                   limit: 50
    t.string   "sec_id",              limit: 50
    t.string   "sign",                limit: 1200
    t.string   "payment_type",        limit: 255
    t.string   "subject",             limit: 255
    t.string   "trade_no",            limit: 255
    t.string   "buyer_email",         limit: 255
    t.datetime "gmt_create"
    t.string   "notify_type",         limit: 50
    t.integer  "quantify",            limit: 4
    t.string   "out_trade_no",        limit: 255
    t.datetime "notify_time"
    t.string   "seller_id",           limit: 255
    t.string   "trade_status",        limit: 50
    t.string   "is_total_fee_adjust", limit: 50
    t.decimal  "total_fee",                        precision: 8, scale: 2, default: 0.0
    t.datetime "gmt_payment"
    t.string   "seller_email",        limit: 255
    t.datetime "gmt_close"
    t.decimal  "price",                            precision: 8, scale: 2, default: 0.0
    t.string   "buyer_id",            limit: 255
    t.string   "notify_id",           limit: 255
    t.string   "use_coupon",          limit: 50
    t.string   "refund_status",       limit: 50
    t.datetime "gmt_refund"
    t.datetime "created_at",                                                             null: false
    t.datetime "updated_at",                                                             null: false
  end

  create_table "answer_tpls", force: :cascade do |t|
    t.integer  "question_tpl_id", limit: 4
    t.integer  "tag_id",          limit: 4
    t.string   "name",            limit: 255
    t.string   "notes",           limit: 255
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.datetime "deleted_at"
  end

  add_index "answer_tpls", ["deleted_at"], name: "index_answer_tpls_on_deleted_at", using: :btree

  create_table "applications", force: :cascade do |t|
    t.string   "name",                limit: 255
    t.string   "api_key",             limit: 255
    t.string   "secret_key",          limit: 255
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "getui_app_id",        limit: 255
    t.string   "getui_app_key",       limit: 255
    t.string   "getui_master_secret", limit: 255
    t.string   "getui_app_secret",    limit: 255
  end

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

  create_table "bucket_actions", force: :cascade do |t|
    t.integer  "bucket_id",   limit: 4
    t.string   "name",        limit: 255
    t.string   "description", limit: 255
    t.string   "status",      limit: 11,  default: "inactivated"
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
  end

  add_index "bucket_actions", ["bucket_id"], name: "index_bucket_actions_on_bucket_id", using: :btree
  add_index "bucket_actions", ["status"], name: "index_bucket_actions_on_status", using: :btree

  create_table "buckets", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "description", limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "channels", force: :cascade do |t|
    t.string   "name",              limit: 255
    t.string   "value",             limit: 255
    t.datetime "created_at",                                            null: false
    t.datetime "updated_at",                                            null: false
    t.decimal  "price",                         precision: 5, scale: 2
    t.decimal  "actual_earn_money",             precision: 8, scale: 2
    t.decimal  "deduction_ratio",               precision: 4, scale: 2
  end

  create_table "cost_records", force: :cascade do |t|
    t.integer  "member_id",  limit: 4
    t.integer  "sku_type",   limit: 4
    t.integer  "sku_count",  limit: 4
    t.integer  "sku_unit",   limit: 4
    t.string   "notes",      limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "kuaiqian_pays", force: :cascade do |t|
    t.integer  "product_id",       limit: 4
    t.integer  "pay_id",           limit: 4
    t.string   "merchant_acct_id", limit: 255
    t.string   "version",          limit: 255
    t.string   "language",         limit: 255
    t.string   "sign_type",        limit: 255
    t.string   "pay_type",         limit: 255
    t.string   "bank_id",          limit: 255
    t.string   "order_id",         limit: 255
    t.string   "order_time",       limit: 255
    t.integer  "order_amount",     limit: 4
    t.string   "bind_card",        limit: 255
    t.string   "bind_mobile",      limit: 255
    t.string   "deal_id",          limit: 255
    t.string   "bank_deal_id",     limit: 255
    t.string   "deal_time",        limit: 255
    t.integer  "pay_amount",       limit: 4
    t.integer  "fee",              limit: 4
    t.string   "ext1",             limit: 255
    t.string   "pay_result",       limit: 255
    t.string   "err_code",         limit: 255
    t.text     "sign_sg",          limit: 65535
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "sign",             limit: 1200
    t.string   "ext2",             limit: 255
  end

  create_table "member_avatars", force: :cascade do |t|
    t.integer  "member_id",      limit: 4,               null: false
    t.string   "avatar",         limit: 255
    t.integer  "apperance_rank", limit: 4
    t.integer  "status",         limit: 1,   default: 1
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  add_index "member_avatars", ["member_id"], name: "index_member_avatars_on_member_id", using: :btree

  create_table "member_bases", id: false, force: :cascade do |t|
    t.integer  "id",                 limit: 4,   default: 0, null: false
    t.string   "wechat",             limit: 255
    t.string   "phone",              limit: 255
    t.string   "token",              limit: 255
    t.integer  "platform",           limit: 4
    t.string   "unique_id",          limit: 255
    t.date     "vip_expired_time"
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.integer  "status",             limit: 4,   default: 0
    t.integer  "captcha",            limit: 4
    t.datetime "captcha_updated_at"
    t.datetime "deleted_at"
    t.string   "push_channel",       limit: 255
    t.string   "push_id",            limit: 255
    t.integer  "channel_id",         limit: 4
    t.integer  "captcha_flag",       limit: 2
    t.date     "msg_expired_time"
    t.integer  "application_id",     limit: 2
    t.date     "birthday"
    t.integer  "sex",                limit: 1
    t.string   "nickname",           limit: 255
    t.integer  "location_id",        limit: 4,   default: 1, null: false
    t.integer  "height",             limit: 2
    t.integer  "weight",             limit: 2
    t.integer  "rank",               limit: 4
  end

  create_table "member_details", force: :cascade do |t|
    t.integer  "member_id",        limit: 4,             null: false
    t.integer  "education",        limit: 2
    t.integer  "profession",       limit: 2
    t.integer  "salary",           limit: 2
    t.integer  "marriage",         limit: 2, default: 1
    t.integer  "living_condition", limit: 2
    t.integer  "two_place_love",   limit: 2
    t.integer  "live_with_parent", limit: 2
    t.integer  "smoking",          limit: 2
    t.integer  "drinking",         limit: 2
    t.integer  "need_baby",        limit: 2
    t.integer  "blood_type",       limit: 2
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  add_index "member_details", ["education"], name: "index_member_details_on_education", using: :btree
  add_index "member_details", ["marriage"], name: "index_member_details_on_marriage", using: :btree
  add_index "member_details", ["member_id"], name: "index_member_details_on_member_id", using: :btree
  add_index "member_details", ["profession"], name: "index_member_details_on_profession", using: :btree
  add_index "member_details", ["salary"], name: "index_member_details_on_salary", using: :btree

  create_table "member_infos", force: :cascade do |t|
    t.integer  "member_id",   limit: 4,               null: false
    t.date     "birthday"
    t.integer  "sex",         limit: 1
    t.string   "nickname",    limit: 255
    t.integer  "location_id", limit: 4,   default: 1, null: false
    t.integer  "height",      limit: 2
    t.integer  "weight",      limit: 2
    t.integer  "rank",        limit: 4
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "city_id",     limit: 2
  end

  add_index "member_infos", ["birthday"], name: "index_member_infos_on_birthday", using: :btree
  add_index "member_infos", ["height"], name: "index_member_infos_on_height", using: :btree
  add_index "member_infos", ["location_id"], name: "index_member_infos_on_location_id", using: :btree
  add_index "member_infos", ["member_id"], name: "index_member_infos_on_member_id", using: :btree

  create_table "member_monologues", force: :cascade do |t|
    t.integer  "member_id",  limit: 4,               null: false
    t.string   "title",      limit: 255
    t.integer  "status",     limit: 1,   default: 1
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  add_index "member_monologues", ["member_id"], name: "index_member_monologues_on_member_id", using: :btree

  create_table "member_pays", id: false, force: :cascade do |t|
    t.integer  "id",           limit: 4,                           default: 0, null: false
    t.integer  "member_id",    limit: 4
    t.string   "out_trade_no", limit: 255
    t.integer  "product_id",   limit: 4
    t.integer  "result_code",  limit: 4
    t.string   "gateway",      limit: 255
    t.integer  "pay_method",   limit: 4
    t.datetime "created_at",                                                   null: false
    t.datetime "updated_at",                                                   null: false
    t.decimal  "total_fee",                precision: 8, scale: 2
    t.string   "wechat",       limit: 255
    t.string   "phone",        limit: 255
    t.integer  "platform",     limit: 4
    t.integer  "channel_id",   limit: 4
    t.integer  "status",       limit: 4,                           default: 0
    t.integer  "sex",          limit: 1
    t.string   "nickname",     limit: 255
    t.integer  "location_id",  limit: 4,                           default: 1, null: false
  end

  create_table "member_relation_proposals", force: :cascade do |t|
    t.integer  "member_id",        limit: 4, null: false
    t.integer  "location_id",      limit: 2
    t.integer  "start_age",        limit: 2
    t.integer  "end_age",          limit: 2
    t.integer  "start_height",     limit: 2
    t.integer  "end_height",       limit: 2
    t.integer  "lowest_education", limit: 2
    t.integer  "lowest_salary",    limit: 2
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "member_relation_proposals", ["member_id"], name: "index_member_relation_proposals_on_member_id", using: :btree

  create_table "member_views", id: false, force: :cascade do |t|
    t.integer  "id",                 limit: 4,   default: 0, null: false
    t.string   "wechat",             limit: 255
    t.string   "phone",              limit: 255
    t.string   "token",              limit: 255
    t.integer  "platform",           limit: 4
    t.string   "unique_id",          limit: 255
    t.date     "vip_expired_time"
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.integer  "status",             limit: 4,   default: 0
    t.integer  "captcha",            limit: 4
    t.datetime "captcha_updated_at"
    t.datetime "deleted_at"
    t.string   "push_channel",       limit: 255
    t.string   "push_id",            limit: 255
    t.integer  "channel_id",         limit: 4
    t.integer  "captcha_flag",       limit: 2
    t.date     "msg_expired_time"
    t.integer  "application_id",     limit: 2
    t.date     "birthday"
    t.integer  "sex",                limit: 1
    t.string   "nickname",           limit: 255
    t.integer  "location_id",        limit: 4,   default: 1, null: false
    t.integer  "height",             limit: 2
    t.integer  "weight",             limit: 2
    t.integer  "rank",               limit: 4
    t.integer  "education",          limit: 2
    t.integer  "profession",         limit: 2
    t.integer  "salary",             limit: 2
    t.integer  "marriage",           limit: 2,   default: 1
    t.integer  "living_condition",   limit: 2
    t.integer  "two_place_love",     limit: 2
    t.integer  "live_with_parent",   limit: 2
    t.integer  "smoking",            limit: 2
    t.integer  "drinking",           limit: 2
    t.integer  "need_baby",          limit: 2
    t.integer  "blood_type",         limit: 2
  end

  create_table "members", force: :cascade do |t|
    t.string   "wechat",             limit: 255
    t.string   "phone",              limit: 255
    t.string   "token",              limit: 255
    t.integer  "platform",           limit: 4
    t.string   "unique_id",          limit: 255
    t.date     "vip_expired_time"
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.integer  "status",             limit: 4,   default: 0
    t.integer  "captcha",            limit: 4
    t.datetime "captcha_updated_at"
    t.datetime "deleted_at"
    t.string   "push_channel",       limit: 255
    t.string   "push_id",            limit: 255
    t.integer  "channel_id",         limit: 4
    t.integer  "captcha_flag",       limit: 2
    t.date     "msg_expired_time"
    t.integer  "application_id",     limit: 2
    t.integer  "bucket_action_id",   limit: 4
  end

  add_index "members", ["created_at"], name: "index_members_on_created_at", using: :btree
  add_index "members", ["deleted_at"], name: "index_members_on_deleted_at", using: :btree
  add_index "members", ["phone"], name: "index_members_on_phone", using: :btree
  add_index "members", ["platform"], name: "index_members_on_platform", using: :btree

  create_table "members_tags", force: :cascade do |t|
    t.integer "member_id", limit: 4
    t.integer "tag_id",    limit: 4
    t.integer "count",     limit: 2, default: 0
  end

  add_index "members_tags", ["member_id"], name: "index_members_tags_on_member_id", using: :btree
  add_index "members_tags", ["tag_id"], name: "index_members_tags_on_tag_id", using: :btree

  create_table "mp_auto_replies", force: :cascade do |t|
    t.string   "keyword",    limit: 255
    t.string   "answer",     limit: 500
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "pays", force: :cascade do |t|
    t.integer  "member_id",    limit: 4
    t.string   "out_trade_no", limit: 255
    t.integer  "product_id",   limit: 4
    t.integer  "result_code",  limit: 4
    t.string   "gateway",      limit: 255
    t.integer  "pay_method",   limit: 4
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
    t.decimal  "total_fee",                precision: 8, scale: 2
  end

  add_index "pays", ["result_code"], name: "idx_on_result_code", using: :btree

  create_table "pictures", force: :cascade do |t|
    t.integer  "album_id",   limit: 4
    t.string   "path",       limit: 255
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.integer  "status",     limit: 4,   default: 1
  end

  add_index "pictures", ["album_id"], name: "index_pictures_on_album_id", using: :btree

  create_table "private_msgs", force: :cascade do |t|
    t.integer  "from_member_id",  limit: 4
    t.integer  "to_member_id",    limit: 4
    t.integer  "question_tpl_id", limit: 4
    t.string   "msg_type",        limit: 255
    t.string   "content",         limit: 255
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.integer  "is_readed",       limit: 4,   default: 0
    t.integer  "status",          limit: 4,   default: 0
    t.integer  "with_flower",     limit: 4,   default: 0
  end

  add_index "private_msgs", ["created_at"], name: "idx_on_created_at", using: :btree
  add_index "private_msgs", ["from_member_id"], name: "index_private_msgs_on_from_member_id", using: :btree
  add_index "private_msgs", ["to_member_id"], name: "index_private_msgs_on_to_member_id", using: :btree

  create_table "products", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.decimal  "price",                  precision: 10, scale: 2
    t.integer  "sku_type",   limit: 4
    t.integer  "sku_count",  limit: 4
    t.integer  "sku_unit",   limit: 4
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.datetime "deleted_at"
  end

  add_index "products", ["deleted_at"], name: "index_products_on_deleted_at", using: :btree

  create_table "question_tpls", force: :cascade do |t|
    t.integer  "tag_type_id",   limit: 4
    t.string   "name",          limit: 255
    t.string   "notes",         limit: 255
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.datetime "deleted_at"
    t.string   "question_type", limit: 255
  end

  add_index "question_tpls", ["deleted_at"], name: "index_question_tpls_on_deleted_at", using: :btree

  create_table "recents", force: :cascade do |t|
    t.integer  "member_id",  limit: 4
    t.integer  "visitor_id", limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "recents", ["member_id"], name: "index_recents_on_member_id", using: :btree
  add_index "recents", ["visitor_id"], name: "index_recents_on_visitor_id", using: :btree

  create_table "regions", force: :cascade do |t|
    t.string   "code",       limit: 255
    t.integer  "parent_id",  limit: 4
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "reports", force: :cascade do |t|
    t.integer  "reporter_id",        limit: 4,   null: false
    t.integer  "reported_member_id", limit: 4,   null: false
    t.string   "reason",             limit: 255
    t.integer  "report_type",        limit: 2
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_index "reports", ["reported_member_id"], name: "index_reports_on_reported_member_id", using: :btree
  add_index "reports", ["reporter_id"], name: "index_reports_on_reporter_id", using: :btree

  create_table "settings", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "value",       limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.string   "description", limit: 255
  end

  create_table "strategies", force: :cascade do |t|
    t.integer  "to",         limit: 4
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "strategies_questions", force: :cascade do |t|
    t.integer  "strategy_id",     limit: 4
    t.integer  "question_tpl_id", limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "strategy_date_questions", force: :cascade do |t|
    t.integer  "strategy_date_id", limit: 4
    t.integer  "question_tpl_id",  limit: 4
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "strategy_dates", force: :cascade do |t|
    t.integer  "strategy_id", limit: 4
    t.integer  "days",        limit: 4
    t.integer  "count",       limit: 4
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "tag_types", force: :cascade do |t|
    t.string   "label",      limit: 255
    t.string   "name",       limit: 255
    t.integer  "value",      limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.datetime "deleted_at"
  end

  add_index "tag_types", ["deleted_at"], name: "index_tag_types_on_deleted_at", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string   "description", limit: 255
    t.string   "name",        limit: 255
    t.integer  "value",       limit: 4
    t.integer  "tag_type_id", limit: 4
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.datetime "deleted_at"
  end

  add_index "tags", ["deleted_at"], name: "index_tags_on_deleted_at", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "role",                   limit: 255
    t.string   "username",               limit: 255
    t.string   "nickname",               limit: 255
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "weixin_pays", force: :cascade do |t|
    t.integer  "product_id",     limit: 4
    t.string   "appid",          limit: 255
    t.string   "mch_id",         limit: 255
    t.string   "device_info",    limit: 255
    t.string   "nonce_str",      limit: 255
    t.string   "sign",           limit: 255
    t.string   "result_code",    limit: 255
    t.string   "return_msg",     limit: 255
    t.string   "return_code",    limit: 255
    t.string   "err_code",       limit: 255
    t.string   "err_code_des",   limit: 255
    t.string   "openid",         limit: 255
    t.string   "trade_type",     limit: 255
    t.string   "bank_type",      limit: 255
    t.integer  "total_fee",      limit: 4
    t.string   "fee_type",       limit: 255
    t.string   "cash_fee",       limit: 255
    t.string   "cash_fee_type",  limit: 255
    t.integer  "coupon_fee",     limit: 4
    t.integer  "coupon_count",   limit: 4
    t.string   "transaction_id", limit: 255
    t.string   "out_trade_no",   limit: 255
    t.boolean  "is_subscribe",   limit: 1
    t.integer  "attach",         limit: 4
    t.datetime "time_end"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "pay_id",         limit: 4
    t.string   "prepay_id",      limit: 255
    t.string   "signature",      limit: 255
  end

  create_table "weixin_users", force: :cascade do |t|
    t.boolean  "subscribe",      limit: 1
    t.string   "openid",         limit: 255
    t.string   "nickname",       limit: 255
    t.integer  "sex",            limit: 4
    t.string   "language",       limit: 255
    t.string   "city",           limit: 255
    t.string   "province",       limit: 255
    t.string   "country",        limit: 255
    t.string   "headimgurl",     limit: 255
    t.datetime "subscribe_time"
    t.string   "unionid",        limit: 255
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "yee_pays", force: :cascade do |t|
    t.integer  "product_id",        limit: 4
    t.integer  "pay_id",            limit: 4
    t.decimal  "total_fee",                     precision: 8, scale: 2, default: 0.0
    t.string   "r0_cmd",            limit: 255
    t.string   "r1_code",           limit: 50
    t.string   "p1_mer_id",         limit: 255
    t.string   "p2_order",          limit: 255
    t.string   "p3_amt",            limit: 255
    t.string   "p4_frp_id",         limit: 255
    t.string   "p5_card_no",        limit: 255
    t.string   "p6_confirm_amount", limit: 255
    t.string   "p7_real_amount",    limit: 255
    t.string   "p8_card_status",    limit: 255
    t.string   "p9_mp",             limit: 255
    t.string   "pb_balance_amt",    limit: 255
    t.string   "pc_balance_act",    limit: 255
    t.string   "r2_trx_id",         limit: 255
    t.string   "hmac",              limit: 255
    t.datetime "created_at",                                                          null: false
    t.datetime "updated_at",                                                          null: false
  end

  add_foreign_key "bucket_actions", "buckets"
end
