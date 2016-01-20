class Admin::WinsController < ApplicationController

  helper_method :latest_picks
  helper_method :update_standings

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

    @current_user = User.find(session[:user_id])
    if @current_user.admin == false or @current_user.admin == nil
        redirect_to "/users"
    end
  end

  def latest_picks
    @latest_pc_wk_created_at = @latest_charts.first.created_at
    @range = @latest_pc_wk_created_at .. Time.now
    @latest_picks = Pick.where(created_at: @range).all
    @latest_picks_array = @latest_picks.pluck(:user_id).uniq
    @latest_ordered = @latest_picks_array.sort_by{:pickchart_id}
    #@latest_ordered = @latest_ordered.reverse if sort_direction == 'DESC'
  end

  def update_wins_and_standings
    @latest = Pickchart.maximum(:week)
    @latest_charttees = Pickchart.where(week: @latest)
    @latest_charts = @latest_charttees.order('id')

    # Saving a win is actually updating a Pickchart
    p 'XXXXX WINS CONTROLLER XXXXXX'
    p "params"
    p params
    if params.present?
      @number_of_wins = params[:pickchart][0].keys.length
      @win_values = params[:pickchart][0].values
      @win_keys = params[:pickchart][0].keys
      p "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
      p @win_values
      p @win_values[0]

      @winner_hash = {}
      p @number_of_wins

      @number_of_wins.times do |i|
        @winner = @win_values[i]
        @param_id = @win_keys[i].to_i
        @win_id = Pickchart.find(@param_id)
        if @winner === "clear"
          Pickchart.update(@param_id, {winner: nil})
        elsif @winner === "visit" || @winner === "visitor"
          Pickchart.update(@param_id, {winner: "visit"})
          @winner_hash[@param_id] = "visit"
        else @winner === "home"
          Pickchart.update(@param_id, {winner: "home"})
          @winner_hash[@param_id] = "home"
        end
      end
        p "WINNER HASH......"
        p @winner_hash
        p 'XXXXX WINS CONTROLLER XXXXXX'
        # EVERYTHING GOOD SO FAR UP TO HERE
        latest_picks
        #create or update Standings using helper
        update_standings(@winner_hash, @latest_picks_array)
      redirect_to "/admin/wins"
    else
      @pickchart = Pickchart.find(pickchart_params[:id])
      if @pickchart.update(pickchart_params)
        flash[:notice] = "Game listing updated"
        redirect_to "/admin/charts/new"
      else
        flash[:alert] = @pickchart.errors.full_messages
        redirect_to "/admin/charts/new"
      end
    end
  end

  def update_standings(winner_hash, users_array)
    p "INSIDE CONTROLLER"
    p winner_hash
    p users_array
     num_users = users_array.length
     num_users.times do |i|
        @wins_tot = 0
        @loss_tot = 0

      num_winners = winner_hash.keys.length
      num_winners.times do |x|
         @user_pick = Pick.where(user_id: users_array[i], pickchart_id: winner_hash.keys[x])
         #p "@user_pick is #{@user_pick}"

         if @user_pick.last.nil?
            @loss_tot = @loss_tot + 1
         elsif @user_pick.last.user_pick === winner_hash.values[x]
            @wins_tot = @wins_tot + 1 
         else 
            @loss_tot = @loss_tot + 1
         end
      end
        @latest = Pickchart.maximum(:week)
        #p "wins and losses"
        #p @wins_tot
        #p @loss_tot

        Standing.where(user_id: users_array[i], week: @latest).first_or_create
        Standing.find_by(user_id: users_array[i], week: @latest).update(wins: @wins_tot, losses: @loss_tot)
     end
  end

  def show
  end

  private

  def pick_params
    params.require(:pick).permit(:id,:pickchart_id,:user_pick,:user_id)
  end

  def pickchart_params
    params.require(:pickchart).permit(:id,:week,:vteam,:vt_rec,:hteam,:ht_rec,:gametime)
  end
end
