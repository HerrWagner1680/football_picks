class Admin::ChartsController < ApplicationController
  #respond_to :json
  helper_method :latest_picks
  #helper_method :latest_text
  #helper_method :update_standings
  helper_method :current_user

  def current_user
    if session[:user_id]
      @current_user = User.find(session[:user_id])
    else
      @current_user = nil
    end
  end

  def create
    p 'charts create zzzzzzzzzzzz'
    p pickchart_params
    @latest = Pickchart.where($created_after, $timestamp).maximum(:week)

    @params = pickchart_params
    @pickchart = Pickchart.new(pickchart_params)
    if @pickchart.save
      @pc = Pickchart.where(:id => params[:id])
      redirect_to "/admin/charts/new#new_pc"
    else
      flash[:alert] = @pickchart.errors.full_messages
    end


    @current_user = User.find(session[:user_id])
    if @current_user.admin == false or @current_user.admin == nil
        redirect_to "/users"
    end

    #redirect_to "/admin/charts/new"
  end

  def latest_picks(latest)
    # if there is a cookie week value then
    # @ latest is cookies[:wk]
    # else
    #@latest = Pickchart.maximum(:week)
    @latest_charttees = Pickchart.where($created_after, $timestamp).where(week: latest)
    @latest_chart = @latest_charttees.order('id')
    #PREV  @latest_charts = @latest_charttees.order('id')
    @latest_charts = @latest_chart.where(winner: nil)
    @latest_charts_over = @latest_chart.where.not(winner: nil)
    #THIS RETURNS PICKHART ARRAY -- a little diff from similarly named helpers
    #in other controllers
  end

#http://stackoverflow.com/questions/25582878/angularjs-post-data-to-rails-server-by-service
  def new
    p 'charts new'
    #respond_with(Pickchart.all)

    @pickchart = Pickchart.new
    @pick = Pick.new

    @pickcharts = Pickchart.where($created_after, $timestamp).all
    @latest = Pickchart.where($created_after, $timestamp).maximum(:week)
    latest_picks(@latest)

    @current_user = User.find(session[:user_id])
    if @current_user.admin == false or @current_user.admin == nil
        redirect_to "/users"
    end
  end

  def destroy
    @pc = Pickchart.find(params[:id])

    if @pc.destroy
      # the 'latest' cookie must be reset
      cookies[:wk] = Pickchart.where($created_after, $timestamp).maximum(:week) # aka @latest
      respond_to do |format|
        format.html { redirect_to "/admin/charts/new" }
        format.js { render "destroy.js.erb", :locals => {:id => @pc.id} }# render charts/create.js.erb
      end
    else
      flash[:alert] = @pc.errors.full_messages
    end

    @current_user = User.find(session[:user_id])
    if @current_user.admin == false or @current_user.admin == nil
        redirect_to "/users"
    end
    #redirect_to "/admin/charts/new"
  end

#http://stackoverflow.com/questions/25582878/angularjs-post-data-to-rails-server-by-service
  def index
    p 'charts index'
    #respond_with(Pickchart.all)
    current_user
    @user = User.all
    @picks = Pick.all
    @pickchart = Pickchart.new
    @pickcharts = Pickchart.where($created_after, $timestamp).all
    @latest = Pickchart.where($created_after, $timestamp).maximum(:week)
    #latest_text
    @latest_charttees = Pickchart.where($created_after, $timestamp).where(week: @latest)
    @latest_charts = @latest_charttees.order('id')

    @earliest = Pickchart.where($created_after, $timestamp).minimum(:week)

    @current_user = User.find(session[:user_id])
    if @current_user.admin == false or @current_user.admin == nil
        redirect_to "/users"
    end
  end

  def show
    current_user

    if cookies[:wk] === nil
      cookies[:wk] = Pickchart.where($created_after, $timestamp).maximum(:week) # aka @latest
    end

    # @latest = Pickchart.maximum(:week)
    # latest_picks(@latest)
    # # p 'charts show'
    # # current_user

    @current_user = User.find(session[:user_id])
    if @current_user.admin == false or @current_user.admin == nil
        redirect_to "/users"
    end

    @user = User.all
    @picks = Pick.all
    @pickchart = Pickchart.new
    @pickcharts = Pickchart.where($created_after, $timestamp).all
    @latest = Pickchart.where($created_after, $timestamp).maximum(:week)
    #latest_text
    latest_picks(@latest)

    @latest_pc_wk_created_at = @latest_chart.first.created_at
    #PREV  @latest_pc_wk_created_at = @latest_charts.first.created_at
    @range = @latest_pc_wk_created_at .. Time.now
    @latest_picks = Pick.where(created_at: @range).all
    @latest_picks_array = @latest_picks.pluck(:user_id).uniq

    @latest_ordered = @latest_picks_array.sort_by{:pickchart_id}

  end

  def standing
  end

  def update
    @pc = Pickchart.where(:id => params[:id])

      @pickchart = Pickchart.find(pickchart_params[:id])
      if @pickchart.update(pickchart_params)
        respond_to do |format|
          format.js { render "update.js.erb", :locals => {:pickchart => @pc } }
        end
        #flash[:notice] = "Game listing updated"
        #redirect_to "/admin/charts/new"
      else
        flash[:alert] = @pickchart.errors.full_messages
        redirect_to "/admin/charts/new"
      end
  end

  def wins
  end

  private

  def pick_params
    params.require(:pick).permit(:id,:pickchart_id,:user_pick,:user_id)
  end

  def pickchart_params
    params.require(:pickchart).permit(:id,:week,:vteam,:vt_rec,:hteam,:ht_rec,:gametime)
  end
end

# originally in create         # format.js { render "create.js.erb", :locals => {:id => params[Pickchart], :pickchart => pickchart_params} }# render charts/create.js.erb
   #originally in create           #format.html { render "create.html.erb" , :locals => {:pickchart => @pc } }
