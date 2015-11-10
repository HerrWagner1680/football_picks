class UsersController < ApplicationController
  helper_method :current_user

  def current_user
    if session[:user_id]
      @current_user = User.find(session[:user_id])
    else
      @current_user = nil
    end
  end

  def index
    @current_user = User.find(session[:user_id])
    #@userrr = User.find(params[:id])
    @user = User.new
    if @current_user.admin == true
        redirect_to "/admin"
    end
  end

  def create
    @user = User.new(params[:users])
   # @pick.user_id = current_user.id

    if @user.save!
      flash[:notice] = "Pick Created"
    else
      flash[:alert] = @pick.errors.full_messages
    end
    redirect_to "/users"
  end

  def new
    @user = User.new
  end

  def edit
    @pick = Pick.find(params[:id])
  end

  def show
    @pick = Pick.find(params[:id])
    @current_user = User.find(session[:user_id])
  end

  def update
    @pick = Pick.find(params[:id])
    if @pick.update(params[:post])
      flash[:notice] = "Post updated"
    else
      flash[:alert] = "Error Updating Post"
    end
    redirect_to "/users"
  end

  def destroy
    @pick = Pick.find(params[:id])
    if @pick.destroy
      flash[:notice] = "Post was thrown out"
    else
      flash[:alert] = "Post was not destroyed"
    end
    redirect_to "/users"
  end

end
