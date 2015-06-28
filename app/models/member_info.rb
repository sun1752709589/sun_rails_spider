class MemberInfo < ActiveRecord::Base
  belongs_to :member
  has_one :avatar, class_name:'MemberAvatar',primary_key: 'member_id',foreign_key: 'member_id'

  validates :member_id, presence: true, uniqueness: true

end
