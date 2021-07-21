# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_07_21_042847) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.integer "user_id"
    t.string "phone"
    t.string "first_name"
    t.string "last_name"
    t.text "photo"
    t.datetime "deactivated"
    t.string "verified"
    t.string "country"
    t.string "county"
    t.string "city"
    t.string "street"
    t.string "address"
    t.string "postal"
    t.string "type"
    t.string "tour"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "activities", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.datetime "date"
    t.integer "created_by"
    t.integer "group_id"
    t.float "price"
    t.float "fine"
    t.text "host"
    t.text "host_contact"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "assets", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.integer "group_id"
    t.datetime "date_bought"
    t.datetime "date_sold"
    t.integer "added_by"
    t.float "price"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "countries", force: :cascade do |t|
    t.integer "phone_code"
    t.text "country_code"
    t.text "country_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "currencies", force: :cascade do |t|
    t.string "currency"
    t.string "code"
    t.string "country"
    t.string "country_code"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "errors", force: :cascade do |t|
    t.text "error"
    t.datetime "time"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "groups", force: :cascade do |t|
    t.integer "created_by"
    t.text "currency"
    t.text "group_type"
    t.integer "membership"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name"
  end

  create_table "grouptypes", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "liabilities", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.integer "group_id"
    t.datetime "date_bought"
    t.datetime "date_sold"
    t.integer "added_by"
    t.float "price"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "loancategories", force: :cascade do |t|
    t.integer "group_id"
    t.integer "created_by"
    t.string "name"
    t.integer "period"
    t.text "decsription"
    t.text "amount"
    t.integer "interest"
    t.text "interest_rule"
    t.integer "required_guarantos"
    t.text "requirements"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "loans", force: :cascade do |t|
    t.integer "group_id"
    t.integer "created_by"
    t.integer "user_id"
    t.float "amount"
    t.integer "type"
    t.float "amount_due"
    t.integer "interest"
    t.integer "status"
    t.text "guarantors"
    t.datetime "date_granted"
    t.datetime "date_due"
    t.datetime "date_paid"
    t.text "requirements"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "logins", force: :cascade do |t|
    t.integer "user_id"
    t.datetime "time"
    t.string "ip"
    t.string "success"
    t.text "password_attempt"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "members", force: :cascade do |t|
    t.integer "invited_by"
    t.integer "user_id"
    t.integer "group_id"
    t.text "designation"
    t.text "status"
    t.datetime "invited_on"
    t.datetime "accepted_on"
    t.text "paid_member"
    t.integer "amount"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "paybills", force: :cascade do |t|
    t.text "request"
    t.string "type"
    t.string "transaction_reference"
    t.float "paybill_balance"
    t.text "third_party_transaction_id"
    t.text "invoice_number"
    t.float "amount"
    t.string "first_name"
    t.string "last_name"
    t.string "middle_name"
    t.text "phone"
    t.integer "short_code"
    t.text "account_number"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "paymentcategories", force: :cascade do |t|
    t.integer "group_id"
    t.integer "created_by"
    t.integer "type"
    t.text "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "projects", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.float "amount"
    t.integer "status"
    t.datetime "project_start"
    t.datetime "project_end"
    t.integer "created_by"
    t.integer "group_id"
    t.text "currency"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "stks", force: :cascade do |t|
    t.string "transaction_reference"
    t.text "merchant_request_id"
    t.text "checkout_request_id"
    t.integer "response_code"
    t.text "response_description"
    t.text "custom_message"
    t.integer "status"
    t.integer "response_result_code"
    t.text "response_result_description"
    t.text "phone"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "transactions", force: :cascade do |t|
    t.integer "user_id"
    t.float "amount"
    t.text "transaction_reference"
    t.integer "transaction_type"
    t.integer "group_id"
    t.integer "wallet_id"
    t.integer "status"
    t.integer "transaction_mode"
    t.text "description"
    t.text "category"
    t.text "sub_category"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "confirmed_at"
    t.string "confirmation_token"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.index ["confirmation_token"], name: "users_confirmation_token_key", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "wallets", force: :cascade do |t|
    t.integer "user_id"
    t.text "currency"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_wallets_on_user_id"
  end

end
