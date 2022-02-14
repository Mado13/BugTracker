class ProjectsController < ApplicationController
  def index
    if current_user.admin?
      @projects = Project.all
    else
      user = User.find_by(id: params[:id])
    end
  end
end
