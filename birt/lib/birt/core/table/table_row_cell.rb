class Birt::Core::TableRowCell < Birt::Core::BaseReport
  attr_accessor :cell_labels
  attr_accessor :cell_datas

  def initialize(x_ele)
    self.cell_labels = Array.new
    self.cell_datas = Array.new

    super(x_ele) do
      x_ele.get_elements(xpath="label").each { |label| self.cell_labels.push Birt::Core::TableCellLabel.new(label) }
      x_ele.get_elements(xpath="data").each { |data| self.cell_datas.push Birt::Core::TableCellData.new(data) }
    end

    yield(self) if block_given?
  end
end