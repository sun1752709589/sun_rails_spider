class Region < ActiveRecord::Base
  has_many :children, class_name: "Region",foreign_key: "parent_id"
  belongs_to :parent, class_name: "Region"

end
