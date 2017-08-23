class Admin::StandingController < ApplicationController

    helper_method :current_user

    def current_user
      if session[:user_id]
        @current_user = User.find(session[:user_id])
      else
        @current_user = nil
      end
    end

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
    @pickcharts = Pickchart.where($created_after, $timestamp).all
    @latest = Pickchart.where($created_after, $timestamp).maximum(:week)
    #latest_text
    @latest_charttees = Pickchart.where($created_after, $timestamp).where(week: @latest)
    @latest_charts = @latest_charttees.order('id')
    @earliest = Pickchart.where($created_after, $timestamp).minimum(:week)

    @standings = Standing.where($created_after, $timestamp).order('week').all
    @standings = @standings.order('user_id')
    @standing_users = @standings.pluck(:user_id).uniq
    #the leftmost player is FIRSTLY earliest week number in STANDING
    #  and secondly, the lowest user id.
    #ANY PLAYER WITHOUT STANDINGS IS NOT LISTED

    #  if you wish to add a user to run test on live site:
    #@standing_users.shift(0)
    #shift removes the first listed player (which you can use as admin)
    #@standing_users.pop(0)
    #pop removes the last listed player

    @current_user = User.find(session[:user_id])
    if @current_user.admin == false or @current_user.admin == nil
        redirect_to "/users"
    end
  end

  def new
  end

  def show
    current_user
    p "SHOWSHOWSHOWSHOWSHOWSHOW"
    p params[:id]
    if Standing.where(week: 24).exists? == false or Standing.where(week: 24).exists? == nil
      redirect_to "/admin/standing"
    end
    if params[:id] == "2016"
      p "YES YOU ARE CORRECT SIR!"
    else
      redirect_to "/admin/standing"
    end
    @current_user = User.find(session[:user_id])
    if @current_user.admin == false or @current_user.admin == nil
        redirect_to "/admin"
    end
    @standings = Standing.where(week: 24).all

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
