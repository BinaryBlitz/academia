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

ActiveRecord::Schema.define(version: 20160405123351) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true, using: :btree
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, using: :btree

  create_table "badges", force: :cascade do |t|
    t.string   "name"
    t.string   "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "badges_dishes", id: false, force: :cascade do |t|
    t.integer "badge_id"
    t.integer "dish_id"
  end

  add_index "badges_dishes", ["badge_id"], name: "index_badges_dishes_on_badge_id", using: :btree
  add_index "badges_dishes", ["dish_id"], name: "index_badges_dishes_on_dish_id", using: :btree

  create_table "courier_schedules", force: :cascade do |t|
    t.integer  "day_id"
    t.integer  "courier_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "courier_schedules", ["courier_id"], name: "index_courier_schedules_on_courier_id", using: :btree
  add_index "courier_schedules", ["day_id"], name: "index_courier_schedules_on_day_id", using: :btree

  create_table "couriers", force: :cascade do |t|
    t.string   "name"
    t.string   "phone_number"
    t.string   "password_digest"
    t.integer  "delivery_point_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "api_token"
    t.string   "device_token"
    t.string   "platform"
  end

  add_index "couriers", ["delivery_point_id"], name: "index_couriers_on_delivery_point_id", using: :btree

  create_table "days", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date     "date"
  end

  create_table "delivery_points", force: :cascade do |t|
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "delivery_points", ["latitude", "longitude"], name: "index_delivery_points_on_latitude_and_longitude", using: :btree

  create_table "dish_badges", force: :cascade do |t|
    t.integer  "dish_id"
    t.integer  "badge_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "dish_badges", ["badge_id"], name: "index_dish_badges_on_badge_id", using: :btree
  add_index "dish_badges", ["dish_id"], name: "index_dish_badges_on_dish_id", using: :btree

  create_table "dish_ingredients", force: :cascade do |t|
    t.integer  "dish_id"
    t.integer  "ingredient_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "dish_ingredients", ["dish_id"], name: "index_dish_ingredients_on_dish_id", using: :btree
  add_index "dish_ingredients", ["ingredient_id"], name: "index_dish_ingredients_on_ingredient_id", using: :btree

  create_table "dishes", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "price"
    t.string   "image"
    t.boolean  "stuff",         default: false
    t.boolean  "lunch",         default: false
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.string   "subtitle"
    t.boolean  "hidden",        default: false
    t.float    "proteins"
    t.float    "fats"
    t.float    "carbohydrates"
    t.float    "calories"
  end

  create_table "edge_points", force: :cascade do |t|
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ingredients", force: :cascade do |t|
    t.string   "name"
    t.string   "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "weight"
  end

  create_table "line_items", force: :cascade do |t|
    t.integer  "order_id"
    t.integer  "dish_id"
    t.integer  "quantity",   default: 1
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "line_items", ["dish_id"], name: "index_line_items_on_dish_id", using: :btree
  add_index "line_items", ["order_id"], name: "index_line_items_on_order_id", using: :btree

  create_table "lunch_dishes", force: :cascade do |t|
    t.string   "name"
    t.integer  "weight"
    t.integer  "dish_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "lunch_dishes", ["dish_id"], name: "index_lunch_dishes_on_dish_id", using: :btree

  create_table "orders", force: :cascade do |t|
    t.text     "address"
    t.integer  "user_id"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.string   "status"
    t.datetime "scheduled_for"
    t.float    "latitude"
    t.float    "longitude"
    t.integer  "rating"
    t.text     "review"
    t.integer  "courier_id"
    t.integer  "revenue"
    t.integer  "discount"
    t.integer  "balance_discount"
    t.datetime "delivered_at"
    t.integer  "delivery_point_id"
    t.boolean  "deliver_now",       default: true
  end

  add_index "orders", ["courier_id"], name: "index_orders_on_courier_id", using: :btree
  add_index "orders", ["delivery_point_id"], name: "index_orders_on_delivery_point_id", using: :btree
  add_index "orders", ["user_id"], name: "index_orders_on_user_id", using: :btree

  create_table "payments", force: :cascade do |t|
    t.integer  "price",         null: false
    t.integer  "order_id",      null: false
    t.string   "alfa_order_id"
    t.string   "alfa_form_url"
    t.boolean  "paid"
    t.boolean  "use_binding"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "description"
  end

  add_index "payments", ["order_id"], name: "index_payments_on_order_id", using: :btree

  create_table "promo_codes", force: :cascade do |t|
    t.string   "code"
    t.integer  "discount"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "activations", default: 0
  end

  create_table "rpush_apps", force: :cascade do |t|
    t.string   "name",                                null: false
    t.string   "environment"
    t.text     "certificate"
    t.string   "password"
    t.integer  "connections",             default: 1, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "type",                                null: false
    t.string   "auth_key"
    t.string   "client_id"
    t.string   "client_secret"
    t.string   "access_token"
    t.datetime "access_token_expiration"
  end

  create_table "rpush_feedback", force: :cascade do |t|
    t.string   "device_token", limit: 64, null: false
    t.datetime "failed_at",               null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "app_id"
  end

  add_index "rpush_feedback", ["device_token"], name: "index_rpush_feedback_on_device_token", using: :btree

  create_table "rpush_notifications", force: :cascade do |t|
    t.integer  "badge"
    t.string   "device_token",      limit: 64
    t.string   "sound",                        default: "default"
    t.text     "alert"
    t.text     "data"
    t.integer  "expiry",                       default: 86400
    t.boolean  "delivered",                    default: false,     null: false
    t.datetime "delivered_at"
    t.boolean  "failed",                       default: false,     null: false
    t.datetime "failed_at"
    t.integer  "error_code"
    t.text     "error_description"
    t.datetime "deliver_after"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "alert_is_json",                default: false
    t.string   "type",                                             null: false
    t.string   "collapse_key"
    t.boolean  "delay_while_idle",             default: false,     null: false
    t.text     "registration_ids"
    t.integer  "app_id",                                           null: false
    t.integer  "retries",                      default: 0
    t.string   "uri"
    t.datetime "fail_after"
    t.boolean  "processing",                   default: false,     null: false
    t.integer  "priority"
    t.text     "url_args"
    t.string   "category"
    t.boolean  "content_available",            default: false
    t.text     "notification"
  end

  add_index "rpush_notifications", ["delivered", "failed"], name: "index_rpush_notifications_multi", where: "((NOT delivered) AND (NOT failed))", using: :btree

  create_table "schedules", force: :cascade do |t|
    t.integer  "day_id"
    t.integer  "dish_id"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.boolean  "out_of_stock", default: false
  end

  add_index "schedules", ["day_id"], name: "index_schedules_on_day_id", using: :btree
  add_index "schedules", ["dish_id"], name: "index_schedules_on_dish_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "phone_number"
    t.string   "vk_id"
    t.string   "fb_id"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.string   "api_token"
    t.boolean  "promo_used",            default: false
    t.integer  "balance",               default: 0
    t.string   "alfa_binding_id"
    t.string   "card_number"
    t.string   "promo_code"
    t.integer  "sms_verification_code"
    t.integer  "discount",              default: 0
    t.integer  "referred_by_id"
    t.string   "device_token"
    t.string   "platform"
  end

  add_index "users", ["referred_by_id"], name: "index_users_on_referred_by_id", using: :btree

  create_table "verification_tokens", force: :cascade do |t|
    t.string   "token"
    t.string   "phone_number"
    t.integer  "code"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "working_hours", force: :cascade do |t|
    t.integer  "starts_at"
    t.integer  "ends_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
