class ProjectsController < ApplicationController
  before_action :restrict_access, only: [:new]

  def new
    @project = Project.new
    @lead_developers = User.users_by_role('Lead Developer')
    @user = UserDecorator.new(User.find_by(params[:id]))
  end

  def create
    # If user tries to modify its id in the inspect tool they'll see an error message, otherwise project will be created
    user = User.find_by(params[:id]).decorate
    if params[:project][:project_manager_id] == user.id.to_s || user.admin?
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
      user = User.find_by(params[:id]).decorate
      binding.pry
      @project = Project.joins(:tickets, :ticket_assignments)
                        .where(ticket_assignments: { developer_id: user.id })
                        .all
    end
    binding.pry
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
      :project_manager_id,
      :lead_developer_id
    )
  end
end
