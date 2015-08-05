require "#{Rails.root}/db/ledger_importer"
require "#{Rails.root}/db/extract_importer"
require "#{Rails.root}/db/microsiga_entry_importer"

namespace :msit  do
  desc "import csv to database"
  task :import => :environment do

    batch_size = 25_000

    ledgers_file = ENV['ledgers_file']
    # ledgers_file ||= 'ledgers-empty.csv'
    extracts_file = ENV['extracts_file']
    # extracts_file ||= 'extracts-empty.csv'
    microsiga_file = ENV['microsiga_file']
    # microsiga_file ||= 'microsiga-empty.csv'

    # Import Ledgers...
    if ledgers_file
      puts "#{Time.now} - Ledger's Import Initialized..."

      initial_time = Time.now

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
    end

    # Import Extracts...
    if extracts_file
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
    end

    # Import Microsiga Entries...
    if microsiga_file
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

  end

  desc "match registers between extracts and ledgers"
  task :group_and_count => :environment do
    puts "#{Time.now} - Beggining registers group and count... extracts and ledgers..."

    initial_time = Time.now

    puts "#{Time.now} - Processing extracts..."

    ext_rule_1 = 'update extracts
                  set count_1 = subquery.counter
                  from (
                         select extracts.id, B.counter
                         FROM extracts
                           inner join (select tcode_5, base_amt, debit_credit_marker, reference, description, count(1) as counter
                                        from extracts group by tcode_5, base_amt, debit_credit_marker, reference, description) B
                             on (extracts.tcode_5 = B.tcode_5
                                 and extracts.base_amt = B.base_amt
                                 and extracts.debit_credit_marker = B.debit_credit_marker
                                 and extracts.reference = B.reference
                                 and extracts.description = B.description)
                       ) as subquery
                  where extracts.id = subquery.id'

    ext_rule_2 = 'update extracts
                  set count_2 = subquery.counter
                  from (
                         select extracts.id, B.counter
                         FROM extracts
                           inner join (select tcode_5, transaction_date, base_amt, debit_credit_marker, reference, count(1) as counter
                                        from extracts group by tcode_5, transaction_date, base_amt, debit_credit_marker, reference) B
                             on (extracts.tcode_5 = B.tcode_5
                                 and extracts.transaction_date = B.transaction_date
                                 and extracts.base_amt = B.base_amt
                                 and extracts.debit_credit_marker = B.debit_credit_marker
                                 and extracts.reference = B.reference)
                       ) as subquery
                  where extracts.id = subquery.id'

    ext_rule_3 = 'update extracts
                  set count_3 = subquery.counter
                  from (
                         select extracts.id, B.counter
                         FROM extracts
                           inner join (select tcode_5, transaction_date, base_amt, debit_credit_marker, description, count(1) as counter
                                        from extracts group by tcode_5, transaction_date, base_amt, debit_credit_marker, description) B
                             on (extracts.tcode_5 = B.tcode_5
                                 and extracts.transaction_date = B.transaction_date
                                 and extracts.base_amt = B.base_amt
                                 and extracts.debit_credit_marker = B.debit_credit_marker
                                 and extracts.description = B.description)
                       ) as subquery
                  where extracts.id = subquery.id'

    ext_rule_4 = 'update extracts
                  set count_4 = subquery.counter
                  from (
                         select extracts.id, B.counter
                         FROM extracts
                           inner join (select tcode_5, base_amt, debit_credit_marker, reference, count(1) as counter
                                        from extracts group by tcode_5, base_amt, debit_credit_marker, reference) B
                             on (extracts.tcode_5 = B.tcode_5
                                 and extracts.base_amt = B.base_amt
                                 and extracts.debit_credit_marker = B.debit_credit_marker
                                 and extracts.reference = B.reference)
                       ) as subquery
                  where extracts.id = subquery.id'

    ActiveRecord::Base.connection.execute(ext_rule_1)
    puts "#{Time.now} - Finalizing extracts rule 1..."
    ActiveRecord::Base.connection.execute(ext_rule_2)
    puts "#{Time.now} - Finalizing extracts rule 2..."
    ActiveRecord::Base.connection.execute(ext_rule_3)
    puts "#{Time.now} - Finalizing extracts rule 3..."
    ActiveRecord::Base.connection.execute(ext_rule_4)
    puts "#{Time.now} - Finalizing extracts rule 4..."

    puts "#{Time.now} - Finalizing extracts..."

    puts "#{Time.now} - Processing ledgers..."

    led_rule_1 = 'update ledgers
                  set count_1 = subquery.counter
                  from (
                         select ledgers.id, B.counter
                         FROM ledgers
                           inner join (select tcode_5, base_amt, debit_credit_marker, reference, description, count(1) as counter
                                        from ledgers group by tcode_5, base_amt, debit_credit_marker, reference, description) B
                             on (ledgers.tcode_5 = B.tcode_5
                                 and ledgers.base_amt = B.base_amt
                                 and ledgers.debit_credit_marker = B.debit_credit_marker
                                 and ledgers.reference = B.reference
                                 and ledgers.description = B.description)
                       ) as subquery
                  where ledgers.id = subquery.id'
    led_rule_2 = 'update ledgers
                  set count_2 = subquery.counter
                  from (
                         select ledgers.id, B.counter
                         FROM ledgers
                           inner join (select tcode_5, transaction_date, base_amt, debit_credit_marker, reference, count(1) as counter
                                        from ledgers group by tcode_5, transaction_date, base_amt, debit_credit_marker, reference) B
                             on (ledgers.tcode_5 = B.tcode_5
                                 and ledgers.transaction_date = B.transaction_date
                                 and ledgers.base_amt = B.base_amt
                                 and ledgers.debit_credit_marker = B.debit_credit_marker
                                 and ledgers.reference = B.reference)
                       ) as subquery
                  where ledgers.id = subquery.id'
    led_rule_3 = 'update ledgers
                  set count_3 = subquery.counter
                  from (
                         select ledgers.id, B.counter
                         FROM ledgers
                           inner join (select tcode_5, transaction_date, base_amt, debit_credit_marker, description, count(1) as counter
                                        from ledgers group by tcode_5, transaction_date, base_amt, debit_credit_marker, description) B
                             on (ledgers.tcode_5 = B.tcode_5
                                 and ledgers.transaction_date = B.transaction_date
                                 and ledgers.base_amt = B.base_amt
                                 and ledgers.debit_credit_marker = B.debit_credit_marker
                                 and ledgers.description = B.description)
                       ) as subquery
                  where ledgers.id = subquery.id'
    led_rule_4 = 'update ledgers
                  set count_4 = subquery.counter
                  from (
                         select ledgers.id, B.counter
                         FROM ledgers
                           inner join (select tcode_5, base_amt, debit_credit_marker, reference, count(1) as counter
                                        from ledgers group by tcode_5, base_amt, debit_credit_marker, reference) B
                             on (ledgers.tcode_5 = B.tcode_5
                                 and ledgers.base_amt = B.base_amt
                                 and ledgers.debit_credit_marker = B.debit_credit_marker
                                 and ledgers.reference = B.reference)
                       ) as subquery
                  where ledgers.id = subquery.id'
    ActiveRecord::Base.connection.execute(led_rule_1)
    puts "#{Time.now} - Finalizing ledgers rule 1..."
    ActiveRecord::Base.connection.execute(led_rule_2)
    puts "#{Time.now} - Finalizing ledgers rule 2..."
    ActiveRecord::Base.connection.execute(led_rule_3)
    puts "#{Time.now} - Finalizing ledgers rule 3..."
    ActiveRecord::Base.connection.execute(led_rule_4)
    puts "#{Time.now} - Finalizing ledgers rule 4..."

    puts "#{Time.now} - Finalizing ledgers..."

    final_time = Time.now
    group_time = final_time.to_f - initial_time.to_f
    puts "#{Time.now} - Extracts and ledgers registers group and count finished in #{group_time} seconds"
  end

  desc "match registers between extracts and microsiga"
  task :match => :environment do
    # Match registers
    puts "#{Time.now} - Beggining registers match between microsiga and extracts..."

    initial_time = Time.now

    dates_query = " select  distinct to_date(vencto_real, 'DD/MM/YYYY') target_date,
                    to_date(vencto_real, 'DD/MM/YYYY') + integer '1' next_target_date
                    from microsiga_entries
                    order by 1 "
    comparison_query = "select sum(microsiga_value) as msg, sum(extract_value) as ext, (sum(microsiga_value) - sum(extract_value)) as msg_ext
                        from (
                                  select sum(vlr_rs) as microsiga_value, 0 as extract_value
                                  from microsiga_entries
                                  where conta_origem = '929441-4'
                                  and tipo_mapfre <> 'CC'
                                  and status_oper = 'TPG'
                                  and vencto_real = :target_date

                                  UNION ALL

                                  select 0 as microsiga_value, coalesce(sum(base_amt), 0) * -1 as extract_value
                                  from extracts
                                  where tcode_5 = 'B00000019294414'
                                  and upper(description) like '%DEVOL.TED/DOC%'
                                  and transaction_date = to_date(:next_target_date, 'DD/MM/YYYY')

                                  UNION ALL

                                  select 0 as microsiga_value, sum(base_amt) as extract_value
                                  from extracts
                                  where tcode_5 = 'B00000019294414'
                                  and description in ('FORNECEDOR', 'PFOR', 'PAGFOR', 'PFOR', 'PAG DIVERSOS')
                                  and debit_credit_marker = 'D'
                                  and transaction_date = to_date(:target_date, 'DD/MM/YYYY')
                        ) conciliate_extracts_msg"

    dates_to_process = ActiveRecord::Base.connection.select_all(dates_query)
    puts "#{Time.now} - Processing #{dates_to_process.count} different dates"

    puts "#{Time.now} - initializing results for comparison:"
    puts 'date,addicted_date,microsiga_value,extract_value,difference_value'
    dates_to_process.each do |dt|
      target_date = dt['target_date']
      next_target_date = dt['next_target_date']
      prepared_comparison_query = ActiveRecord::Base.send( :sanitize_sql_array,
                                                           [ comparison_query,
                                                             { target_date: target_date.to_date.strftime('%d/%m/%Y'),
                                                               next_target_date: next_target_date.to_date.strftime('%d/%m/%Y') }
                                                           ] )
      comparison_result = ActiveRecord::Base.connection.select_all(prepared_comparison_query).first
      puts "#{target_date},#{next_target_date},#{comparison_result['msg']},#{comparison_result['ext']},#{comparison_result['msg_ext']}"
    end
    puts "#{Time.now} - finalized results for comparison:"

    final_time = Time.now

    import_time = final_time.to_f - initial_time.to_f

    puts "#{Time.now} - Microsiga registers match finished in #{import_time} seconds"
  end
end
