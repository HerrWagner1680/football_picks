module AdminHelper

	def mark_h_winner(id)
		# winner is nil home or visit
		@team = Pickchart.find(id).hteam
		@win_col = Pickchart.find(id).winner
		@team = @team.first(23)
		if @win_col === "home"
			@team << " *"
		end
		@team
	end

	def mark_v_winner(id)
		@team = Pickchart.find(id).vteam
		@win_col = Pickchart.find(id).winner
		@team = @team.first(23)
		if @win_col === "visit"
			@team << " *"
		end
		@team
	end

end
