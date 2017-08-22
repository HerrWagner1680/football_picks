class AdminController < ApplicationController
  # GLOBAL $TIMESTAMP VARIABLES IN admin_helper.rb
  protect_from_forgery with: :exception

  helper_method :current_user
  helper_method :latest_picks
  helper_method :latest_ordered
  helper_method :latest_length
  helper_method :this_weeks_charts
  helper_method :pickchart_id_array

  def cookie_rerun
      render :partial => "admin/cookie"
  end

  def create
    @archive_week = params[:pickchart]
    p @archive_week.values[0]
    @archive_week = @archive_week.values[0]

    respond_to do |format|
      format.html { redirect_to "/admin/charts/new" }
      format.js # render charts/create.js.erb
    end

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

  def destroy
    Pickchart.find(params[:pickchart][:id]).destroy

    @current_user = User.find(session[:user_id])
    if @current_user.admin == false or @current_user.admin == nil
        redirect_to "/users"
    end
    redirect_to "/admin/charts/new"
  end

  def index
    current_user

    if cookies[:wk] === nil
      cookies[:wk] = Pickchart.where($created_after, $timestamp).maximum(:week) # aka @latest
      if Pickchart.where($created_after, $timestamp).maximum(:week).nil?
        cookies[:wk] = 1
      end
    end

    @latest = cookies[:wk]
    #@latest = Pickchart.maximum(:week)
    p "the @latest line 62"
    p @latest
    # below is code that lists the first unfiltered pickchart
    #@testing = Pickchart.where($created_after, $timestamp).first.created_at

    latest_picks(@latest)

    @user = User.all
    @picks = Pick.all
    @pickchart = Pickchart.new
    @pickcharts = Pickchart.where($created_after, $timestamp).all

    @earliest = Pickchart.where($created_after, $timestamp).minimum(:week)

    if @current_user.admin == nil or @current_user.admin == false
        redirect_to "/users"
    end
  end

  def latest_picks(latest)
    # if there is a cookie week value then
    # @ latest is cookies[:wk]
    # else
    #@latest = Pickchart.maximum(:week)
    @latest_charttees = Pickchart.where($created_after, $timestamp).where(week: latest)
    #p "latest charttees"
    #p @latest_charttees[0]
    if @latest_charttees[0].nil?
      @latest_ordered = []
      return @latest_ordered
    else
      @latest_charts = @latest_charttees.order('id')
      p "ADMIN CONTROLLER - LATEST_PICKS - @latest_charts"
      p @latest_charts

      @latest_pc_wk_created_at = @latest_charts.first.created_at
      p @latest_pc_wk_created_at

      @range = @latest_pc_wk_created_at .. Time.now
      @latest_picks = Pick.where(created_at: @range).all
      @latest_picks_array = @latest_picks.pluck(:user_id).uniq

      @latest_ordered = @latest_picks_array.sort_by{:pickchart_id}
      #this helper actually spits out a users array in chron order
      # of who made first picks first
    end

  end

  def this_weeks_charts(cookie)
    @this_weeks_charts = Pickchart.where($created_after, $timestamp).where(week: cookie)
    @this_weeks_charts_ordered = @this_weeks_charts.order('id')

    p "THIS WEEKS CHARTS ORDERED"
    p @this_weeks_charts_ordered
    return @this_weeks_charts_ordered
  end

  def latest_ordered
    latest_picks(cookies[:wk])
  end

  def latest_length
    return latest_ordered.length
  end

  def new
    @user = User.new
    @current_user = User.find(session[:user_id])
    if @current_user.admin == false
        redirect_to "/users"
    end
    @pickchart = Pickchart.new
    @pickcharts = Pickchart.where($created_after, $timestamp).all
    @latest = Pickchart.where($created_after, $timestamp).maximum(:week)
    @latest_charts = Pickchart.where($created_after, $timestamp).where(week: @latest)
  end

  def show
    current_user
    @current_user = User.find(session[:user_id])
    if @current_user.admin == false or @current_user.admin == nil
        redirect_to "/users"
    end
  end

  def standing
  end

  def update
    current_user
    p "ADMIN CONTROLLER UPDATE XXXXXXXXX"

    @current_user = User.find(session[:user_id])
    if @current_user.admin == false or @current_user.admin == nil
        redirect_to "/users"
    end
  end

  def updating_password
    p "XXXXXX Updating the password, Lad XXXXX"
  end

  def wins
  end

  #private

  #def user_params
  #  params.require(:user).permit(:admin,:user_name,:email,:password,:password_digest)
  #end
end
