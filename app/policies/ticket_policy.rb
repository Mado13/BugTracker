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

end
