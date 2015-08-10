module Birt
  module ApiHelper

    def parse_table_header(table_header, table=nil)
      header = []
      table_header.rows.each_with_index { |row, index|
        header << []
        row.row_cells.each { |row_cell|
          header[index] << row_cell.cell_labels[0].text_properties[0].text
        }
      }
      header
    end

    def parse_table_detail(table_detail, table)
      detail = []
      table_detail.rows.each_with_index { |row|
        row.row_cells.each { |row_cell|
          data = row_cell.cell_datas[0].properties[0]
          data_set_result = table.data_set.data_set_result
          data_set_result.columns[data_set_result.column_headers.index(data.text)].each_with_index { |d, row_i|
            detail << [] unless detail[row_i]
            detail[row_i] << d
          }
        }
      }
      detail
    end
  end
end