class Ticket < ApplicationRecord
  belongs_to :lead_developer, class_name: 'User'
  belongs_to :project
  has_many :ticket_assignments
  has_many :developers, through: :ticket_assignments, foreign_key: :developer_id, validate: false
  has_one :project_manager, through: :project
  has_many :comments

  scope :developer_tickets, lambda { |id|
    includes(:ticket_assignments)
      .where(ticket_assignments: { developer_id: id })
      .all
  }

  scope :project_manager_tickets, lambda { |id|
    includes(:project)
      .where(project: { project_manager_id: id })
      .all
  }

  def new
    @ticket = Tikcet.new
  end
end
