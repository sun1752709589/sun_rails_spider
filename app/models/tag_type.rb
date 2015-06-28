class TagType < ActiveRecord::Base
  validates :name, presence: true
  has_many :tags, dependent: :destroy
end
