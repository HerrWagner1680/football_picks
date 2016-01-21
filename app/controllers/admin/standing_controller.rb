class Admin::StandingController < ApplicationController

  def create
    @number_of_wins = params[:picks][0].length
    @win_values = params[:picks][0].values
    @win_keys = params[:picks][0].keys
    p "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
    p params[:picks]
    p params[:picks][0]
    p params[:standing]
    @number_of_wins.times do |i|
 #       @standing = Standing.new(user_id: current_user.id, pickchart_id: @pick_keys[i], user_pick: @pick_values[i])
    @standing = Standing.new
          if @standing.save! 
            flash[:notice] = "Standing Created"
          else
            flash[:alert] = @standing.errors.full_messages   
          end
    end
    @current_user = User.find(session[:user_id])
    if @current_user.admin == true
        redirect_to "/admin"
    else
        redirect_to "/users"
    end
  end

  def index
    current_user
    @user = User.all
    @picks = Pick.all
    @pickchart = Pickchart.new
    @pickcharts = Pickchart.all
    @latest = Pickchart.maximum(:week)
    #latest_text
    @latest_charttees = Pickchart.where(week: @latest)
    @latest_charts = @latest_charttees.order('id')
    @earliest = Pickchart.minimum(:week)

    @standings = Standing.order('week').all
    @standings = @standings.order('user_id')
    @standing_users = @standings.pluck(:user_id).uniq
    #@standing_users.pop(1)

    @current_user = User.find(session[:user_id])
    if @current_user.admin == false or @current_user.admin == nil
        redirect_to "/users"
    end
  end

  def new
  end

  def show
  end

  def update
  end

  private

  def pick_params
    params.require(:pick).permit(:id,:pickchart_id,:user_pick,:user_id)
  end

  def pickchart_params
    params.require(:pickchart).permit(:id,:week,:vteam,:vt_rec,:hteam,:ht_rec,:gametime)
  end
end
