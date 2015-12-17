class Admin::ChartsController < ApplicationController
  #respond_to :json
  helper_method :latest_text

  def create
    p 'charts create'
    @latest = Pickchart.maximum(:week)
    latest_text
    @pickchart = Pickchart.new(pickchart_params)
    if @pickchart.save
      respond_to do |format|
        format.html { redirect_to "/admin/charts/new" }
        format.js { render "create.js.erb", :locals => {:id => params[Pickchart]} }# render charts/create.js.erb
      end
    else 
      flash[:alert] = @pickchart.errors.full_messages    
    end

    # if @pickchart.save
    #   flash[:notice] = "Chart Created"
    # else 
    #   flash[:alert] = @pickchart.errors.full_messages
    # end
    @current_user = User.find(session[:user_id])
    if @current_user.admin == false or @current_user.admin == nil
        redirect_to "/users"
    end

    #redirect_to "/admin/charts/new"
  end

#http://stackoverflow.com/questions/25582878/angularjs-post-data-to-rails-server-by-service
  def new
    p 'charts new'
    #respond_with(Pickchart.all)
    @pickchart = Pickchart.new
    @pick = Pick.new

    # respond_to do |format|
    #   if @pickchart.save
    #     format.html { redirect_to "/admin/charts/new/"}
    #     format.js {}
    #     format.json { render json: @pickchart, status: :created, location: @pickchart}
    #   end
    # end

    @current_user = User.find(session[:user_id])
    if @current_user.admin == false or @current_user.admin == nil
        redirect_to "/users"
    end

    @pickcharts = Pickchart.all
    @latest = Pickchart.maximum(:week)
    @latest_charttees = Pickchart.where(week: @latest)
    @latest_charts = @latest_charttees.order('id')
    latest_text
  end

  def destroy
    @pc = Pickchart.find(params[:id])
    @pc.destroy
    #@pickcharts = Pickchart.all
    #@latest = Pickchart.maximum(:week)
    #@latest_charts = Pickchart.where(week: @latest)

    @current_user = User.find(session[:user_id])
    if @current_user.admin == false or @current_user.admin == nil
        redirect_to "/users"
    end
    redirect_to "/admin/charts/new"
  end

#http://stackoverflow.com/questions/25582878/angularjs-post-data-to-rails-server-by-service
  def index
    p 'charts index'
    #respond_with(Pickchart.all)
    current_user
    @user = User.all
    @picks = Pick.all
    @pickchart = Pickchart.new
    @pickcharts = Pickchart.all
    @latest = Pickchart.maximum(:week)
    latest_text
    @latest_charttees = Pickchart.where(week: @latest)
    @latest_charts = @latest_charttees.order('id')
    @earliest = Pickchart.minimum(:week)

    @current_user = User.find(session[:user_id])
    if @current_user.admin == false or @current_user.admin == nil
        redirect_to "/users"
    end
    #if @latest_charts  #technically, this should check if last wk picks
     # render :js => "oldchartPicks()"
    #end
    # create helper method for week number filter
    # use require helper_method to invoke
  end

  def latest_text
    if @latest == 18
      @latest_text == "18 - Wild Card 1"
    elsif @latest == 19
      @latest_text == "19 - Wild Card 2"
    elsif @latest == 20
      @latest_text == "20 - Championship"
    else
      @latest_text == @latest
    end
  end

  def show
    p 'charts show'
    current_user
    @current_user = User.find(session[:user_id])
    if @current_user.admin == false or @current_user.admin == nil
        redirect_to "/users"
    end

    @user = User.all
    @picks = Pick.all
    @pickchart = Pickchart.new
    @pickcharts = Pickchart.all
    @latest = Pickchart.maximum(:week)
    #latest_text
    @latest_charttees = Pickchart.where(week: @latest)
    @latest_charts = @latest_charttees.order('id')
    @earliest = Pickchart.minimum(:week)
  end

  def update
    p 'charts update'
    @pickchart = Pickchart.find(params[:pickchart][:id])
    @latest = Pickchart.maximum(:week)
    latest_text
    if @pickchart.update(pickchart_params)
      flash[:notice] = "Game listing updated"
      redirect_to "/admin/charts/new"
    else
      flash[:alert] = @pickchart.errors.full_messages
      redirect_to "/admin/charts/new"
    end
  end

  private

  def pick_params
    params.require(:pick).permit(:id,:pickchart_id,:user_pick,:user_id)
  end

  def pickchart_params
    params.require(:pickchart).permit(:id,:week,:vteam,:vt_rec,:hteam,:ht_rec,:gametime)
  end
end
