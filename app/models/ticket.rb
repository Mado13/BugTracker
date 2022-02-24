class Ticket < ApplicationRecord
  belongs_to :lead_developer, class_name: 'User'
  belongs_to :project
  has_many :ticket_assignments
  has_many :developers, through: :ticket_assignments, foreign_key: :developer_id, validate: false
  has_one :project_manager, through: :project
  has_many :comments

  # scope for tickets by developer
  scope :developer_tickets, lambda { |id|
    includes(:ticket_assignments)
      .where(ticket_assignments: { developer_id: id })
      .all
  }

  # scope for tickets by project manager
  scope :project_manager_tickets, lambda { |id|
    includes(:project)
      .where(project: { project_manager_id: id })
      .all
  }

  # scope to count all the tickets according to delimiter that will passed
  # as an argument
  scope :tickets_counts, lambda { |delimiter|
    # set query to be the value of ticket. the argument that is passed by
    # calling the scope and than calls all SQL queries with query as the argument
    query = "tickets.#{delimiter}"
    select(query)
      .group(query)
      .order("#{query} DESC")
      .count
  }

  def new
    @ticket = Ticket.new
  end
end
