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

ActiveRecord::Schema.define(:version => 20121118153125) do

  create_table "addrs", :force => true do |t|
    t.string   "name"
    t.string   "typeofaddr"
    t.string   "postindex"
    t.string   "string1"
    t.string   "string2"
    t.string   "key"
    t.text     "note"
    t.integer  "organization_id"
    t.integer  "contact_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "bankaccs", :force => true do |t|
    t.string   "name"
    t.string   "full_name"
    t.string   "ks"
    t.string   "rs"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.integer  "organization_id"
    t.string   "bik"
  end

  create_table "contacts", :force => true do |t|
    t.string   "name"
    t.string   "short_name"
    t.string   "full_name"
    t.string   "to_name"
    t.string   "post"
    t.string   "phone1"
    t.string   "phone2"
    t.string   "phone3"
    t.string   "phone4"
    t.string   "key"
    t.string   "tag"
    t.text     "note"
    t.integer  "organization_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "pasp_series"
    t.string   "pasp_number"
    t.string   "pasp_date"
    t.string   "pasp_given"
    t.string   "pasp_kp"
    t.string   "address"
  end

  create_table "order_lines", :force => true do |t|
    t.integer "order_id"
    t.integer "product_id"
    t.decimal "qty"
    t.decimal "price"
  end

  create_table "orders", :force => true do |t|
    t.string  "number"
    t.date    "order_date"
    t.date    "document_date"
    t.text    "note"
    t.string  "status"
    t.string  "tag"
    t.integer "from_id"
    t.integer "to_id"
    t.integer "recipient_id"
    t.integer "bankacc_id"
    t.decimal "total_price"
    t.decimal "vat"
    t.integer "parent_id"
  end

  create_table "organizations", :force => true do |t|
    t.string   "name"
    t.string   "tag"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "opf"
    t.string   "short_name"
    t.string   "full_name"
    t.string   "inn"
    t.string   "kpp"
    t.string   "ogrn"
    t.string   "okpo"
  end

  create_table "payments", :force => true do |t|
    t.string  "note"
    t.decimal "amount"
    t.string  "tag"
    t.string  "status"
    t.date    "pay_date"
    t.integer "order_id"
    t.boolean "debet"
    t.integer "toacc_id"
    t.integer "fromacc_id"
  end

  create_table "product_orgs", :force => true do |t|
    t.integer "product_id"
    t.integer "organization_id"
  end

  create_table "products", :force => true do |t|
    t.string  "name"
    t.string  "articul"
    t.integer "ean13"
    t.text    "note"
    t.decimal "weight"
    t.decimal "x"
    t.decimal "y"
    t.decimal "z"
    t.boolean "service"
    t.boolean "purchased"
    t.integer "sku_id"
    t.string  "tag"
    t.decimal "price",     :precision => 8, :scale => 2
    t.decimal "vat",       :precision => 8, :scale => 2
  end

  create_table "skus", :force => true do |t|
    t.string "name"
  end

  create_table "warrants", :force => true do |t|
    t.date    "date"
    t.date    "date_till"
    t.integer "order_id"
    t.integer "contact_id"
  end

end
