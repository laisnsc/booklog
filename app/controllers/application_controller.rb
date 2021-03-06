class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include Pundit

  helper_method :current_user

  add_flash_types :welcome, :success, :warning

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def authorize
    redirect_to '/login' unless current_user
  end
end
