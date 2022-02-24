class UserDecorator < ApplicationDecorator
  include Draper::LazyHelpers

  delegate_all

  def admin?
    object.role.name == 'Admin'
  end

  def project_manager?
    object.role.name == 'Project Manager'
  end

  def lead_developer?
    object.role.name == 'Lead Developer'
  end

  def developer?
    object.role.name == 'Developer'
  end

  def role
    object.role.name
  end
end
