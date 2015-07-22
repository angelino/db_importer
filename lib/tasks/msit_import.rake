require "#{Rails.root}/db/ledger_importer"
require "#{Rails.root}/db/extract_importer"
require "#{Rails.root}/db/microsiga_entry_importer"

namespace :msit  do
  desc "import csv to database"
  task :import => :environment do

    batch_size = 10_000

    # Import Ledgers...
    puts "#{Time.now} - Ledger's Import Initialized..."

    initial_time = Time.now

    ledgers_file = ENV['ledgers_file']
    ledgers_file ||= 'ledgers_empty.csv'
    extracts_file = ENV['extracts_file']
    extracts_file ||= 'extracts_empty.csv'
    microsiga_file = ENV['microsiga_file']
    microsiga_file ||= 'microsiga_sample.csv'

    ledger_importer = LedgerImporter.new("#{Rails.root}/db/#{ledgers_file}")
    ledgers = ledger_importer.entries
    puts "#{Time.now} - Ledger's File Readed..."

    ledgers.each_slice(batch_size) do |ledgers_batch|
      Ledger.import ledgers_batch, validate: false
      puts "#{Time.now} - #{ledgers_batch.size} Records Imported..."
    end

    final_time = Time.now

    import_time = final_time.to_f - initial_time.to_f

    puts "#{Time.now} - Ledger' Import Finished in #{import_time} seconds"

    # Import Extracts...
    puts "#{Time.now} - Extract's Import Initialized..."

    initial_time = Time.now

    extract_importer = ExtractImporter.new("#{Rails.root}/db/#{extracts_file}")
    extracts = extract_importer.entries
    puts "#{Time.now} - Extract's File Readed..."

    extracts.each_slice(batch_size) do |extracts_batch|
      Extract.import extracts_batch, validate: false
      puts "#{Time.now} - #{extracts_batch.size} Records Imported..."
    end

    final_time = Time.now

    import_time = final_time.to_f - initial_time.to_f

    puts "#{Time.now} - Extract' Import Finished in #{import_time} seconds"

    # Import Microsiga Entries...
    puts "#{Time.now} - Microsiga Entries' Import Initialized..."

    initial_time = Time.now

    microsiga_entry_importer = MicrosigaEntryImporter.new("#{Rails.root}/db/#{microsiga_file}")
    microsiga_entries = microsiga_entry_importer.entries
    puts "#{Time.now} - Microsiga Entries' File Readed..."

    microsiga_entries.each_slice(batch_size) do |microsiga_entries_batch|
      MicrosigaEntry.import microsiga_entries_batch, validate: false
      puts "#{Time.now} - #{microsiga_entries_batch.size} Records Imported..."
    end

    final_time = Time.now

    import_time = final_time.to_f - initial_time.to_f

    puts "#{Time.now} - Microsiga Entries' Import Finished in #{import_time} seconds"

  end

  desc "match registers between extracts and microsiga"
  task :match => :environment do
    batch_size = 10

    # Match registers
    puts "#{Time.now} - Beggining registers match between microsiga and extracts..."

    initial_time = Time.now

    # select sum(microsiga_value) as msg, sum(extract_value) as ext, (sum(microsiga_value) - sum(extract_value)) as msg_ext
    # from (
    #          select sum(vlr_rs) as microsiga_value, 0 as extract_value
    # from microsiga_entries
    # where conta_origem = '929441-4'
    # and tipo_mapfre <> 'CC'
    # and status_oper = 'TPG'
    # and vencto_real = '04/05/2015'
    # UNION ALL
    # select 0 as microsiga_value, sum(base_amt) as extract_value
    # from extracts
    # where tcode_5 = 'B00000019294414'
    # and description in ('FORNECEDOR', 'PFOR', 'PAGFOR', 'PFOR', 'PAG DIVERSOS')
    # and debit_credit_marker = 'D'
    # and transaction_date = to_date('04/05/2015', 'DD/MM/YYYY')
    # ) conciliate_extracts_msg
    microsiga_entries = MicrosigaEntry.first(batch_size)

    puts "#{Time.now} - (#{microsiga_entries.size}) Microsiga registers readed from database..."

    microsiga_entries.each do |microsiga_entry|
      puts "#{Time.now} - #{microsiga_entry.id} match!"
      puts "#{Time.now} - #{microsiga_entry.id} don't match!"
    end

    final_time = Time.now

    import_time = final_time.to_f - initial_time.to_f

    puts "#{Time.now} - Microsiga registers match finished in #{import_time} seconds"
  end
end
