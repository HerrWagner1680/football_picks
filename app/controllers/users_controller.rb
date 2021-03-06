class UsersController < ApplicationController

  # GLOBAL $TIMESTAMP VARIABLES IN admin_helper.rb
  helper_method :current_user
  helper_method :latest_picks

  def current_user
    if session[:user_id]
      @current_user = User.find(session[:user_id])
    else
      @current_user = nil
    end
  end

  def index
    current_user

    if cookies[:wk] === nil
      cookies[:wk] = Pickchart.where($created_after, $timestamp).maximum(:week) # aka @latest
    end

    @latest = Pickchart.where($created_after, $timestamp).maximum(:week)
    latest_picks(@latest)

    #@current_user = User.find(session[:user_id])
    @something = $whatzittt
    #@user = User.new
    if @current_user.admin == true
        redirect_to "/admin"
    end
    #current_user

    #UPDATED UP TO HERE
    #     @user = User.all
    # @picks = Pick.all
    # @pickchart = Pickchart.new
    # @pickcharts = Pickchart.all

    # @earliest = Pickchart.minimum(:week)

    # if @current_user.admin == nil or @current_user.admin == false
    #     redirect_to "/users"
    # end


    @user = User.all
    @picks = Pick.all
    @pickchart = Pickchart.new
    @pickcharts = Pickchart.where($created_after, $timestamp).all
    @latest = Pickchart.where($created_after, $timestamp).maximum(:week)
    @latest_charttees = Pickchart.where($created_after, $timestamp).where(week: @latest)
    @latest_chart = @latest_charttees.order('id')
    @latest_charts = @latest_chart.where(winner: nil)
    @latest_charts_over = @latest_chart.where.not(winner: nil)

    @earliest = Pickchart.where($created_after, $timestamp).minimum(:week)

    @pc_time = Pickchart.where($created_after, $timestamp).where(week: @latest).first.created_at
    @range = @pc_time .. Time.now
    @any_picks = Pick.where(user_id: current_user.id, created_at: @range).exists?

  end

  def create
    @user = User.new(user_params)
   # @pick.user_id = current_user.id
   p "user admin below XXXXXXXXX"
   p @user.admin
   p params[:admin]

    if @user.valid? == false
      p "user errors are as follows..."
      p @user.errors.full_messages
      user_record_invalid
      return
    end

    if @user.save!
      flash[:notice] = "User Created"
    else
      flash[:alert] = @user.errors.full_messages
    end
    redirect_to "/users"
  end

  def latest_picks(latest)
    # Getting week = latest and put it in order by id
    @latest_charttees = Pickchart.where($created_after, $timestamp).where(week: latest)
    @latest_charts = @latest_charttees.order('id')

    @latest_pc_wk_created_at = @latest_charts.first.created_at
    @range = @latest_pc_wk_created_at .. Time.now
    @latest_picks = Pick.where(created_at: @range).all
    @latest_picks_array = @latest_picks.pluck(:user_id).uniq

    @latest_ordered = @latest_picks_array.sort_by{:pickchart_id}
    #this helper actually spits out a users array in chron order
    # of who made first picks first

    #line 92 added on June 16 after getting undefined error
    @latest_chart = @latest_charttees.order('id')
    #adding this item below
    @latest_charts_over = @latest_chart.where.not(winner: nil)
  end

  def new
    @user = User.new
  end

  def edit
    @pick = Pick.find(params[:id])
  end

  def show
    @pick = Pick.find(params[:id])
    @current_user = User.find(session[:user_id])
  end

  def update
    @pick = Pick.find(params[:id])
    if @pick.update(params[:post])
      flash[:notice] = "Post updated"
    else
      flash[:alert] = "Error Updating Post"
    end
    redirect_to "/users"
  end

  def destroy
    @pick = Pick.find(params[:id])
    if @pick.destroy
      flash[:notice] = "Post was thrown out"
    else
      flash[:alert] = "Post was not destroyed"
    end
    redirect_to "/users"
  end

  private

    def user_params
      params.require(:user).permit(:admin,:user_name,:email,:password,:password_digest)
    end

    def user_record_invalid
      p "you are running user_record_invalid"
      flash[:alert] = "User Name or Email already taken."
      redirect_to "/admin/new"
    end

end
