class SessionsController < Devise::SessionsController
  protected

  def after_sign_in_path_for(_resource)
    profile_path
  end
end
