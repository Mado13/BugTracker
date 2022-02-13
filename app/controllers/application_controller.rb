class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!
  before_action :assign_roles
  before_action :set_users

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:role_id, :first_name, :last_name])
  end

  def assign_roles
    @roles = Role.all
  end

  def set_users
    @users = User.all
  end
end
