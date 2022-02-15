class UserDecorator < ApplicationDecorator


  delegate_all

  include Draper::LazyHelpers

  def project_manager_hidden_fields
    render inline: "<%= hidden_field_tag 'project[project_manager_id]', @user.id %>" if project_manager?
  end

  def admin_form_select_tag
    render html: "<label class='select required form-label' for='project_project_manager_id'></label>"
    render inline: "<%= collection_select(:project, :project_manager_id, @project_managers, :id, :email, { class: 'form-control' }) %>" if admin?
  end

  def admin?
    object.role.name == 'Admin'
  end

  def project_manager?
    object.role.name == 'Project Manager'
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

end
