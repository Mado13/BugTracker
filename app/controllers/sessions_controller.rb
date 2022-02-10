class SessionsController < ApplicationController
  def create
    user = user.find_by(email: params[:email])
    if user
      if user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect to user_path(user)
      else
        flash.now.alert = 'Incorrect password, please try again.'
        redirect to '/', flash: { alert: alert }
      end
    else
      flash.now.alert 'Email not found , please try again.'
      redirect to '/', flash: { alert: alert}
    end
  end
end
