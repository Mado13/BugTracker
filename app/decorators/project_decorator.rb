class ProjectDecorator < SimpleDelegator
  def project_manager_hidden_fields
    if current_user.project_manager?
       f.hidden_field :project_manager_id_id
    end
  end
end
