class ProjectsController < ApplicationController
  before_action :restrict_access, only: [:new]

  def new
    if current_user.admin?
      @project = Project.new
      @project_managers = User.user_by_role('Project Manager')
    else
      @project = Project.new(project_manager: current_user)
    end
    @lead_developers = User.user_by_role('Lead Developer')
  end

  def create
    # If user tries to modify its id in the inspect tool they'll see an error message, otherwise project will be created
    if params[:project][:project_manager_id_id] == current_user.id.to_s || current_user.admin?
      @project = Project.create(project_params)
      if @project.valid?
        redirect_to project_path(@project)
      else
        @lead_developers = User.users_by_role("Lead Developer")
        @project_managers = User.users_by_role("Project Manager")
        render :new
      end
    else
      flash.now.alert = "Logged user id doesn't match the id of the user submitting the form, please try again."
      @project = Project.new(title: params[:project][:title], description: params[:project][:description], project_manager: current_user, lead_developer_id: params[:project][:lead_developer_id])
      @lead_developers = User.users_by_role("Lead Developer")
      render :new
    end
  end

  def index
    if current_user.admin?
      @projects = Project.all
    else
      user = User.find_by(id: params[:id])
      @user_projects = Project
    end
  end

  def show
    @project = Project.find_by(id: params[:id])
    @project_developer = @project.developers_uniq
    @project_tickets = Ticket.joins(:project).where(project_id: @project)
  end

  private

  def project_params
    params.require(:project).permit(
      :title,
      :description,
      :project_manager_id_id,
      :lead_developer_id_id
    )
  end
end
