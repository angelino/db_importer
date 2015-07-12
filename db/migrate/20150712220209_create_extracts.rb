class CreateExtracts < ActiveRecord::Migration
  def change
    create_table :extracts do |t|
      t.string :ledger
      t.string :account
      t.string :period
      t.string :transaction_date
      t.string :journal
      t.string :line_no
      t.string :base_amt
      t.string :signal_base_amt
      t.string :debit_credit_marker
      t.string :reference
      t.string :description
      t.string :journal_type
      t.string :journal_source
      t.string :other_amt
      t.string :signal_other_amt
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
      t.string :alloc_date
      t.string :asset_indicator
      t.string :asset_code
      t.string :asset_subcode
      t.string :entry_date
      t.string :entry_period
      t.string :due_date
      t.string :entry_op
      t.string :post_op
      t.string :amend_op
      t.string :rough_book

      t.timestamps null: false
    end
  end
end
