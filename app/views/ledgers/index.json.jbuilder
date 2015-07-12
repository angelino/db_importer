json.array!(@ledgers) do |ledger|
  json.extract! ledger, :id, :ledger, :account, :period, :transaction_date, :journal, :line_no, :base_amt, :signal_base_amt, :debit_credit_marker, :reference, :description, :journal_type, :journal_source, :other_amt, :signal_other_amt, :conversion_code, :rate, :tcode_0, :tcode_1, :tcode_2, :tcode_3, :tcode_4, :tcode_5, :tcode_6, :tcode_7, :tcode_8, :tcode_9, :alloc_ind, :alloc_ref, :alloc_period, :alloc_date, :asset_indicator, :asset_code, :asset_subcode, :entry_date, :entry_period, :due_date, :entry_op, :post_op, :amend_op, :rough_book
  json.url ledger_url(ledger, format: :json)
end
