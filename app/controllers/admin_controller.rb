class AdminController < ApplicationController


  protect_from_forgery with: :exception

  helper_method :current_user

  def current_user
    if session[:user_id]
      @current_user = User.find(session[:user_id])
    else
      @current_user = nil
    end
  end

  def index
    @user = User.all
    @picks = Pick.all
    @current_user = User.find(session[:user_id])
    if @current_user.admin == false
			  redirect_to "/users"
    end
  end

  def show
    current_user
  end
end
