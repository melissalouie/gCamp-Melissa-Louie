class User < ActiveRecord::Base
  has_secure_password
  validates :email, uniqueness: true
  validates :email, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :password, presence: true
  has_many :comments, dependent: :destroy
  has_many :tasks, through: :comments
  has_many :memberships, dependent: :destroy
  has_many :projects, through: :members

  def full_name
    "#{first_name} #{last_name}"
  end
end
