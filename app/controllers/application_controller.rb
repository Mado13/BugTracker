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

  # Override Devise current_user to add decorator methods to current_user
  def current_user
    UserDecorator.decorate(super) unless super.nil?
  end

  # Redirect unauthroized users back to profile page
  def restrict_access
    decorate_current_user
    redirect to user_path(cuurent_user) unless current_user.admin? || current_user.project_manager?
  end
end
