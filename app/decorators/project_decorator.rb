class ProjectDecorator < ApplicationDecorator
  include Draper::LazyHelpers

  delegate_all
  # Module Mado
  #   include ActionController::Base
  #   def save_new_project
  #     if object.save
  #       redirect_to project_path(object)
  #     else
  #       # retrieve information from submitted form and re render
  #       object ||= Project.new
  #       render :new, project: object
  #     end
  #   end
  # end

#   def update_project
#     if @project.update
#       redirect_to project_path(@project)
#     else
#       @project ||= Project.new
#       render :edit, project: @project
#     end
#   end
# end
