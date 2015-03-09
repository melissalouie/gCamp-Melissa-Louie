class Membership < ActiveRecord::Base
  belongs_to :project
  belongs_to :user
  validates :user_id, presence: :true, uniqueness: true
end
