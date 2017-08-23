module AdminHelper
  # GLOBAL $TIMESTAMP VARIABLES IN admin_helper.rb
	def mark_h_winner(id)
		# winner is nil home or visit
		@team = Pickchart.where($created_after, $timestamp).find(id).hteam
		@win_col = Pickchart.where($created_after, $timestamp).find(id).winner
		@team = @team.first(23)
		if @win_col === "home"
			@team << " +"
		elsif @win_col === "visitor" || @win_col === "visit"
			@team << " -"
		end
		@team
	end

	def mark_v_winner(id)
		@team = Pickchart.where($created_after, $timestamp).find(id).vteam
		@win_col = Pickchart.where($created_after, $timestamp).find(id).winner
		@team = @team.first(23)
		if @win_col === "visitor" || @win_col === "visit"
			@team << " +"
		elsif @win_col === "home"
			@team << " -"
		end
		@team
	end

	def mark_v_pick(pc_id, user)
		@pc_v = Pickchart.where($created_after, $timestamp).find(pc_id).vteam
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
		@pc_h = Pickchart.where($created_after, $timestamp).find(pc_id).hteam
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
		p "XXXXXXX select_week HELPER XXXX"
		if week_num >= 22
			week_num = 22
		end
		week_names = [["Week 0", 0], ["Week 1", 1], ["Week 2", 2], ["Week 3", 3], ["Week 4", 4],
		 ["Week 5", 5], ["Week 6", 6], ["Week 7", 7], ["Week 8", 8], ["Week 9", 9], ["Week 10", 10], ["Week 11", 11],
		 ["Week 12", 12], ["Week 13", 13], ["Week 14", 14], ["Week 15", 15], ["Week 16", 16], ["Week 17", 17],
		 ["Wild Card 1", 18], ["Wild Card 2", 19], ["Championship", 20], ["Playoff", 21], ["Playoff", 22], ["Playoff", 23]]
		week_names[week_num][index]
	end

# REQUIRES AUG 2017 REVISION uniq_week_array
	def uniq_week_array
		p "XXXXXXXX uniq_week_array HELPER XXXXX"
		@weeks_array = []
		@weeks_uniq = Pickchart.where($created_after, $timestamp).pluck(:week).uniq

		if @weeks_uniq.nil?
			@weeks_array = ["Week 0 - DEMO TEST"]
		else
			@weeks_uniq.each do |week|
				if week === nil || week <= 0 || week >= 23
					@weeks_array = @weeks_array.unshift(["Week " + week.to_s + " invalid", 0])
				else
					@weeks_array = @weeks_array << ["Results --- " + select_week(week, 0) , week]
				end
			end
		end
		return @weeks_array
	end

# REQUIRES AUG 2017 REVISION
	def current_week_and_next
		@week_current = Pickchart.where($created_after, $timestamp).pluck(:week).uniq
		p @week_current[0]
		if @week_current[0].nil?
			@array_for_current_week = [1, 2]
			return @array_for_current_week
		else
			@week_current = Pickchart.where($created_after, $timestamp).pluck(:week).uniq.max
			@next_week = @week_current + 1
			@array_for_current_week = []
			@array_for_current_week.push(@week_current)
			@array_for_current_week.push(@next_week)
			return @array_for_current_week
		end
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

# REQUIRES AUG 2017 REVISION
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

	#def whatzit
	#	return timestamp
	#end

	#def timestamp
		# using this function, use timestamp as variable
	#	return "2017-08-15"
	#end

	#GLOBAL VARIABLES
	$created_after = "created_at > ?"
	#$created_before = "created_at < ?"
	$timestamp = "2017-08-14 17:59:00" #sent to live stark-waters-5182
	#$timestamp = "2015-08-01 12:00:00" #this was sent to stark-waters-1815

end
