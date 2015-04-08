class User < ActiveRecord::Base
  has_secure_password
  validates :email, uniqueness: true
  validates :email, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :password, presence: true
  has_many :comments
  has_many :tasks, through: :comments
  has_many :memberships, dependent: :destroy
  has_many :projects, through: :members

  def full_name
    "#{first_name} #{last_name}"
  end

  def owns_project?(project_id)
    @project = Project.find_by(id: project_id)
    @memberships = @project.memberships
    @memberships.any?{ |membership| membership.user_id == self.id && membership.role == false }
  end

end
