class SessionsController < ApplicationController

  def create

    if cookies[:pass]
      @pass = cookies[:pass]
    else
      @pass = "none"
    end

    @user = User.where(email: params[:email]).first
    if @user && @user.authenticate(params[:password]) 
      session[:user_id] = @user.id
      cookies[:user_id] = @user.id

  		if @user.admin == true && @pass === "none" || @user.admin == true && @pass === "no"
        #@asdfghjkl = "/admin"
        cookies.delete :pass 
  			redirect_to "/admin"
        #redirect_to @asdfghjkl
  		elsif @user.admin == true && @pass === "yes"
        cookies.delete :pass 
        redirect_to "/admin/password" 
      elsif @user.admin == false && @pass === "none" || @user.admin == false && @pass === "no"
  		  flash[:notice] = "You are now logged in"
        #@asdfghjkl = "/users"
        cookies.delete :pass 
        redirect_to "/users"
  		  #redirect_to @asdfghjkl
      elsif @user.admin == false && @pass === "yes"
        cookies.delete :pass 
        redirect_to "/users/password"
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
