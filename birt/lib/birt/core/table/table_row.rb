class Birt::Core::TableRow < Birt::Core::BaseReport

  attr_accessor :row_cells

  def initialize(x_ele)
    self.row_cells = Array.new

    super(x_ele) do
      x_ele.get_elements(xpath="cell").each { |cell| self.row_cells.push Birt::Core::TableRowCell.new(cell) }
    end

    yield(self) if block_given?
  end

end