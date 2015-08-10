class Birt::Core::BaseReport
  attr_accessor :id

  def initialize(xml_element)
    if xml_element
      self.id = xml_element.attribute(:id).value if xml_element.attribute(:id)
    end

    yield(self) if block_given?
  end

  def elem_text(xml_element, xpath)
    elements = xml_element.get_elements(xpath)
    elements&&elements[0] ? elements[0].text : nil
  end

end