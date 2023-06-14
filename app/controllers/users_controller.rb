class UsersController < ApplicationController
  before_action :require_login, only: [:show, :edit, :update, :destroy]
  def index
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to show_profile_user_path(@user)
    else
      render 'new'
    end
  end

  def show_account
    @user = User.find(params[:id])
  end
  
  def show
    redirect_to show_profile_user_path(@user)
  end

  def show_profile
    @user = User.find(params[:id])
  end
  
  def edit_profile
    @user = current_user
  end

  def edit_account
    @user = current_user
  end

  def update_profile
    @user = current_user
    if @user.update(user_params)
      redirect_to show_profile_user_path(@user), notice: 'プロフィールを更新しました。'
    else
      render 'edit_profile'
    end
  end

  def update_account
    @user = current_user
    if @user.update_with_password(user_params)
      redirect_to show_account_user_path(@user), notice: 'プロフィールを更新しました。'
    else
      render 'edit_account'
    end
  end

  def destroy
    @user = current_user
    @user.destroy
    redirect_to signup_path
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation ,:bio, :icon, :current_password)
  end

  def require_login
    unless logged_in?
      redirect_to login_path
    end
  end
end
