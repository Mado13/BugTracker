class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :role
  has_many :projects

  def admin?
    role.name == 'Admin'
  end

  def project_manager?
    role.name == 'Project Manager'
  end

  def self.user_by_role(role)
    Role.find_by(name: role).users
  end
end
