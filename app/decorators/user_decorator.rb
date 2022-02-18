class UserDecorator < ApplicationDecorator
  include Draper::LazyHelpers

  delegate_all

  # render hidden_field_tag for new project form if the user creating the
  # project is A project manager, and sends his ID as project_manager_id
  def project_manager_hidden_fields
    hidden_field_tag 'project[project_manager_id]', current_user.id if project_manager?
  end

  # Renders Project Manager Select_Tag for new project form if the user is admin.
  def admin_form_select_tag
    if current_user.admin?
      select_tag 'project[project_manager_id]',
                 options_from_collection_for_select(User.users_by_role('Project Manager'), :id, :email),
                 class: 'form-control',
                 prompt: 'Select Project Manager'
    end
  end

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
end
