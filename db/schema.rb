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

ActiveRecord::Schema.define(:version => 20110626082535) do

  create_table "customers", :force => true do |t|
    t.string   "email"
    t.boolean  "accepts_marketing"
    t.integer  "orders_count"
    t.integer  "shopify_id"
    t.string   "first_name"
    t.string   "last_name"
    t.float    "total_spent"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "shop_id"
  end

  create_table "discount_templates", :force => true do |t|
    t.float    "value"
    t.string   "discount_type"
    t.datetime "order_placed_after"
    t.datetime "order_placed_before"
    t.float    "minimum_order_amount"
    t.integer  "usage_limit"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "customer_criteria"
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.integer  "shop_id"
  end

  create_table "discounts", :force => true do |t|
    t.string   "code"
    t.float    "value"
    t.string   "type"
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.float    "minimum_order_amount"
    t.integer  "usage_limit"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "customer_id"
    t.integer  "discount_template_id"
    t.boolean  "used"
    t.integer  "shop_id"
  end

  create_table "orders", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.float    "total_price"
    t.float    "total_discounts"
    t.integer  "shopify_id"
    t.float    "total_line_items_price"
    t.float    "subtotal_price"
    t.boolean  "buyer_accepts_marketing"
    t.integer  "shopify_customer_id"
    t.string   "discount_code"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "shop_id"
  end

  create_table "shops", :force => true do |t|
    t.integer  "shopify_id"
    t.string   "domain"
    t.string   "api_password"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
