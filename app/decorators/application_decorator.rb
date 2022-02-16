class ApplicationDecorator < Draper::Decorator
  def admin?
    object.role.name == 'Admin'
  end

  def project_manager?
    object.role.name == 'Project Manager'
  end

  def lead_developer?
    object.role.name == 'Lead Developer'
  end
end
