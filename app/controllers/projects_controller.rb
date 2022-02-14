class ProjectsController < ApplicationController
  def index
    if current_user.admin?
      @projects = Project.all
    else
      user = User.find_by(id: params[:id])
    end
  end

  def show
    @project = Project.find_by(id: params[:id])
    @project_developer = @project.developers_uniq
    @project_tickets = Ticket.joins(:project).where(project_id: @project)
  end
end
