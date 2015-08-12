require 'csv'

class MicrosigaEntryImporter
  attr_reader :filename

  def initialize(filename)
    @filename = filename
  end

  def entries
    @entries ||= build_microsiga_entries
  end

  private

  def build_microsiga_entries
    register = 1
    data.collect do |row|
      row[:dt_emissao]   = format_date(row[:dt_emissao])
      row[:dt_import]    = format_date(row[:dt_import])
      row[:dt_exportaca] = format_date(row[:dt_exportaca])
      row[:dt_ger_pagto] = format_date(row[:dt_ger_pagto])
      row[:dt_cancel_ch] = format_date(row[:dt_cancel_ch])
      row[:data_compens] = format_date(row[:data_compens])
      row[:data_exp_rj]  = format_date(row[:data_exp_rj])
      row[:vlr_titulo]   = format_decimal(row[:vlr_titulo])
      row[:vl_original]  = format_decimal(row[:vl_original])
      row[:vlr_rs]       = format_decimal(row[:vlr_rs])
      microsiga_entry = MicrosigaEntry.new(row.to_hash)
      puts "#{Time.now} - register #{register} created from file."
      register = register + 1
      microsiga_entry
    end
  end

  def data
    puts "#{Time.now} - #{filename}' Converting headers..."
    data = CSV.open(filename, 'r', encoding: 'utf-8', col_sep: ',', headers: true, header_converters: :symbol)
    puts "#{Time.now} - #{filename}' Opened..."
    data
  end

  def format_date(value)
    Date.strptime(value, '%d/%m/%Y') if clean_date(value)
  rescue Exception => e
    puts value
    puts e.message
    nil
  end

  def clean_date(value)
    date = value.to_s.strip
    (date.empty? || date == '/  /') ? nil : value
  end

  def format_decimal(value)
    BigDecimal.new(value.to_s.gsub(' ', '').gsub('.', '').gsub(',', '.'))
  end
end
