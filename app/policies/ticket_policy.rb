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

  # Check if the uesr is the project's assigned lead_developer\project manager
  # or the user is admin.
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
    create?
  end
end
