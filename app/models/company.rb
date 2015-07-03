class Company < ActiveRecord::Base
  belongs_to :industry
  belongs_to :nature
  belongs_to :scale
  has_and_belongs_to_many :tags, join_table: "taggings"
  
  def get_tags
    arr = []
    self.tags.each do |tag|
      arr << tag.name
    end
    arr
  end
end
