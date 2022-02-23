class DashboardController < ApplicationController
  def dashboard
    if current_user.admin?
      @tickets_by_category = Ticket.tickets_by_category
      @tickets_by_priority = Ticket.tickets_by_priority
      @tickets_by_status = Ticket.tickets_by_status
      @tickets_by_developer = User.tickets_by_developer
      @projects_by_lead_developer = User.projects_by_lead_developer
      @projects_by_project_manager = User.projects_by_project_manager
    else
      redirect_to "/"
    end
  end
end
