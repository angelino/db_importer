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

ActiveRecord::Schema.define(version: 20150717020730) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "extracts", force: :cascade do |t|
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

  create_table "microsiga_entries", force: :cascade do |t|
    t.string   "status_oper"
    t.string   "cnpj_cpf"
    t.string   "tipo_mapfre"
    t.string   "fornecedor"
    t.string   "loja"
    t.string   "nom_forn"
    t.string   "tipo_rubrica"
    t.string   "prefixo"
    t.string   "no_titulo"
    t.string   "parcela"
    t.string   "natureza"
    t.string   "banco_dest"
    t.string   "agencia_dest"
    t.string   "conta_dest"
    t.date     "dt_emissao"
    t.string   "vencimento"
    t.string   "vencto_real"
    t.decimal  "vlr_titulo",   precision: 12, scale: 2
    t.decimal  "vl_original",  precision: 12, scale: 2
    t.string   "portador"
    t.string   "iss"
    t.string   "irrf"
    t.string   "inss"
    t.string   "pis_pasep"
    t.string   "cofins"
    t.string   "csll"
    t.string   "n_do_cheque"
    t.string   "historico"
    t.string   "motivo"
    t.string   "rateio"
    t.decimal  "vlr_rs",       precision: 12, scale: 2
    t.string   "mult_natur"
    t.string   "rateio_proj"
    t.string   "gera_dirf"
    t.string   "mod_pagto"
    t.string   "local_pagto"
    t.string   "cod_agencia"
    t.string   "cod_congener"
    t.string   "cod_pag"
    t.string   "cod_empresa"
    t.string   "cod_corretor"
    t.string   "cod_ramo"
    t.string   "num_liq_sin"
    t.string   "num_sinistro"
    t.string   "num_original"
    t.string   "tributo"
    t.string   "num_remessa"
    t.string   "banco_origem"
    t.string   "ag_origem"
    t.string   "id_cnab_mapf"
    t.string   "id_mapfre"
    t.string   "env_cheque"
    t.string   "enviado"
    t.string   "rejeitado"
    t.date     "dt_import"
    t.date     "dt_exportaca"
    t.string   "boleto"
    t.string   "tributo2"
    t.string   "vida_prev"
    t.date     "dt_ger_pagto"
    t.date     "dt_cancel_ch"
    t.string   "est_enviado"
    t.string   "cheque_pend"
    t.string   "baixa_agluti"
    t.string   "cnpj_2"
    t.date     "data_compens"
    t.string   "conta_origem"
    t.date     "data_exp_rj"
    t.string   "nr_orig_sisp"
    t.string   "n_etiq_siacc"
    t.string   "a"
    t.string   "b"
    t.string   "c"
    t.string   "d"
    t.string   "e"
    t.string   "f"
    t.string   "g"
    t.string   "h"
    t.string   "i"
    t.string   "j"
    t.string   "k"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

end
