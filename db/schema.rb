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

ActiveRecord::Schema.define(version: 20180715081714) do

  create_table "domains", force: :cascade do |t|
    t.string "source_host"
    t.string "dest_host"
    t.string "public_key"
    t.string "private_key"
    t.datetime "renewal_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "state", default: 0
    t.index ["source_host"], name: "index_domains_on_source_host", unique: true
  end

  create_table "fluxes", force: :cascade do |t|
    t.integer "rx", limit: 8
    t.integer "tx", limit: 8
    t.integer "domain_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["domain_id"], name: "index_fluxes_on_domain_id"
  end

end
