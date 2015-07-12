# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require_relative 'ledger_importer'

# Import Ledgers...
puts "#{Time.now} - Ledger's Import Initialized..."

initial_time = Time.now

ledger_importer = LedgerImporter.new("#{Rails.root}/db/ledgers.csv")
ledgers = ledger_importer.entries
puts "#{Time.now} - Ledger's File Readed..."

batch_size = 10_000
ledgers.each_slice(batch_size) do |ledgers_batch|
  Ledger.import ledgers_batch, validate: false
  puts "#{Time.now} - #{batch_size} Records Imported..."
end

final_time = Time.now

import_time = final_time.to_f - initial_time.to_f

puts "#{Time.now} - Ledger' Import Finished in #{import_time} seconds"
