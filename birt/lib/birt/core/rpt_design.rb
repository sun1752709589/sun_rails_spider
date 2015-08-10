class Birt::Core::RptDesign

  #design文件路径
  attr_accessor :rpt_design_path

  #报表的名字
  attr_accessor :display_name

  #数据源
  attr_accessor :data_sources

  #数据集
  attr_accessor :data_sets

  #图表
  attr_accessor :reports


  def initialize(rpt_design_path)
    self.rpt_design_path = rpt_design_path
    @data_sources, @data_sets = {}, {}
    @reports = {tables: {}, line_charts: {}}
  end

  def display_name(root=nil)
    unless @display_name
      _root = root|| REXML::Document.new(File.read(self.rpt_design_path)).root
      names = _root.get_elements("/report/text-property[@name='displayName']")
      @display_name = names[0].text if names && names[0]
    end
    @display_name
  end

  #解析文件
  def parse_rpt
    _root = REXML::Document.new(File.read(self.rpt_design_path)).root

    #报表名称
    @display_name = self.display_name(_root)

    #数据源
    _root.each_element(xpath = '/report/data-sources/oda-data-source') do |item|
      p @data_sources[item.attribute(:name).value] = Birt::Core::DataSource.new(item)
    end

    #数据集
    _root.each_element(xpath='/report/data-sets/oda-data-set') do |item|
      @data_sets[item.attribute(:name).value] = Birt::Core::DataSet.new(item) do |data_set|
        data_set.data_source = @data_sources[item.get_elements("property[@name='dataSource']")[0].text]
      end
    end

    #table报表
    _root.each_element(xpath='/report/body/table') do |item|
      @reports[:tables]["#{item.attribute(:id).value}"] = Birt::Core::TableReport.new(item) do |report|
        report.data_set = @data_sets[item.get_elements("property[@name='dataSet']")[0].text]
      end
    end

    #Chart报表
    _root.each_element(xpath="/report/body/extended-item[@extensionName='Chart']") do |item|
      item_data = REXML::Document.new(item.get_elements("xml-property[@name='xmlRepresentation']")[0].text).root

      #线性报表
      if item_data.get_elements("Type")[0].text=='Line Chart'
        @reports[:line_charts]["#{item.attribute(:id).value}"] = Birt::Core::LineChartReport.new(item_data) do |report|
          report.id = item.attribute(:id).value
          report.data_set = @data_sets[item.get_elements("property[@name='dataSet']")[0].text]
        end
        @reports[:line_charts]["#{item.attribute(:id).value}"].json
      end
    end
  end

end