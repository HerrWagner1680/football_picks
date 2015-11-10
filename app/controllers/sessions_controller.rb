class SessionsController < ApplicationController

  def create
    @user = User.where(email: params[:email]).first
    if @user && @user.authenticate(params[:password]) 
      session[:user_id] = @user.id
      cookies[:user_id] = @user.id

		if @user.admin == true
			  redirect_to "/admin"
		else
		  flash[:notice] = "You are now logged in"
		  redirect_to "/users"
		end

    else
      flash[:alert] = ["Incorrect values"]
      redirect_to "/"
    end
  end

  def index
  end

  def new
    @post = Post.new
  end

  def destroy
  	# https://www.railstutorial.org/book/log_in_log_out
    session[:user_id] = nil
    cookies.delete :user_id
    redirect_to "/"
    flash[:notice] = "You have logged out."
   # if request.xhr?
    #  render :js => "window.location = '/'"
   # else
   #   redirect_to "/home"
   # end
  end

  private

  def sessions_params
    params.require(:user).permit(:email, :password, :password_digest)
  end
end
