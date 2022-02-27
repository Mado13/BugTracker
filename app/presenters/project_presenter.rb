class ProjectPresenter
  def initialize(project, current_user, template)
    @project = project
    @user = current_user
    @template = template
  end

  # Returns the view template and then creates a helper as h. when want to call
  # Rails helpers on the view, and matching the pattern to the one of Draper
  # with the decorators
  def h
    @template
  end

  # Renders Project Manager Select_Tag for new project form if the user is admin.
  def admin_select_tag
    return if @user.admin?

    h.select_tag 'project[project_manager_id]',
                 h.options_from_collection_for_select(User.users_by_role('Project Manager'), :id, :email),
                 class: 'form-control col-md-4 col-form-label text-md-right',
                 prompt: 'Select Project Manager'
  end

  # render hidden_field_tag for new project form if the user creating the
  # project is A project manager, and sends his ID as project_manager_id
  def project_manager_hidden_fields
    h.hidden_field_tag 'project[project_manager_id]', @user.id if @user.project_manager?
  end

  # Only admin or project manager can see add new project buttoin
  def add_new_project
    return if @user.admin? || @user.project_manager?

    h.render inline: '<small class="add-edit-record"><%= link_to new_user_project_path(current_user) do %>
                      <i class="fas fa-plus-square fa-3x"></i>
                      <% end %></small>'
  end

  # Preventing from rendering a table content with the current_user information
  # if current user is project manager or lead developer
  # using the variable "res" in order to render multiple lines in the same condition
  def table_headers
    if @user.developer? || @user.admin?
      res = h.render inline: '<th>Project Manager</th>'
      res += h.render inline: '<th>Lead Developer</th>'
    elsif !@user.project_manager?
      h.render inline: '<th>Project Manager</th>'
    else
      h.render inline: '<th>Lead Developer</th>'
    end
  end

  # According to table_headers method table_data is rendering only the relevant
  # data to match the headers.
  # using the variable "res" in order to render multiple lines in the same condition
  def table_data(project)
    if @user.developer? || @user.admin?
      res = h.render inline: "<td>#{project.project_manager.email}</td>"
      res += h.render inline: "<td>#{project.lead_developer.email}</td>"
    elsif !@user.project_manager?
      h.render inline: "<td>#{project.project_manager.email}</td>"
    else
      h.render inline: "<td>#{project.lead_developer.email}</td>"
    end
  end

  # If the current user i a developer it will render the user's assigned tickets
  def developer_tickets
    return if @user.developer?

    h.render inline:
      '<div id="my-tickets">
        <h3 class="title">My tickets</h3>
        <table class="table table-striped">
          <thead>
            <th>Id.</th>
            <th>Title</th>
            <th>Status</th>
            <th>Priority</th>
            <th>Created on</th>
            <th>Last update</th>
          <thead>
          <tbody>
            <!-- will render the partial _ticket.html.erb in projects folder -->
            <%= render partial: \'ticket\', collection: @developer_tickets, as: :ticket %>
          </tbody>
        </table>
      </div>'
  end
end
