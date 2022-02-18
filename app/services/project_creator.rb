class ProjectCreator < ApplicationService
  attr_reader :project

  def initialize(project)
    @project = project
  end

  def call
  end
end
