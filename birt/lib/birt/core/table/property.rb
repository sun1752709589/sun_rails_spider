class Birt::Core::Property < Birt::Core::BaseReport
  attr_accessor :name
  attr_accessor :text

  def initialize(x_ele)

    super(x_ele) do
      self.name = x_ele.attribute(:name).value
      self.text = x_ele.text
    end

    yield(self) if block_given?
  end

end