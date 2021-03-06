class SessionsController < ApplicationController
  def new
    user = User.find_by(login_name: params[:session][:login_name].downcase)
    # user = User.find(params[:session][:id])
  end

  def create
    # user = User.find(params[:session][:id])
    user = User.find_by(login_name: params[:session][:login_name].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id.to_s
      redirect_to user_path(user.login_name), welcome: 'Logged In!'
    else
      flash.now[:alert] = 'Incorrect user or password, try again'
      render 'home/index'
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to root_path, notice: 'Logged out successfully!'
  end
end
