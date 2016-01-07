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
    current_user
    @user = User.all
    @picks = Pick.all
    @pickchart = Pickchart.new
    @pickcharts = Pickchart.all
    @latest = Pickchart.maximum(:week)
    @latest_charttees = Pickchart.where(week: @latest)
    @latest_chart = @latest_charttees.order('id')
    @latest_charts = @latest_chart.where(winner: nil)
    @latest_charts_over = @latest_chart.where.not(winner: nil)
    @earliest = Pickchart.minimum(:week)

    @pc_time = Pickchart.where(week: @latest).first.created_at
    @range = @pc_time .. Time.now
    @any_picks = Pick.where(user_id: current_user.id, created_at: @range).exists?

  end

  def create
    @user = User.new(user_params)
   # @pick.user_id = current_user.id
   p "user admin below XXXXXXXXX"
   p @user.admin
   p params[:admin]

    if @user.save!
      flash[:notice] = "User Created"
    else
      flash[:alert] = @user.errors.full_messages
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

  private

    def user_params
      params.require(:user).permit(:admin,:user_name,:email,:password,:password_digest)
    end


end
