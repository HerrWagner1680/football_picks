class Users::StandingController < ApplicationController

  helper_method :current_user

  def current_user
    if session[:user_id]
      @current_user = User.find(session[:user_id])
    else
      @current_user = nil
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
    # @standing_users.pop(1)
    # commented out pop(1) since it was removing last added player!

    @current_user = User.find(session[:user_id])
  end

  def show
  	current_user
    #@user = User.all
    #@picks = Pick.all
    #@pickchart = Pickchart.new
    #@pickcharts = Pickchart.where($created_after, $timestamp).all
    #@latest = Pickchart.where($created_after, $timestamp).maximum(:week)
    #latest_text
    #@latest_charttees = Pickchart.where($created_after, $timestamp).where(week: @latest)
    #@latest_charts = @latest_charttees.order('id')
    #@earliest = Pickchart.where($created_after, $timestamp).minimum(:week)

    if Standing.where(week: 24).exists? == false or Standing.where(week: 24).exists? == nil
      redirect_to "/users/standing"
    end

    @current_user = User.find(session[:user_id])

    p "SHOWSHOWSHOWSHOWSHOWSHOW"
    p params[:id]
    if params[:id] == "2016"
      p "YES YOU ARE CORRECT SIR!"
    else
      redirect_to "/users/standing"
    end

    @standings = Standing.where(week: 24).all

  end

end
