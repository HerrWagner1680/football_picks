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

	def select_week_array
		week_names = [["Week 1", 1], ["Week 2", 2], ["Week 3", 3], ["Week 4", 4],
		 ["Week 5", 5], ["Week 6", 6], ["Week 7", 7], ["Week 8", 8], ["Week 9", 9], ["Week 10", 10], ["Week 11", 11], 
		 ["Week 12", 12], ["Week 13", 13], ["Week 14", 14], ["Week 15", 15], ["Week 16", 16], ["Week 17", 17], 
		 ["Wild Card 1", 18], ["Wild Card 2", 19], ["Championship", 20], ["Playoff", 21], ["Playoff", 22]]
		return week_names
	end

# you want an index of 0 in order to get the text
	def select_week(week_num, index)
		if week_num >= 22 
			week_num = 22
		end
		week_names = [["Week 0", 0], ["Week 1", 1], ["Week 2", 2], ["Week 3", 3], ["Week 4", 4],
		 ["Week 5", 5], ["Week 6", 6], ["Week 7", 7], ["Week 8", 8], ["Week 9", 9], ["Week 10", 10], ["Week 11", 11], 
		 ["Week 12", 12], ["Week 13", 13], ["Week 14", 14], ["Week 15", 15], ["Week 16", 16], ["Week 17", 17], 
		 ["Wild Card 1", 18], ["Wild Card 2", 19], ["Championship", 20], ["Playoff", 21], ["Playoff", 22], ["Playoff", 23]]	
		week_names[week_num][index]
	end

	def uniq_week_array
		@weeks_array = []
		@weeks_uniq = Pickchart.pluck(:week).uniq
		@weeks_uniq.each do |week|
			if week === nil || week <= 0 || week >= 23
				@weeks_array = @weeks_array.unshift(["Week " + week.to_s + " invalid", 0])
			else
				@weeks_array = @weeks_array << ["Results --- " + select_week(week, 0) , week]
			end
		end
		return @weeks_array
	end
	# create an array of ONLY the weeks for which Picks exist
	# pick - id -- user_id --- pickchart_id
	# pickchart id -- week --

	# DROPDOWN PRESET --- SET TO THE CURRENT WEEK
		#@weeks_array = []
		#@weeks_uniq.each do |week|
		#	@weeks_array = @weeks_array << select_week(week, 0)
		#end

	# ALSO UPDATE THE WEEK - CHANGE "LATEST"--
	# REMOVE LATEST or CHANGE TO "PAST"

	# find out @weeks_uniq = Pickchart.pluck(:week).uniq  array
	# from that, which weeks have at least one user pick?

	# what of limits of week number below 0 above 23 --ignore

	def cookie_wk
		@cook_num = cookies[:wk]
		return @cook_num.to_i
		#NEED HELPER WHERE CAN PASS IN CURRENT COOKIE AS ARGUMENT
       # ==============

		#have a helper designed to be used AFTER page is loaded
		#implemented when making a cookie change

		#this will rewrite the definition of@latest
		#and domino / cascade rewriting of all the index picks
		# for "latest" picks

		# catch is -- it must be a VALID week number
		#maybe throw a flash message "invalid week"

		#that's a back up of course
		# ideally, your achive dropdown would only list valid weeks
	end

end
