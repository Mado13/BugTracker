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

  def self.tickets_by_priority
    select("tickets.priority, COUNT(tickets.priority) AS tickets_count").group("tickets.priority").order("COUNT(tickets.priority) DESC")
  end

  def self.tickets_by_category
    select("tickets.category, COUNT(tickets.category) AS tickets_count").group("tickets.category").order("COUNT(tickets.category) DESC")
  end

  def self.tickets_by_status
    select("tickets.status, COUNT(tickets.status) AS tickets_count").group("tickets.status").order("COUNT(tickets.status) DESC")
  end
end
