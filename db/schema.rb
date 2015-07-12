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

ActiveRecord::Schema.define(version: 20150712214815) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "ledgers", force: :cascade do |t|
    t.string   "ledger"
    t.string   "account"
    t.string   "period"
    t.date     "transaction_date"
    t.string   "journal"
    t.string   "line_no"
    t.decimal  "base_amt",            precision: 12, scale: 2
    t.decimal  "signal_base_amt",     precision: 12, scale: 2
    t.string   "debit_credit_marker"
    t.string   "reference"
    t.string   "description"
    t.string   "journal_type"
    t.string   "journal_source"
    t.decimal  "other_amt",           precision: 12, scale: 2
    t.decimal  "signal_other_amt",    precision: 12, scale: 2
    t.string   "conversion_code"
    t.string   "rate"
    t.string   "tcode_0"
    t.string   "tcode_1"
    t.string   "tcode_2"
    t.string   "tcode_3"
    t.string   "tcode_4"
    t.string   "tcode_5"
    t.string   "tcode_6"
    t.string   "tcode_7"
    t.string   "tcode_8"
    t.string   "tcode_9"
    t.string   "alloc_ind"
    t.string   "alloc_ref"
    t.string   "alloc_period"
    t.date     "alloc_date"
    t.string   "asset_indicator"
    t.string   "asset_code"
    t.string   "asset_subcode"
    t.date     "entry_date"
    t.string   "entry_period"
    t.date     "due_date"
    t.string   "entry_op"
    t.string   "post_op"
    t.string   "amend_op"
    t.string   "rough_book"
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
  end

end
