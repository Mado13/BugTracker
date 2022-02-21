class ProjectPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      case user.role
      when 'Admin'
        @scope.all
      when 'Project Manager'
        @scope.where(project_manager_id: user)
      when 'Lead Developer'
        @scope.lead_developer_data(user.id)
      else
        @scope.developer_projects(user.id)
      end
    end
  end

  def new?
    user.admin? || user.project_manager?
  end

  def create?
    record.project_manager_id == user.id || user.admin?
  end

  def edit?
    create?
  end

  def update?
    edit?
  end
end
