class Birt::Core::TableCellData < Birt::Core::BaseReport


  attr_accessor :properties

  def initialize(x_ele)
    self.properties = Array.new

    super(x_ele) do
      x_ele.get_elements(xpath="property").each { |tp| self.properties.push Birt::Core::Property.new(tp) }
    end

    yield(self) if block_given?
  end

end