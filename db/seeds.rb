# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# require_relative 'ledger_importer'
# require_relative 'extract_importer'

# batch_size = 10_000

# # Import Ledgers...
# puts "#{Time.now} - Ledger's Import Initialized..."

# initial_time = Time.now

# ledgers_file = ENV['ledgers_file']
# ledgers_file ||= 'ledgers-test.csv'
# extracts_file = ENV['extracts_file']
# extracts_file ||= 'extracts-test.csv'

# ledger_importer = LedgerImporter.new("#{Rails.root}/db/#{ledgers_file}")
# ledgers = ledger_importer.entries
# puts "#{Time.now} - Ledger's File Readed..."

# ledgers.each_slice(batch_size) do |ledgers_batch|
#   Ledger.import ledgers_batch, validate: false
#   puts "#{Time.now} - #{ledgers_batch.size} Records Imported..."
# end

# final_time = Time.now

# import_time = final_time.to_f - initial_time.to_f

# puts "#{Time.now} - Ledger' Import Finished in #{import_time} seconds"

# # Import Extracts...
# puts "#{Time.now} - Extract's Import Initialized..."

# initial_time = Time.now

# extract_importer = ExtractImporter.new("#{Rails.root}/db/#{extracts_file}")
# extracts = extract_importer.entries
# puts "#{Time.now} - Extract's File Readed..."

# extracts.each_slice(batch_size) do |extracts_batch|
#   Extract.import extracts_batch, validate: false
#   puts "#{Time.now} - #{extracts_batch.size} Records Imported..."
# end

# final_time = Time.now

# import_time = final_time.to_f - initial_time.to_f

# puts "#{Time.now} - Extract' Import Finished in #{import_time} seconds"
