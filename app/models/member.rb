class Member < ActiveRecord::Base
  has_and_belongs_to_many :tags#, :association_foreign_key => "tags_id"
  has_one :member_avatar
  has_one :member_detail
  has_one :member_info
  has_one :member_monologue

end