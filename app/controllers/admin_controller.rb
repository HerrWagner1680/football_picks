class AdminController < ApplicationController

  protect_from_forgery with: :exception

  helper_method :current_user
  helper_method :latest_picks

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
    latest_picks
    current_user

    @user = User.all
    @picks = Pick.all
    @pickchart = Pickchart.new
    @pickcharts = Pickchart.all

    @latest = Pickchart.maximum(:week)
    @latest_charttees = Pickchart.where(week: @latest)
    @latest_charts = @latest_charttees.order('id')

    @earliest = Pickchart.minimum(:week)

    if @current_user.admin == nil or @current_user.admin == false
        redirect_to "/users"
    end
  end

  def latest_picks
    @latest = Pickchart.maximum(:week)
    @latest_charttees = Pickchart.where(week: @latest)
    @latest_chart = @latest_charttees.order('id')
    @latest_charts = @latest_chart.where(winner: nil)
    @latest_pc_wk_created_at = @latest_charts.first.created_at

    @range = @latest_pc_wk_created_at .. Time.now
    # @latest_picks are all of the picks for the current week
    @latest_picks = Pick.where(created_at: @range).all
    @latest_picks_array = @latest_picks.pluck(:user_id).uniq
    #@latest_picks_array.pop(1) # intended to drop nil
    @latest_ordered = @latest_picks_array.sort_by{:pickchart_id}
    #@latest_ordered = @latest_ordered.reverse if sort_direction == 'DESC'
  end

  def new
    @user = User.new
    @current_user = User.find(session[:user_id])
    if @current_user.admin == false
        redirect_to "/users"
    end
    @pickchart = Pickchart.new
    @pickcharts = Pickchart.all
    @latest = Pickchart.maximum(:week)
    @latest_charts = Pickchart.where(week: @latest)
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

  def wins
  end

  #private

  #def user_params
  #  params.require(:user).permit(:admin,:user_name,:email,:password,:password_digest)
  #end
end
