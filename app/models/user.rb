class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :role
  has_many :projects

  def self.users_by_role(role)
    Role.find_by(name: role).users
  end

  def full_name
    "#{first_name} #{last_name}"
  end
end
