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

      ledger_importer = LedgerImporter.new("#{Rails.root}/#{ledgers_file}")
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

      extract_importer = ExtractImporter.new("#{Rails.root}/#{extracts_file}")
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

      microsiga_entry_importer = MicrosigaEntryImporter.new("#{Rails.root}/#{microsiga_file}")
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
    comparison_query = "select sum(microsiga_value) as msg, sum(extract_value) as ext, (sum(microsiga_value) - sum(extract_value)) as msg_ext, conta_origem
                        from (
                                  select sum(vlr_rs) as microsiga_value, 0 as extract_value, :conta_origem as conta_origem
                                  from microsiga_entries msg
                                  where conta_origem = :conta_origem
                                  and tipo_mapfre <> 'CH'
                                  and vencto_real = :target_date
                                  and nom_forn not like 'MAPFRE VERA CRUZ SEG%'
                                  and (
                                    status_oper = 'TPG' or
                                    ( status_oper = 'PPT'
                                      and fornecedor not in ('714320', '717575', '016720', '403435', '403436', '714252', '396934', '279708', '279709', '140610', '000027', '052302', '399958', '408435','138740')
                                      and nom_forn not in ('PREF. MUNICIPAL DE SAO PAULO',
                                                           'EMP.BRA.CORREIOS E TELEGRAFOS',
                                                           '10. TABELIAO DE PROTESTO DE LE',
                                                           '3 TABELIAO PROT. LETRAS TITULO',
                                                           '8. TABELIAO DE PROTESTO DE LET',
                                                           'BANCO DO BRASIL S/A',
                                                           'IRB BRASIL RESSEGUROS SA',
                                                           'CURITIBA 4 TAB DE PROT TIT DOC',
                                                           '2 TAB PROT LET TIT S J RIO PRE',
                                                           'BRASILVEICULOS COMPANHIA SEGUR',
                                                           'BRASILVEICULOS COMPANHIA SEGUR',
                                                           '6. TABELIAO DE PROTESTO DE LET',
                                                           '1 TAB PROTESTO LET TIT COM CAP',
                                                           '5. TABELION DE PROTESTO DE SP',
                                                           'MAPFRE AFFINITY SEGURADORA SA')
                                    )
                                  )

                                  UNION ALL

                                  select 0 as microsiga_value, coalesce(sum(base_amt), 0) * -1 as extract_value, :conta_origem as conta_origem
                                  from extracts
                                  where tcode_5 = :tcode_5
                                  and upper(description) like '%DEVOL.TED/DOC%'
                                  and transaction_date > to_date(:target_date, 'DD/MM/YYYY')
                                  and transaction_date <= to_date(:next_target_date, 'DD/MM/YYYY')

                                  UNION ALL

                                  select 0 as microsiga_value, sum(base_amt) as extract_value, :conta_origem as conta_origem
                                  from extracts
                                  where tcode_5 = :tcode_5
                                  and ( description like '%FORNECEDOR%'
                                        or description like '%PFOR%'
                                        or description like '%PAGFOR%'
                                        or description like '%PAG DIVERSOS%'
                                        or description like '%E.ELETRICA%' )
                                  and debit_credit_marker = 'D'
                                  and transaction_date = to_date(:target_date, 'DD/MM/YYYY')
                        ) conciliate_extracts_msg
                        group by conta_origem"

    acccounts_to_process = [
        {tcode_5: 'B00003990004251', conta_origem: '042515-2'},
        {tcode_5: 'B00002370506907', conta_origem: '050690-7'},
        {tcode_5: 'B00000019294414', conta_origem: '929441-4'}
    ]
    dates_to_process = ActiveRecord::Base.connection.select_all(dates_query)

    puts "#{Time.now} - Processing #{dates_to_process.count} different dates"

    puts "#{Time.now} - initializing results for comparison:"
    puts 'data,data_seguinte,valor_microsiga,valor_extrato,diferenca,conta_origem'
    acccounts_to_process.each do |account|
      dates_to_process.each do |dt|
        target_date = dt['target_date']
        next_target_date = dt['next_target_date']
        next_target_date = next_target_date.to_date + 2.day if next_target_date.to_date.saturday?

        prepared_comparison_query = ActiveRecord::Base.send( :sanitize_sql_array,
                                                             [ comparison_query,
                                                               { target_date: target_date.to_date.strftime('%d/%m/%Y'),
                                                                 next_target_date: next_target_date.to_date.strftime('%d/%m/%Y') }.merge!(account)
                                                             ] )
        comparison_result = ActiveRecord::Base.connection.select_all(prepared_comparison_query).first
        puts "#{target_date},#{next_target_date},#{comparison_result['msg']},#{comparison_result['ext']},#{comparison_result['msg_ext']},#{comparison_result['conta_origem']}"
        begin
          ActiveRecord::Base.connection.execute " insert into
                                                  microsiga_extracts(target_date, next_date, valor_microsiga, valor_extrato, diferenca, conta_origem)
                                                  values ('#{target_date}',
                                                          '#{next_target_date}',
                                                          #{comparison_result['msg']},
                                                          #{comparison_result['ext']},
                                                          #{comparison_result['msg_ext']},
                                                          '#{comparison_result["conta_origem"]}')";
        rescue Exception => e
          puts e.to_s
        end
      end
    end

    puts "#{Time.now} - finalized results for comparison:"

    final_time = Time.now

    import_time = final_time.to_f - initial_time.to_f

    puts "#{Time.now} - Microsiga registers match finished in #{import_time} seconds"
  end

  desc "match registers between microsiga and ledgers"
  task :conciliate => :environment do
    puts "#{Time.now} - Beggining registers match between microsiga and ledgers..."
    initial_time = Time.now

    dates_query = " select target_date from microsiga_extracts
                    where conta_origem = '929441-4'
                          and target_date > '2015-04-30'
                          and diferenca = 0
                    order by 1;"

    conciliation_query = " SELECT DISTINCT
                                   razao.line_no,
                                   razao.journal,
                                   microsiga.vlr_titulo,
                                   razao.base_amt,
                                   microsiga.nom_forn,
                                   microsiga.id_cnab_mapf,
                                   microsiga.fornecedor,
                                   microsiga.no_titulo
                            FROM (
                                   SELECT *
                                   FROM microsiga_entries msg
                                   WHERE msg.vencto_real = :target_date
                                         AND msg.conta_origem = '929441-4'
                                         AND msg.tipo_mapfre <> 'CH'
                                         AND msg.nom_forn NOT LIKE 'MAPFRE VERA CRUZ SEG%'
                                         AND (
                                           msg.status_oper = 'TPG' OR
                                           (msg.status_oper = 'PPT'
                                            AND msg.fornecedor NOT IN
                                                ( '714320',
                                                  '717575',
                                                  '016720',
                                                  '403435',
                                                  '403436',
                                                  '714252',
                                                  '396934',
                                                  '279708',
                                                  '279709',
                                                  '140610',
                                                  '000027' )
                                            AND msg.nom_forn NOT IN ('PREF. MUNICIPAL DE SAO PAULO',
                                                                     'EMP.BRA.CORREIOS E TELEGRAFOS',
                                                                     '10. TABELIAO DE PROTESTO DE LE',
                                                                     '3 TABELIAO PROT. LETRAS TITULO',
                                                                     '8. TABELIAO DE PROTESTO DE LET',
                                                                     'BANCO DO BRASIL S/A',
                                                                     'IRB BRASIL RESSEGUROS SA',
                                                                     'CURITIBA 4 TAB DE PROT TIT DOC',
                                                                     '2 TAB PROT LET TIT S J RIO PRE',
                                                                     'BRASILVEICULOS COMPANHIA SEGUR',
                                                                     'BRASILVEICULOS COMPANHIA SEGUR')
                                           )
                                         )
                                         AND msg.tipo_rubrica IN ('21', '08', '23', '25')
                                 ) microsiga
                              INNER JOIN (
                                           SELECT *
                                           FROM ledgers
                                           WHERE transaction_date = to_date(:target_date, 'DD/MM/YYYY')
                                                 AND tcode_5 = 'B00000019294414'
                                                 AND journal_type = 'TWTES'
                                                 AND debit_credit_marker = 'C'
                                                 AND upper(description) NOT LIKE '%CH%'
                                         ) razao
                                ON microsiga.vlr_titulo = razao.base_amt
                            ORDER BY 3, 2, 1;"

    puts "#{Time.now} - initializing results for conciliation:"

    dates_to_process = ActiveRecord::Base.connection.select_all(dates_query)
    puts "#{Time.now} - processing: #{dates_to_process.count} different dates."

    puts 'line_no,journal,vlr_titulo,base_amt,nom_forn,id_cnab_mapf'
    dates_to_process.each do |date|
      target_date = date["target_date"]
      prepared_conciliation_query = ActiveRecord::Base.send( :sanitize_sql_array,
                                                           [ conciliation_query,
                                                             { target_date: target_date.to_date.strftime('%d/%m/%Y') }
                                                           ] )


      conciliation_results = ActiveRecord::Base.connection.select_all(prepared_conciliation_query)

      conciliation_results.each do |con|
        line_no = con['line_no']
        journal = con['journal']
        id_cnab_mapf = con['id_cnab_mapf']
        fornecedor = con['fornecedor']
        no_titulo = con['no_titulo']

        puts "#{line_no},#{journal},#{id_cnab_mapf},#{fornecedor},#{no_titulo}"
        begin
          ActiveRecord::Base.connection.execute "insert into microsiga_ledgers(journal, line_no, id_cnab_mapf, fornecedor, no_titulo) values ('#{journal}','#{line_no}','#{id_cnab_mapf}','#{fornecedor}','#{no_titulo}')";
        rescue Exception => e
          puts e.to_s
        end
      end

    end
    puts "#{Time.now} - finalized concilliation:"

    final_time = Time.now

    match_time = final_time.to_f - initial_time.to_f

    puts "#{Time.now} - Microsiga X Ledgers match finished in #{match_time} seconds"
  end
end