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

ActiveRecord::Schema.define(version: 2021_09_11_103111) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "accounts", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id"
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
    t.string "account_type"
    t.string "tour"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "activities", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.datetime "date"
    t.uuid "created_by"
    t.uuid "group_id"
    t.float "price"
    t.float "fine"
    t.text "host"
    t.text "host_contact"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "admins", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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

  create_table "assets", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.uuid "group_id"
    t.datetime "date_bought"
    t.datetime "date_sold"
    t.uuid "added_by"
    t.float "price"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.float "selling_price"
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

  create_table "errors", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.jsonb "error"
    t.datetime "time"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "method"
    t.text "referer"
    t.text "message"
  end

  create_table "groups", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "created_by"
    t.text "currency"
    t.text "group_type"
    t.integer "membership"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name"
    t.text "description"
    t.text "requirements"
  end

  create_table "grouptypes", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "invites", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "group_id"
    t.text "invite_key"
    t.integer "max_redeem"
    t.text "invite_email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "active"
    t.string "total_redeemed"
    t.uuid "user_id"
    t.index ["invite_key"], name: "index_invites_on_invite_key", unique: true
    t.index ["total_redeemed"], name: "index_invites_on_total_redeemed"
    t.index ["user_id"], name: "index_invites_on_user_id"
  end

  create_table "liabilities", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.uuid "group_id"
    t.datetime "date_bought"
    t.datetime "date_sold"
    t.uuid "added_by"
    t.float "price"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "loancategories", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "group_id"
    t.uuid "created_by"
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

  create_table "loans", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.integer "group_id"
    t.integer "created_by"
    t.integer "user_id"
    t.float "amount"
    t.integer "loan_type"
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

  create_table "logins", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.integer "user_id"
    t.datetime "time"
    t.string "ip"
    t.string "success"
    t.text "password_attempt"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "logs", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.text "activity"
    t.integer "user_id"
    t.integer "wallet_id"
    t.integer "group_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "referer"
  end

  create_table "members", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "invited_by"
    t.uuid "user_id"
    t.uuid "group_id"
    t.text "designation"
    t.text "status"
    t.datetime "invited_on"
    t.datetime "accepted_on"
    t.text "paid_member"
    t.integer "amount"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.uuid "account_id"
  end

  create_table "paybills", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.text "request"
    t.string "paybill_type"
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

  create_table "paymentcategories", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.integer "group_id"
    t.integer "created_by"
    t.integer "payment_category_type"
    t.text "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "projects", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.float "amount"
    t.integer "status"
    t.datetime "project_start"
    t.datetime "project_end"
    t.uuid "created_by"
    t.uuid "group_id"
    t.text "currency"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "redeems", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "invite_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "complete"
    t.uuid "user_id"
    t.uuid "group_id"
    t.index ["group_id"], name: "index_redeems_on_group_id"
    t.index ["invite_id"], name: "index_redeems_on_invite_id"
    t.index ["user_id"], name: "index_redeems_on_user_id"
  end

  create_table "requests", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "group_id"
    t.uuid "user_id"
    t.uuid "account_id"
    t.text "emai"
    t.integer "accept"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["group_id"], name: "index_requests_on_group_id"
  end

  create_table "siris", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.text "value"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "stks", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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

  create_table "transactions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id"
    t.float "amount"
    t.text "transaction_reference"
    t.integer "transaction_type"
    t.uuid "group_id"
    t.uuid "wallet_id"
    t.integer "status"
    t.integer "transaction_mode"
    t.text "description"
    t.text "category"
    t.text "sub_category"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "integer_id"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "wallets", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id"
    t.text "currency"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.float "balance"
    t.index ["user_id"], name: "index_wallets_on_user_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
end
