class Birt::Core::LineChartReport < Birt::Core::BaseReport
  attr_accessor :data_set

  attr_accessor :title_label
  attr_accessor :legend_label

  attr_accessor :horizontal_label
  attr_accessor :vertical_label

  attr_accessor :horizontal_row
  attr_accessor :series_rows


  def initialize(xml_e)
    @series_rows = []
    super(xml_e) do
      @title_label = elem_text(xml_e, "/model:ChartWithAxes/Block/Children[@xsi:type='layout:TitleBlock']/Label/Caption/Value")
      @legend_label = elem_text(xml_e, "/model:ChartWithAxes/Block/Children[@xsi:type='layout:Legend']/Title/Caption/Value")
      @vertical_label = elem_text(xml_e, "/model:ChartWithAxes/Axes/AssociatedAxes/Title/Caption/Value")
      @horizontal_label = elem_text(xml_e, "/model:ChartWithAxes/Axes/Title/Caption/Value")

      @horizontal_row = elem_text(xml_e, "/model:ChartWithAxes/Axes/SeriesDefinitions/Series/DataDefinition/Definition").gsub("row[\"", '').gsub("\"]", '')


      xml_e.get_elements("/model:ChartWithAxes/Axes/AssociatedAxes/SeriesDefinitions/Series[@xsi:type='type:LineSeries']").each do |item|
        @series_rows << Birt::Core::SeriesRow.new(item)
      end

    end

    yield(self) if block_given?
  end

  def json
    @json = {}
    @json[:id] = @id
    @json[:title] = @title_label

    data_set_result = self.data_set.data_set_result

    _series_data = ->(data_result, series_name) {
      if series_name =~ /\//
        name = series_name.split("/")[0]
        num = series_name.split("/")[1].to_i
        data_result.columns[data_result.column_headers.index(name)].inject([]) { |acc, item| acc<<item/num; acc }
      else
        data_result.columns[data_result.column_headers.index(series_name)]
      end
    }

    @json[:x_data] = data_set_result.columns[data_set_result.column_headers.index(@horizontal_row)]
    @json[:series] = []
    @series_rows.each { |series_row|
      @json[:series] << {
          name: series_row.display_name,
          data: _series_data.call(data_set_result, series_row.column_name)
      }
    }
    @json
  end

end