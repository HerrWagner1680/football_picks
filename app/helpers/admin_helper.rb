module AdminHelper

	def mark_h_winner(id)
		# winner is nil home or visit
		@team = Pickchart.find(id).hteam
		@win_col = Pickchart.find(id).winner
		@team = @team.first(23)
		if @win_col === "home"
			@team << " +"
		elsif @win_col === "visitor" || @win_col === "visit"
			@team << " -"
		end
		@team
	end

	def mark_v_winner(id)
		@team = Pickchart.find(id).vteam
		@win_col = Pickchart.find(id).winner
		@team = @team.first(23)
		if @win_col === "visitor" || @win_col === "visit"
			@team << " +"
		elsif @win_col === "home"
			@team << " -"
		end
		@team
	end

	def mark_v_pick(pc_id, user)
		@pc_v = Pickchart.find(pc_id).vteam
		if Pick.where(pickchart_id: pc_id, user_id: user).last
			@pick = Pick.where(pickchart_id: pc_id, user_id: user).last.user_pick
				if @pick === "visitor" || @pick === "visit"
					@pc_v << " *"
				end
			@pc_v
		else
			@pc_v
		end
	end

	def mark_h_pick(pc_id, user)
		@pc_h = Pickchart.find(pc_id).hteam
		if Pick.where(pickchart_id: pc_id, user_id: user).last
			@pick = Pick.where(pickchart_id: pc_id, user_id: user).last.user_pick
				if @pick === "home"
					@pc_h << " *"
				end
			@pc_h
		else
			@pc_h
		end
	end

end
