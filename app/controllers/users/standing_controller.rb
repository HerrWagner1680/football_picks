class Users::StandingController < ApplicationController

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
    # @standing_users.pop(1)
    # commented out pop(1) since it was removing last added player!

    @current_user = User.find(session[:user_id])
  end

  def show
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

    @current_user = User.find(session[:user_id])
  end

end