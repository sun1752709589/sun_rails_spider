class Birt::Core::TableCellLabel < Birt::Core::BaseReport

  attr_accessor :text_properties

  def initialize(x_ele)
    self.text_properties = Array.new

    super(x_ele) do
      x_ele.get_elements(xpath="text-property").each { |tp| self.text_properties.push Birt::Core::TextProperty.new(tp) }
    end

    yield(self) if block_given?
  end

end