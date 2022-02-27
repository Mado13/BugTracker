class ApplicationController < ActionController::Base
  include Pundit::Authorization

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!


  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  # adding role_id, first_name, last_name to devise user registration
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %I[role_id first_name last_name])
  end

  def after_sign_in_path_for(_resource)
    user_path(current_user)
  end

  def after_sign_out_path_for(_resource_or_scope)
    new_user_session_path
  end

  def set_roles
    @roles = Roles.all
  end

  # Override Devise current_user to add decorator methods to current_user
  def current_user
    UserDecorator.decorate(super) unless super.nil?
  end

  # alert on redirct for any of pundit failed authorization
  def user_not_authorized
    flash[:alert] = 'You Are Not Authorized To Preform That Action!'
    redirect_to(request.referer || root_path)
  end
end
