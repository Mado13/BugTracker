class Project < ApplicationRecord
  validates :title, presence: true, length: { in: 10..50 }

  # Belongs to a project Manager(User)
  belongs_to :project_manager, class_name: 'User', foreign_key: :project_manager_id

  # belongs to a Lead Developer(User)
  belongs_to :lead_developer, class_name: 'User', foreign_key: :lead_developer_id

  has_many :tickets
  has_many :ticket_assignments, through: :tickets
  has_many :developers, through: :ticket_assignments

  # Scope that returns all the projects that a developer is assigned to
  # through ticket assignments
  scope :developer_projects, lambda { |id|
    includes(:ticket_assignments)
      .where(ticket_assignments: { developer_id: id }).all
  }

  # Return the users the assigned to a project through a ticket assignment
  # and remove duplications
  def developers_uniq
    developers.distinct
  end
end
