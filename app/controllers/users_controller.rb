class UsersController < ApplicationController

  def index
  end

  def show
    @user = UserDecorator.new(current_user)
  end

  def new
    @user = UserDecorator.new(User.new)
  end

  def create
    @user = UserDecorator.new(User.create(user_params))
    if @user.valid?
      flash.alert = "#{@user.full_name} has been successfully created as a #{@user.role.name} and email #{@user.email}."
      redirect_to new_user_path, flash: { alert: alert }
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    if @user.valid?
      flash.now.alert = "#{@user.full_name} has been successfully updated as a #{@user.role.name} and email #{@user.email}."
      redirect_to new_user_path, flash: { alert: alert }
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :first_name,
      :last_name,
      :role_id,
      :email,
      :password
    )
  end
end
