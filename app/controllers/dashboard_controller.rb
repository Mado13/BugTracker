class DashboardController < ApplicationController
  def dashboard
    # Using 'authorize self' to run pundit policy 'dashboard_controller_policy'
    # passing the controller because there is no model to authorize on but
    # authorization on accesssing to dashboard page is needed.
    authorize self
    @tickets_by_category = Ticket.tickets_counts('category')
    @tickets_by_priority = Ticket.tickets_counts('priority')
    @tickets_by_status = Ticket.tickets_counts('status')
    @tickets_by_developer = User.tickets_by_developer
    @projects_by_lead_developer = User.count_projects('lead_developer')
    @projects_by_project_manager = User.count_projects('project_manager')
  end
end
