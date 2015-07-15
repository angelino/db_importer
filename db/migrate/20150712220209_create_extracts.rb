class CreateExtracts < ActiveRecord::Migration
  def change
    create_table :extracts do |t|
      t.string :ledger
      t.string :account
      t.string :period
      t.date :transaction_date
      t.string :journal
      t.string :line_no
      t.decimal :base_amt, precision: 12, scale: 2
      t.decimal :signal_base_amt, precision: 12, scale: 2
      t.string :debit_credit_marker
      t.string :reference
      t.string :description
      t.string :journal_type
      t.string :journal_source
      t.decimal :other_amt, precision: 12, scale: 2
      t.decimal :signal_other_amt, precision: 12, scale: 2
      t.string :conversion_code
      t.string :rate
      t.string :tcode_0
      t.string :tcode_1
      t.string :tcode_2
      t.string :tcode_3
      t.string :tcode_4
      t.string :tcode_5
      t.string :tcode_6
      t.string :tcode_7
      t.string :tcode_8
      t.string :tcode_9
      t.string :alloc_ind
      t.string :alloc_ref
      t.string :alloc_period
      t.date :alloc_date
      t.string :asset_indicator
      t.string :asset_code
      t.string :asset_subcode
      t.date :entry_date
      t.string :entry_period
      t.date :due_date
      t.string :entry_op
      t.string :post_op
      t.string :amend_op
      t.string :rough_book

      t.timestamps null: false
    end
  end
end
