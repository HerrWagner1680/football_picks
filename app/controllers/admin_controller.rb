class AdminController < ApplicationController

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
    #@latest = Pickchart.maximum(:week) #this changed by cookie
    current_user

    if cookies[:wk] === nil
      cookies[:wk] = Pickchart.maximum(:week) # aka @latest
    end
    #@latest = cookies[:wk]
    @latest = Pickchart.maximum(:week)
    latest_picks(@latest)

    @user = User.all
    @picks = Pick.all
    @pickchart = Pickchart.new
    @pickcharts = Pickchart.all

    @earliest = Pickchart.minimum(:week)

    if @current_user.admin == nil or @current_user.admin == false
        redirect_to "/users"
    end
  end

  def latest_picks(latest)
    # if there is a cookie week value then
    # @ latest is cookies[:wk]
    # else
    #@latest = Pickchart.maximum(:week)
    @latest_charttees = Pickchart.where(week: latest)
    @latest_charts = @latest_charttees.order('id')

    @latest_pc_wk_created_at = @latest_charts.first.created_at
    @range = @latest_pc_wk_created_at .. Time.now
    @latest_picks = Pick.where(created_at: @range).all
    @latest_picks_array = @latest_picks.pluck(:user_id).uniq

    @latest_ordered = @latest_picks_array.sort_by{:pickchart_id}
    #this helper actually spits out a users array in chron order
    # of who made first picks first
  end

 #latest_picks(latest) is completely wrong
 # want Pickchart.where(week: cookies[:id])
 # order it by id  by Pickchart ID that is

 # IS THERE A REASON TO PUT IT IN TIME ORDER???
 # most likely have to create a new array with a loop
 # loop through the pickchart ids

  def this_weeks_charts(cookie)
    @this_weeks_charts = Pickchart.where(week: cookie)
    @this_weeks_charts_ordered = @this_weeks_charts.order('id')
   
    p "THIS WEEKS CHARTS ORDERED"
    p @this_weeks_charts_ordered
    return @this_weeks_charts_ordered
  end

  # def pickchart_id_array
  #   pc_array = []
  #   p"************"
  #   p this_weeks_charts(cookies[:id])
  #   this_weeks_charts(cookies[:id]).length.times do |i|
  #     pc_array = pc_array << i.id
  #   end
  #   return pc_array
  # end


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
