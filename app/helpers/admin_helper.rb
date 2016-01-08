module AdminHelper

	def mark_h_winner(id)
		# winner is nil home or visit
		@team = Pickchart.find(id).hteam
		@win_col = Pickchart.find(id).winner
		if @win_col === "home"
			@team << " *"
		end
		p "winner below"
		p @win_col
		p "this is the team string, below"
		p @team
		@team
	end

	def mark_v_winner(id)
		@team = Pickchart.find(id).vteam
		@win_col = Pickchart.find(id).winner
		if @win_col === "visit"
			@team << " *"
		end
		p "winner below"
		p @win_col
		p "this is the team string, below"
		p @team
		@team
	end

end
