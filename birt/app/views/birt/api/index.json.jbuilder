json.rpt_design do
  json.display_name @rpt_design.display_name
  json.tables @rpt_design.reports[:tables].values do |table|
    json.id table.id
    json.header parse_table_header(table.header)
    json.detail parse_table_detail(table.detail, table)
  end
  json.line_charts @rpt_design.reports[:line_charts].values.inject([]) { |acc, line_chart| acc<<line_chart.json; acc }
end
