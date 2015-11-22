class PicksController < ApplicationController
  def index
  	@picks = Pick.all
  	@pick = Pick.new
  end

  def new
  	@pick = Pick.new
  end

  def create
    @number_of_picks = params[:picks][0].length
    @pick_values = params[:picks][0].values
    @pick_keys = params[:picks][0].keys
    p "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
    @number_of_picks.times do |i|
        @pick = Pick.new(user_id: current_user.id, pickchart_id: @pick_keys[i], user_pick: @pick_values[i])
          if @pick.save! 
            flash[:notice] = "Pick Created"
          else
            flash[:alert] = @pick.errors.full_messages   
          end
    end
    @current_user = User.find(session[:user_id])
    if @current_user.admin == true
        redirect_to "/admin"
    else
        redirect_to "/users"
    end
  end

  private

  def pick_params
    params.require(:pick).permit(:pickchart_id,:user_pick,:user_id)
  end

end
