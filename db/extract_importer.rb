require 'csv'

class ExtractImporter
  attr_reader :filename

  def initialize(filename)
    @filename = filename
  end

  def entries
    @entries ||= build_extracts
  end

  private

  def build_extracts
    data.collect do |row|
      row[:transaction_date] = format_date(row[:transaction_date])
      row[:alloc_date]       = format_date(row[:alloc_date])
      row[:entry_date]       = format_date(row[:entry_date])
      row[:due_date]         = format_date(row[:due_date])
      row[:base_amt]         = format_decimal(row[:base_amt])
      row[:signal_base_amt]  = format_decimal(row[:signal_base_amt])
      row[:other_amt]        = format_decimal(row[:other_amt])
      row[:signal_other_amt] = format_decimal(row[:signal_other_amt])

      Extract.new(row.to_hash)
    end
  end

  def data
    data = CSV.open(filename, 'r', encoding: 'utf-8', col_sep: ',', headers: true, header_converters: :symbol)
    puts "#{Time.now} - #{filename}' Opened..."
    data
  end

  def format_date(value)
    Date.strptime(value, '%d/%m/%Y') if value
  end

  def format_decimal(value)
    BigDecimal.new(value.to_s.gsub(' ', '').gsub('.', '').gsub(',', '.'))
  end
end
