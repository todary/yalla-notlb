class GroupMember < ActiveRecord::Base
  belongs_to :group
  has_many :user
end
