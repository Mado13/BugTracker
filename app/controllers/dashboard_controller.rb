class DashboardController < ApplicationController
  def dashboard
    if current_user.admin?
      @tickets_by_category = Ticket.tickets_counts('category')
      @tickets_by_priority = Ticket.tickets_counts('priority')
      @tickets_by_status = Ticket.tickets_counts('status')
      @tickets_by_developer = User.tickets_by_developer
      @projects_by_lead_developer = User.count_projects('lead_developer')
      @projects_by_project_manager = User.count_projects('project_manager')
    else
      redirect_to root_path
      falsh[:notice] = 'You are not authorized to preform that action'
    end
  end
end
