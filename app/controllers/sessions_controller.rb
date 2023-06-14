class SessionsController < ApplicationController
  before_action :require_login, only: [:destroy]

  def new
    session[:user_id] = nil
  end

  def create
    user = User.find_by(email: params[:email].downcase)
    if user && user.authenticate(params[:password])
      log_in(user)
      session[:user_id] = user.id
      redirect_to show_profile_user_path(user)
    else
      flash.now[:danger] = 'メールアドレスかパスワードが間違っています。'
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to login_path
  end

  def require_login
    unless logged_in?
      redirect_to login_path
    end
  end
end
