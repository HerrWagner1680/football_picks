class AdminController < ApplicationController


  protect_from_forgery with: :exception

  helper_method :current_user
  helper_method :latest_picks
  helper_method :latest_text

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
    #@pickcharts = Pickchart.all
    #@latest = Pickchart.maximum(:week)
    #@latest_charts = Pickchart.where(week: @latest)


    @current_user = User.find(session[:user_id])
    if @current_user.admin == false or @current_user.admin == nil
        redirect_to "/users"
    end
    redirect_to "/admin/charts/new"
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
    @latest_charttees = Pickchart.where(week: @latest)
    @latest_charts = @latest_charttees.order('id')
    @earliest = Pickchart.minimum(:week)
    latest_picks
    latest_text
  end

  def latest_picks
    @latest_pc_wk_created_at = @latest_charts.first.created_at
    @range = @latest_pc_wk_created_at .. Time.now
    @latest_picks = Pick.where(created_at: @range).all
    @latest_picks_array = @latest_picks.pluck(:user_id).uniq
    @latest_ordered = @latest_picks_array.sort_by{:pickchart_id}
    #@latest_ordered = @latest_ordered.reverse if sort_direction == 'DESC'
  end

  def latest_text
    if @latest = 18
      @latest_text = "18 - Wild Card 1"
    elsif @latest = 19
      @latest_text = "19 - Wild Card 2"
    elsif @latest = 20
      @latest_text = "20 - Championship"
    else
      @latest_text = @latest
    end
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
    #@user = User.all

  end

  def show
    current_user
    latest_text
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
