class PicksController < ApplicationController
  def index
  	@picks = Pick.all
  	@pick = Pick.new
  end

  def new
  	@pick = Pick.new
  end

  def create
  	@pick = Pick.new(pick_params)
  	#puts (params)
  	#puts (params["pick"][:week])
  	p "******SEEE ABOVE!!!!"
   # @pick.user_id = current_user.id
    if @pick.save!
      flash[:notice] = "Pick Created"
    else
      flash[:alert] = @pick.errors.full_messages
    end
   redirect_to "/picks"
  end

  private

  def pick_params
    params.require(:pick).permit(:week, :position, :team, :player)
  end

end
