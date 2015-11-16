class Admin::ChartController < ApplicationController

  def create
    @pickchart = Pickchart.new(pickchart_params)
    if @pickchart.save
      flash[:notice] = "Chart Created"
    else 
      flash[:alert] = @pickchart.errors.full_messages
    end

    redirect_to "/admin/chart"
  end

  def new
    @pickchart = Pickchart.new
    @pick = Pick.new
  end

  def destroy
  end

  def index
    current_user
    @user = User.all
    @picks = Pick.all
    @pickchart = Pickchart.new
    @pickcharts = Pickchart.all
    @latest = Pickchart.maximum(:week)
    @latest_charts = Pickchart.where(week: @latest)

    #if @latest_charts  #technically, this should check if last wk picks
     # render :js => "oldchartPicks()"
    #end
    # create helper method for week number filter
    # use require helper_method to invoke
  end

  def show
    current_user
  end

  private

  def pick_params
    params.require(:pick).permit(:pickchart_id,:user_pick,:user_id)
  end

  def pickchart_params
    params.require(:pickchart).permit(:week,:vteam,:vt_rec,:hteam,:ht_rec,:gametime)
  end
end
