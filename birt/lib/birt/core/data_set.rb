class Birt::Core::DataSet

  attr_accessor :name
  attr_accessor :columns
  attr_accessor :query_text
  attr_accessor :data_set_result
  attr_accessor :data_source

  def initialize(xml_element)
    @columns = []
    if xml_element
      self.name = xml_element.attribute(:name).value
      xml_element.get_elements("list-property[@name='resultSet']/structure/property[@name='name']").each do |column|
        self.columns << column.text
      end
      self.query_text = xml_element.get_elements("xml-property[@name='queryText']")[0].text.gsub("\n", ' ')
    end
    yield(self) if block_given?
  end

  #开始查询
  def query
    Birt::Core::Mysql.query(self.data_source, query_text)
  end

  #查询结果
  def data_set_result
    @data_set_result ||= Birt::Core::DataSetResult.new(self.query)
  end

end