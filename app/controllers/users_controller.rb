class UsersController < ApplicationController
  before_action :set_user, only: %I[edit update]

  def index
  end

  def show
  end

  def new
    @user = User.new
    @user.decorate
  end

  def create
    @user = User.new(user_params)
    @user.decorate
    authorize @user
    if @user.save
      flash[:notice] = "#{@user.full_name} has been successfully created as a #{@user.role.name} and email #{@user.email}."
      redirect_to new_user_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    authorize @user
    if @user.update(user_params)
      flash.now.alert = "#{@user.full_name} has been successfully updated as a #{@user.role.name} and email #{@user.email}."
      redirect_to new_user_path
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

  def set_user
    @user = User.find(params[:id])
    @user.decorate
  end
end
