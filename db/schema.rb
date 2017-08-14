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

ActiveRecord::Schema.define(version: 20170810173415) do

  create_table "members", force: :cascade do |t|
    t.text "first_name"
    t.text "last_name"
    t.string "address_1"
    t.string "address_2"
    t.string "address_3"
    t.string "town"
    t.string "postcode"
    t.string "country"
    t.string "phone"
    t.string "email"
    t.date "dob"
    t.string "experience"
    t.boolean "accept_risks"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_members_on_email", unique: true
  end

  create_table "memberships", force: :cascade do |t|
    t.integer "member_id"
    t.string "bmc_number"
    t.string "membership_type", default: "Provisional"
    t.boolean "welcome_pack_sent", default: false
    t.date "fees_received_on"
    t.date "made_full_member"
    t.string "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["member_id"], name: "index_memberships_on_member_id", unique: true
  end

end
