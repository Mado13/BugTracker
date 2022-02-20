class ProjectPresenter
  def initialize(project, template, current_user)
    @project = project
    @template = template
    @user = current_user.decorate
  end

  def h
    @template
  end

  # Renders Project Manager Select_Tag for new project form if the user is admin.
  def admin_select_tag
    if @user.admin?
       h.select_tag 'project[project_manager_id]',
                  h.options_from_collection_for_select(User.users_by_role('Project Manager'), :id, :email),
                  class: 'form-control col-md-4 col-form-label text-md-right',
                  prompt: 'Select Project Manager'
    end
  end

  # render hidden_field_tag for new project form if the user creating the
  # project is A project manager, and sends his ID as project_manager_id
  def project_manager_hidden_fields
    h.hidden_field_tag 'project[project_manager_id]', @user.id if @user.project_manager?
  end
end
