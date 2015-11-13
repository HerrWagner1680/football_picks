class Admin::ChartController < ApplicationController

  def create
    @pickchart = Pickchart.new(pickchart_params)
    if @pickchart.save!
      flash[:notice] = "Chart Created"
    else
      flash[:alert] = @pickchart.errors.full_messages
    end
    redirect_to "/admin/chart"
  end

  def current_user
    if session[:user_id]
      @current_user = User.find(session[:user_id])
    else
      @current_user = nil
    end
  end

  def new
    @pickchart = Pickchart.new
  end

  def destroy
  end

    def pickchart_path
      redirect_to "/admin/chart"
    end

  def index
    current_user
    @user = User.all
    @picks = Pick.all
    @pickchart = Pickchart.new
    @pickcharts = Pickchart.where(week: '8')
  end

  def show
    current_user
  end

  private

  def pickchart_params
    params.require(:pickchart).permit(:week,:vteam,:vt_rec,:hteam,:ht_rec,:gametime)
  end
end
