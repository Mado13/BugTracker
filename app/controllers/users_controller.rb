class UsersController < ApplicationController

  def index
  end

  def show
    @user = User.find(params[:id])
  end

  private

  def admin?
    current_user.role.name == 'Admin'
  end
end
