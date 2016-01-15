class Admin::ChartsController < ApplicationController
  #respond_to :json
  helper_method :latest_picks
  #helper_method :latest_text
  #helper_method :update_standings

  def create
    p 'charts create zzzzzzzzzzzz'
    p pickchart_params
    @latest = Pickchart.maximum(:week)

    @params = pickchart_params
    @pickchart = Pickchart.new(pickchart_params)
    if @pickchart.save
      @pc = Pickchart.where(:id => params[:id])
      redirect_to "/admin/charts/new#new_pc"
          # @pickchart = Pickchart.new
          # @latest = Pickchart.maximum(:week)
          # @latest_charttees = Pickchart.where(week: @latest)
          # @latest_chart = @latest_charttees.order('id')
          # @latest_charts = @latest_chart.where(winner: nil)
     # respond_to do |format|
          #format.js { render "update.js.erb", :locals => {:pickchart => @pc } }
       #   format.html { render "/admin/charts/new" }
       #   format.js { render "/admin/charts/create.js", :locals=> {:pickchart => @pickchart, :pickcharts => @latest_charts}}
      #end
    else 
      flash[:alert] = @pickchart.errors.full_messages    
    end
 

    @current_user = User.find(session[:user_id])
    if @current_user.admin == false or @current_user.admin == nil
        redirect_to "/users"
    end

    #redirect_to "/admin/charts/new"
  end

  def latest_picks
    @latest_pc_wk_created_at = @latest_charts.first.created_at
    @range = @latest_pc_wk_created_at .. Time.now
    @latest_picks = Pick.where(created_at: @range).all
    @latest_picks_array = @latest_picks.pluck(:user_id).uniq
    @latest_picks_array.pop(1)
    @latest_ordered = @latest_picks_array.sort_by{:pickchart_id}
    #@latest_ordered = @latest_ordered.reverse if sort_direction == 'DESC'
  end

#http://stackoverflow.com/questions/25582878/angularjs-post-data-to-rails-server-by-service
  def new
    p 'charts new'
    #respond_with(Pickchart.all)

    @pickchart = Pickchart.new
    @pick = Pick.new

    @pickcharts = Pickchart.all
    @latest = Pickchart.maximum(:week)
    @latest_charttees = Pickchart.where(week: @latest)
    @latest_chart = @latest_charttees.order('id')
    @latest_charts = @latest_chart.where(winner: nil)
    #latest_text

    @current_user = User.find(session[:user_id])
    if @current_user.admin == false or @current_user.admin == nil
        redirect_to "/users"
    end
  end

  def destroy
    @pc = Pickchart.find(params[:id])

    if @pc.destroy
      respond_to do |format|
        format.html { redirect_to "/admin/charts/new" }
        format.js { render "destroy.js.erb", :locals => {:id => @pc.id} }# render charts/create.js.erb
      end
    else 
      flash[:alert] = @pc.errors.full_messages    
    end
    #@pickcharts = Pickchart.all
    #@latest = Pickchart.maximum(:week)
    #@latest_charts = Pickchart.where(week: @latest)

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
    #if @latest_charts  #technically, this should check if last wk picks
     # render :js => "oldchartPicks()"
    #end
    # create helper method for week number filter
    # use require helper_method to invoke
  end

  # def latest_text
  #   if @latest == 18
  #     @latest_text == "18 - Wild Card 1"
  #   elsif @latest == 19
  #     @latest_text == "19 - Wild Card 2"
  #   elsif @latest == 20
  #     @latest_text == "20 - Championship"
  #   else
  #     @latest_text == @latest
  #   end
  # end

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
    @latest_chart = @latest_charttees.order('id')
    @latest_charts = @latest_chart.where(winner: nil)
    @latest_charts_over = @latest_chart.where.not(winner: nil)
    @earliest = Pickchart.minimum(:week)
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

  # def update_wins_and_standings
  #   @latest = Pickchart.maximum(:week)
  #   @latest_charttees = Pickchart.where(week: @latest)
  #   @latest_charts = @latest_charttees.order('id')
  #   #@pickcharts = Pickchart.all

  #   # Saving a win is actually updating a Pickchart
  #   p 'charts update'
  #   #p pickchart_params
  #   #p pickchart_params[:id]
  #   p "params"
  #   p params
  #   if params.present?
  #     @number_of_wins = params[:pickchart][0].length
  #     @win_values = params[:pickchart][0].values
  #     @win_keys = params[:pickchart][0].keys
  #     p "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"

  #     #make hash hash = {pickchart.id => pickchart.winner}
  #     @winner_hash = {}

  #     @number_of_wins.times do |i|
  #       #p @win_keys[i].to_i
  #       #p @win_values[i]
  #       @winner = @win_values[i]
  #       #p "WINNER below"
  #       #p @winner
  #       @param_id = @win_keys[i].to_i
  #       @win_id = Pickchart.find(@param_id)
  #       if @winner === "clear"
  #         Pickchart.update(@param_id, {winner: nil})
  #       else
  #         Pickchart.update(@param_id, {winner: @winner})
  #         @winner_hash[@param_id] = @winner
  #       end
  #     end
  #       p "WINNER HASH......"
  #       p @winner_hash
  #       #p @winner_hash.keys.length
  #       latest_picks
  #       #create or update Standings using helper
  #       update_standings(@winner_hash, @latest_picks_array)
  #     redirect_to "/admin/wins"
  #   else
  #     @pickchart = Pickchart.find(pickchart_params[:id])
  #     if @pickchart.update(pickchart_params)
  #       flash[:notice] = "Game listing updated"
  #       redirect_to "/admin/charts/new"
  #     else
  #       flash[:alert] = @pickchart.errors.full_messages
  #       redirect_to "/admin/charts/new"
  #     end
  #   end
  # end

  # def update_standings(winner_hash, users_array)
  #   p "INSIDE CONTROLLER"
  #   p winner_hash
  #   p users_array
  #   # @wins_tot = 0
  #   # @loss_tot = 0
  #    num_users = users_array.length
  #    num_users.times do |i|
  #       @wins_tot = 0
  #       @loss_tot = 0
  #     #p "iterator i = #{i}"

  #     num_winners = winner_hash.keys.length
  #     #p num_winners
  #     #p winner_hash.keys
  #     #p winner_hash.values
  #     #p winner_hash[0]
  #     num_winners.times do |x|
  #        @user_pick = Pick.where(user_id: users_array[i], pickchart_id: winner_hash.keys[x])
  #        #p "@user_pick is #{@user_pick}"

  #        if @user_pick.last.nil?
  #           @loss_tot = @loss_tot + 1
  #        elsif @user_pick.last.user_pick === winner_hash.values[x]
  #           @wins_tot = @wins_tot + 1 
  #        else 
  #           @loss_tot = @loss_tot + 1
  #        end
  #     end
  #       @latest = Pickchart.maximum(:week)
  #       #p "wins and losses"
  #       #p @wins_tot
  #       #p @loss_tot

  #       Standing.where(user_id: users_array[i-1], week: @latest).first_or_create
  #       Standing.find_by(user_id: users_array[i-1], week: @latest).update(wins: @wins_tot, losses: @loss_tot)
  #    end
  # end

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
