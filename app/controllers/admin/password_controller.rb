class Admin::PasswordController < ApplicationController

  def do_password_fields_match
  	if params[:user][:password] === params[:user][:password_confirmation]
  		p "Pword Confirm and Pword match"
  		return true
  	else
  		flash[:error] = "Password and Password Confirmation do not match. Try again."
  		return false
  	end
  end

  def index
    current_user

    @current_user = User.find(session[:user_id])
    if @current_user.admin == false or @current_user.admin == nil
        redirect_to "/users/password"
    end
  end

  def is_email_blank
	params[:user][:email].blank?
  end

  def is_password_blank
 	params[:user][:password].blank? 	
  end

  def patch
  	p "PATCH PATCH PATCHPATCH"
  end

  def show
  	current_user

    @current_user = User.find(session[:user_id])
    if @current_user.admin == false or @current_user.admin == nil
        redirect_to "/users/password"
    end	
  end

  def update
  	current_user
  	p "XXXXXXXXX YOU ARE IN PASSWORD CONTROLLER #UPDATE XXXXXXX"

    @current_user = User.find(session[:user_id])
    if @current_user.admin == false or @current_user.admin == nil
        redirect_to "/users"
    end
  end

  def updating_password
  	@save_email = true
  	@save_password = true

  	if is_email_blank
  		p "EMAIL IS BLANK!!!!!!!"
  		#flash[:error] = "EMAIL IS BLANK!!!!!!!"
  		@save_email = nil
  	elsif current_user.email === params[:user][:email]
  		p "Oh you silly person, you already have that email!"
  		@save_email = nil
  	elsif User.exists?(email: params[:user][:email])
		p "EMAIL EXISTS?"
  		p "Another user already has that email. Try again."
  		flash[:error] = "Another user already has that email. Try again."
  		@save_email = false
  	elsif params[:user][:email].size < 7
  		p "That email address appears incomplete."
  		flash[:error] = "That email address appears incomplete."
  		@save_email = false
  	end

  	if is_password_blank
  		p "No, no no the password ist blank!"
  		#flash[:error] = "No, no, no the password is blank!"
  		@save_password = nil 
  	elsif params[:user][:password].size < 8
  		p "Password must have at least 8 or more characters."
  		flash[:error] = "Password must have at least 8 or more characters."
  		@save_password = false 
  	end

  	do_password_fields_match #returns either false or true
    p "updating_password in admin / password controller"
    p current_user
    p @save_email
    p @save_password
    if do_password_fields_match === false
    	render :action => :index
    elsif @save_password === false || @save_email === false
    	render :action => :index
    elsif @save_password === nil && @save_email === nil
    	flash[:notice] = "Login info remains unchanged"
    	redirect_to "/admin"
    elsif @save_password === nil && @save_email === true
	      if current_user.update(update_email_params)
			flash[:success] = "Login email updated. Password remains the same."
	      	redirect_to "/admin"
	      else
	      	flash[:alert] = current_user.errors.full_messages
	      	render :action => :index
	      end
	elsif @save_password === true && @save_email === nil
	      if current_user.update(update_password_params)
			flash[:success] = "Login password updated. Email remains the same."
	      	redirect_to "/admin"
	      else
	      	flash[:alert] = current_user.errors.full_messages
	      	render :action => :index
	      end		
	elsif @save_password === true && @save_email === true
	      if current_user.update(user_update_params)
			flash[:success] = "Login email and password updated"
	      	redirect_to "/admin"
	      else
	      	flash[:alert] = current_user.errors.full_messages
	      	render :action => :index
	      end
	end
  end	

  private

  	def update_email_params
      params.require(:user).permit(:email)
  	end

  	def update_password_params
      params.require(:user).permit(:password)
  	end

    def user_update_params
      params.require(:user).permit(:email,:password)
    end

end