class Birt::Core::DataSetResult

  attr_accessor :rows
  attr_accessor :row_headers
  attr_accessor :columns
  attr_accessor :column_headers

  def initialize(data_result)
    @rows, @row_headers, @columns, @column_headers= [], [], [], []

    data_result.each do |row|
      @column_headers = row.keys.inject([]) { |acc, (k,v)| acc<<k.to_s; acc } if column_headers.empty?
      @row_headers << row.values[0]
      @rows << row.values
      row.values.each_with_index { |v, i| @columns[i]||=[]; @columns[i]<<v; }
    end if data_result

  end

end