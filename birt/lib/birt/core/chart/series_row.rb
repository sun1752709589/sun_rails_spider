class Birt::Core::SeriesRow< Birt::Core::BaseReport

  attr_accessor :column_name
  attr_accessor :display_name

  def initialize(xml_e)
    super(xml_e) do
      @column_name = elem_text(xml_e,"DataDefinition/Definition").gsub("row[\"", '').gsub("\"]", '')
      @display_name = elem_text(xml_e,"SeriesIdentifier")
    end
    yield(self) if block_given?
  end
end