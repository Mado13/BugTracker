class RegistrationsController < Devise::RegistrationsController
  protected

  def after_sign_up_path_for(_resource)
    user_path(current_user)
  end

  def after_sign_out_path_for(_resource_or_scope)
    redirect_to new_user_session_path
  end
end
