class Birt::Core::TableDetail < Birt::Core::BaseReport
  attr_accessor :rows

  def initialize(x_ele)
    self.rows = Array.new

    super(x_ele) do
      x_ele.get_elements(xpath="row").each { |row| self.rows.push Birt::Core::TableRow.new(row) }
    end

    yield(self) if block_given?
  end
end