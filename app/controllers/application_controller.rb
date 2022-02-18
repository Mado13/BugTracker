class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!
  before_action :set_users

  include Pundit

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

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

  def user_not_authorized
    flash[:alert] = 'Not Authorized'
    redirect_to(root_path)
  end
end
