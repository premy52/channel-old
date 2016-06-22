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

ActiveRecord::Schema.define(version: 20160621045942) do

  create_table "authorizations", force: true do |t|
    t.integer  "banner_id"
    t.integer  "fgsku_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "authdate"
    t.date     "dropdate"
    t.decimal  "bssw"
  end

  add_index "authorizations", ["banner_id"], name: "index_authorizations_on_banner_id"
  add_index "authorizations", ["fgsku_id"], name: "index_authorizations_on_fgsku_id"

  create_table "banner_promos", force: true do |t|
    t.date     "start_date"
    t.date     "end_date"
    t.string   "promo_vehicle"
    t.string   "promo_method"
    t.decimal  "promo_level"
    t.string   "status"
    t.string   "comment"
    t.integer  "banner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "banner_promos", ["banner_id"], name: "index_banner_promos_on_banner_id"

  create_table "banners", force: true do |t|
    t.string   "banner_name"
    t.string   "banner_city"
    t.string   "banner_state"
    t.string   "banner_buyer_first_name"
    t.string   "banner_buyer_last_name"
    t.string   "banner_broker_first_name"
    t.string   "banner_broker_last_name"
    t.date     "banner_review_date"
    t.integer  "banner_store_count"
    t.text     "banner_notes"
    t.string   "logo_file_name"
    t.integer  "parent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "country"
    t.integer  "dc_id"
    t.integer  "priority"
    t.string   "slug"
  end

  add_index "banners", ["dc_id"], name: "index_banners_on_dc_id"
  add_index "banners", ["parent_id"], name: "index_banners_on_parent_id"

  create_table "brokerages", force: true do |t|
    t.string   "company"
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.decimal  "rate"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
  end

  create_table "brokers", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "title"
    t.integer  "brokerage_id"
    t.string   "email"
    t.string   "phone"
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
  end

  add_index "brokers", ["brokerage_id"], name: "index_brokers_on_brokerage_id"

  create_table "dc_slots", force: true do |t|
    t.integer  "dc_id"
    t.integer  "fgsku_id"
    t.date     "authdate"
    t.date     "dropdate"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "dc_slots", ["dc_id"], name: "index_dc_slots_on_dc_id"
  add_index "dc_slots", ["fgsku_id"], name: "index_dc_slots_on_fgsku_id"

  create_table "dcs", force: true do |t|
    t.string   "dc_name"
    t.string   "dc_contact_first_name"
    t.string   "dc_contact_last_name"
    t.string   "dc_contact_email"
    t.string   "dc_contact_phone"
    t.string   "dc_address_1"
    t.string   "dc_address_2"
    t.string   "dc_city"
    t.string   "dc_state"
    t.string   "dc_zip"
    t.text     "dc_notes"
    t.integer  "distributor_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "country"
    t.string   "slug"
  end

  add_index "dcs", ["distributor_id"], name: "index_dcs_on_distributor_id"

  create_table "distributors", force: true do |t|
    t.string   "distributor_name"
    t.string   "distributor_contact_first_name"
    t.string   "distributor_contact_last_name"
    t.string   "distributor_contact_email"
    t.string   "distributor_contact_phone"
    t.string   "distributor_address_1"
    t.string   "distributor_address_2"
    t.string   "distributor_city"
    t.string   "distributor_state"
    t.string   "distributor_zip"
    t.text     "distributor_notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "channel_segment"
    t.string   "country"
    t.string   "slug"
  end

  create_table "fgskus", force: true do |t|
    t.integer  "flavor_id"
    t.string   "sizegroup"
    t.decimal  "weightoz"
    t.integer  "innercount"
    t.integer  "outercount"
    t.string   "upc"
    t.string   "innerupc"
    t.string   "outerupc"
    t.text     "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "country"
  end

  add_index "fgskus", ["flavor_id"], name: "index_fgskus_on_flavor_id"

  create_table "flavors", force: true do |t|
    t.string   "shorthand"
    t.string   "descriptor"
    t.boolean  "coated"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
    t.integer  "rank"
  end

  create_table "ingredients", force: true do |t|
    t.string   "maintype"
    t.string   "form"
    t.string   "subform"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ingredientskus", force: true do |t|
    t.integer  "ingredient_id"
    t.boolean  "vegan"
    t.string   "vendor"
    t.string   "vendorsku"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ingredientskus", ["ingredient_id"], name: "index_ingredientskus_on_ingredient_id"

  create_table "parents", force: true do |t|
    t.string   "corpname"
    t.string   "hqcity"
    t.string   "hqstate"
    t.string   "buyerfirstname"
    t.string   "buyerlastname"
    t.string   "ourbrokerfirstname"
    t.string   "ourbrokerlastname"
    t.date     "nextreviewdate"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "store_count"
    t.string   "channel_segment"
    t.text     "corp_notes"
    t.string   "logo_file_name"
    t.string   "slug"
  end

  create_table "recipes", force: true do |t|
    t.integer  "flavor_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "recipes", ["flavor_id"], name: "index_recipes_on_flavor_id"

  create_table "recipeversions", force: true do |t|
    t.integer  "versionyear"
    t.integer  "versionmonth"
    t.text     "comment"
    t.string   "filmfilename"
    t.string   "caddyfilename"
    t.string   "imagefilename"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "recipe_id"
  end

  add_index "recipeversions", ["recipe_id"], name: "index_recipeversions_on_recipe_id"

  create_table "stores", force: true do |t|
    t.string   "street_address"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.integer  "banner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "dc_id"
    t.string   "store_name"
    t.string   "slug"
  end

  add_index "stores", ["banner_id"], name: "index_stores_on_banner_id"

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin",           default: false
  end

  create_table "zing_leads", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "title"
    t.string   "email"
    t.string   "phone"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
  end

end
