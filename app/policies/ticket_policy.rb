class TicketPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      case user.role
      when 'Admin'
        @scope.all
      when 'Project Manager'
        @scope.project_manager_tickets(user.id)
      when 'Lead Developer'
        @scope.lead_developer_data(user.id)
      else
        @scope.developer_tickets(user.id)
      end
    end
  end

  def new?
    user.admin? || user.project_manager? || user.lead_developer?
  end

  # check if the user is lead developer that he the lead developer assign to the ticket
  # if the user is a project manager that he is the project's project manager
  # or if the user is admin.
  def create?
    if user.lead_developer?
      record.lead_developer_id == user.id
    elsif user.project_manager?
      record.project.project_manager_id == user.id
    elsif user.admin?
      true
    end
  end

  def edit?
    create?
  end

  def update?
    edit?
  end
end
