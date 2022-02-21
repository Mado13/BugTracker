class UsersController < ApplicationController
  before_action :set_user, only: %I[show edit update]
  decorates_assigned :user

  def index
    @users = User.all
  end

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    authorize @user
    if @user.save
      redirect_to user_path(@user)
      flash[:notice] = "#{@user.full_name} has been successfully created as a #{@user.role} and email #{@user.email}."
    else
      render :new
    end
  end

  def edit
    authorize @user
  end

  def update
    authorize @user
    if @user.update(user_params)
      redirect_to user_path(@user)
      flash[:notice] = "#{@user.full_name} has been successfully updated as a #{@user.role} and email #{@user.email}."
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
  end
end
