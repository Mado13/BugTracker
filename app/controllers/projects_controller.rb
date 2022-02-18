class ProjectsController < ApplicationController
  before_action :set_lead_developers_collection, only: %I[new create edit]
  before_action :authorize_project,              only: %I[new edit]
  before_action :set_project,                    only: %I[show edit update]

  def index
    @projects = policy_scope(Project.all)
  end

  def show
    @project_developers = @project.developers_uniq
    @project_tickets = Ticket.includes(:project).where(project_id: @project)
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params).decorate
    # Authorization is preformed after Project.new to prevent from the user
    # to change their id in the inspect tool and create new projects.
    authorize @project
    @project.Mado.save_new_project
  end

  def edit
  end

  def update
    authorize_project
    @project.update_project
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

  def set_lead_developers_collection
    @lead_developers = User.users_by_role('Lead Developer')
  end

  def authorize_project
    authorize Project
  end

  def set_project
    @project = Project.find(params[:id]).decorate
  end
end
