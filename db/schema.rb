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

ActiveRecord::Schema.define(version: 20130720110302) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "certificates", force: true do |t|
    t.string   "registrant"
    t.string   "business_address"
    t.string   "gross_income_number"
    t.string   "habilitation"
    t.string   "cuit"
    t.string   "legal_metrology_number"
    t.integer  "technical_certificate_number"
    t.integer  "registration_ssty_number"
    t.string   "titular"
    t.string   "document_type"
    t.integer  "document_number"
    t.string   "address"
    t.integer  "taxi_license_number"
    t.string   "car_brand"
    t.string   "clock_brand"
    t.integer  "car_model"
    t.string   "domain_number"
    t.string   "clock_number"
    t.string   "precinct_number"
    t.string   "motor_number"
    t.string   "chasis_number"
    t.text     "observations"
    t.integer  "pulses_per_km"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "certificates", ["chasis_number"], name: "index_certificates_on_chasis_number", using: :btree
  add_index "certificates", ["clock_brand"], name: "index_certificates_on_clock_brand", using: :btree
  add_index "certificates", ["clock_number"], name: "index_certificates_on_clock_number", using: :btree
  add_index "certificates", ["document_number"], name: "index_certificates_on_document_number", using: :btree
  add_index "certificates", ["domain_number"], name: "index_certificates_on_domain_number", using: :btree
  add_index "certificates", ["motor_number"], name: "index_certificates_on_motor_number", using: :btree
  add_index "certificates", ["precinct_number"], name: "index_certificates_on_precinct_number", using: :btree
  add_index "certificates", ["taxi_license_number"], name: "index_certificates_on_taxi_license_number", using: :btree
  add_index "certificates", ["titular"], name: "index_certificates_on_titular", using: :btree

  create_table "receipts", force: true do |t|
    t.string   "name"
    t.string   "identification_kind"
    t.integer  "identification_number"
    t.string   "address"
    t.integer  "taxi_license_number"
    t.string   "car_brand"
    t.string   "clock_brand"
    t.integer  "car_model"
    t.string   "domain_number"
    t.string   "clock_number"
    t.string   "precinct_number"
    t.string   "motor_number"
    t.string   "chasis_number"
    t.text     "observations"
    t.integer  "pulses_per_km"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "authentication_token"
    t.string   "username"
    t.string   "name"
    t.string   "last_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["authentication_token"], name: "index_users_on_authentication_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
