class UsersController < ApplicationController

  before_action :authentication_check, :except => [:new, :create]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
     @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      unless logged_in?
        log_in @user
      end
      redirect_to @user
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    User.destroy(params[:id])
    redirect_to users_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def validate_get_params
    unless User.exists?(params[:id])
      flash[:errors] = ["Inexistent User"]
      redirect_to users_path
    end
  end
end
