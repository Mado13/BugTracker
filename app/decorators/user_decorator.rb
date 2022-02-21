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

  def role
    object.role.name
  end

  def full_name
    "#{object.first_name} #{object.last_name}"
  end
end
