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

ActiveRecord::Schema.define(version: 20200415204902) do

  create_table "attendees", force: :cascade do |t|
    t.integer "meet_id"
    t.integer "member_id"
    t.boolean "is_meet_leader", default: false, null: false
    t.boolean "paid", default: false, null: false
    t.date "sign_up_date", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["meet_id"], name: "index_attendees_on_meet_id"
    t.index ["member_id"], name: "index_attendees_on_member_id"
  end

  create_table "emails", force: :cascade do |t|
    t.integer "member_id"
    t.string "template"
    t.string "subject"
    t.string "body"
    t.integer "sent_to"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "default_template", default: false
    t.datetime "sent_on"
    t.string "style"
    t.index ["member_id"], name: "index_emails_on_member_id"
  end

  create_table "emergency_contacts", force: :cascade do |t|
    t.integer "member_id"
    t.string "name"
    t.string "address_1"
    t.string "address_2"
    t.string "address_3"
    t.string "town"
    t.string "postcode"
    t.string "country"
    t.string "primary_phone"
    t.string "secondary_phone"
    t.string "relationship"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["member_id"], name: "index_emergency_contacts_on_member_id", unique: true
  end

  create_table "meets", force: :cascade do |t|
    t.date "meet_date"
    t.string "meet_type"
    t.integer "number_of_nights"
    t.integer "places"
    t.string "location"
    t.string "activity"
    t.string "bb_url"
    t.string "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "members", force: :cascade do |t|
    t.text "first_name"
    t.text "last_name"
    t.string "address_1"
    t.string "address_2"
    t.string "address_3"
    t.string "town"
    t.string "county"
    t.string "postcode"
    t.string "country"
    t.string "home_phone"
    t.string "mob_phone"
    t.string "email"
    t.date "dob"
    t.string "experience"
    t.boolean "accept_risks"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "reset_digest"
    t.datetime "reset_sent_at"
    t.boolean "receive_emails", default: false
    t.string "bb_name"
    t.index ["email"], name: "index_members_on_email", unique: true
  end

  create_table "memberships", force: :cascade do |t|
    t.integer "member_id"
    t.string "bmc_number"
    t.string "membership_type", default: "Provisional (unpaid)"
    t.boolean "welcome_pack_sent", default: false
    t.date "fees_received_on"
    t.date "made_full_member"
    t.string "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "committee_position"
    t.boolean "subs_paid", default: false
    t.index ["member_id"], name: "index_memberships_on_member_id", unique: true
  end

end
