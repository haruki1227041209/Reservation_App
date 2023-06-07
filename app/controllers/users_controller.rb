class UsersController < ApplicationController
  before_action :require_login, only: [:show, :destroy]
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to profile_path(@user)
    else
      render 'new'
    end
  end

  def show_account
    @user = User.find(params[:id])
  end
  
  def show
    redirect_to show_profile_path
  end

  def show_profile
    @user = User.find(params[:id])
  end
  

  def edit
    @user = User.find(params[:id])
  end

  def edit_profile
    @user = User.find(params[:id])
  end

  def edit_account
    @user = User.find(params[:id])
  end

  def update_profile
    @user = User.find(params[:id])
     if @user.update(params.require(:user).permit(:icon, :name, :bio))
       flash[:notice] = "ユーザーIDが「#{@user.id}」の情報を更新しました"
       redirect_to show_profile_path
     else
       render "edit"
     end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to signup_path
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
