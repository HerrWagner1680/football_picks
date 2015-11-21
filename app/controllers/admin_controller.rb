class AdminController < ApplicationController


  protect_from_forgery with: :exception

  helper_method :current_user
  helper_method :latest_picks


  def create
    @archive_week = params[:pickchart]
    p @archive_week.values[0]
    @archive_week = @archive_week.values[0]

    @current_user = User.find(session[:user_id])
    if @current_user.admin == false or @current_user.admin == nil
        redirect_to "/users"
    end
    #adding info into url for archive week
    redirect_to "/admin" + "#" + @archive_week
  end


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

    if @current_user.admin == nil or @current_user.admin == false
			  redirect_to "/users"
    end

    @pickchart = Pickchart.new
    @pickcharts = Pickchart.all
    # @latest can also serve as week number variable
    @latest = Pickchart.maximum(:week)
    @latest_charts = Pickchart.where(week: @latest)
    @earliest = Pickchart.minimum(:week)
    latest_picks
  end

  def latest_picks
    @latest_pc_wk_created_at = @latest_charts.first.created_at
    @range = @latest_pc_wk_created_at .. Time.now
    @latest_picks = Pick.where(created_at: @range).all
    @latest_picks_array = @latest_picks.pluck(:user_id).uniq
  end

  def new
    @current_user = User.find(session[:user_id])
    if @current_user.admin == false
        redirect_to "/users"
    end
    @user = User.all

  end

  def show
    current_user
    @current_user = User.find(session[:user_id])
    if @current_user.admin == false or @current_user.admin == nil
        redirect_to "/users"
    end
  end
end
