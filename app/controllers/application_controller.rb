class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!
  before_action :set_users

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %I[role_id first_name last_name])
  end

  def after_sign_in_path_for(_resource)
    user_path(current_user)
  end

  def set_users
    @users = User.all
  end

  def set_roles
    @roles = Roles.all
  end

  def restrict_access
    redirect to user_path(cuurent_user) unless current_user.admin? || current_user.project_manager?
  end
end
