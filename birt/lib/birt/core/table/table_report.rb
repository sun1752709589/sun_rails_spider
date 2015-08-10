class Birt::Core::TableReport < Birt::Core::BaseReport
  attr_accessor :header
  attr_accessor :detail
  attr_accessor :footer
  attr_accessor :data_set

  def initialize(xml_element)

    super(xml_element) do
      self.header = Birt::Core::TableHeader.new(xml_element.get_elements(xpath="header")[0])
      self.detail = Birt::Core::TableDetail.new(xml_element.get_elements(xpath="detail")[0])
      self.footer = Birt::Core::TableDetail.new(xml_element.get_elements(xpath="footer")[0])
    end

    yield(self) if block_given?
  end
end