class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.login_name.downcase!

    if @user.save
      flash[:notice] = "Your account was created successfully"
      redirect_to root_path
    else
      flash.now.alert = "Something went wrong. Please try again"
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:name, :login_name, :birth_date,
                                 :password, :password_confirmation)
  end
end
