class MemberDetail < ActiveRecord::Base
  validates :member_id, presence: true, uniqueness: false
  belongs_to :member

end
