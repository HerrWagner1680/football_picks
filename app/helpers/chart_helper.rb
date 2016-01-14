module ChartHelper
	def latest_wk(pickchart)
		Pickchart.maximum(:week)
	end

	def prev_wk(pickchart)
		Pickchart.maximum(:week) - 1
	end

	def name_wk(week_num)
		week_names = ["Week 0", "Week 1", "Week 2", "Week 3", "Week 4",
		 "Week 5", "Week 6", "Week 7", "Week 8", "Week 9", "Week 10", "Week 11", 
		 "Week 12", "Week 13", "Week 14", "Week 15", "Week 16", "Week 17", 
		 "Wild Card 1", "Wild Card 2", "Championship", "Playoff", "Playoff", "Playoff"]
		week_names[week_num]
	end

	def week_wo_week(week_num)
		week_names = ["zero", "one", "two", "three", "four",
		 "five", "six", "seven", "eight", "nine", "ten", "eleven", 
		 "twelve", "thirteen", "fourteen", "fifteen", "sixteen", "seventeen", 
		 "wild card one", "wild card two", "Championship", "Playoff", "Playoff", "Playoff"]
		week_names[week_num]
	end

	def name_of_user(id_num)
		User.find(id_num).user_name
	end

	def standing_table(id_of_user)
		Standing.where(user_id: id_of_user).order('week ASC')
	end

	def tot_win(id_of_user)
		@tot = 0
		@user_standings = Standing.where(user_id: id_of_user)
		@user_standings.each do |win|
			@tot = @tot + win.wins
		end
		@tot
	end

	def tot_loss(id_of_user)
		@tot = 0
		@user_standings = Standing.where(user_id: id_of_user)
		@user_standings.each do |loss|
			@tot = @tot + loss.losses
		end
		@tot
	end

	def vis_to_vistor(win_name)
		if win_name === "visit"
			win_name << "or"
		end
		win_name
	end

	# def update_standings(winner_hash, users_array)
	# 	p "sdfsdfsdfsdfsdfsdf -- winner hash in HELPERS"
	# 	p winner_hash
	# 	p users_array
	# 	@wins_tot = 0
	# 	@loss_tot = 0
	# 	@num_users = users_array.length
	# 	#@num_users.times do |yyy|

			#@num_winners = winner_hash.keys.length
			#@num_winners.times do |zzz|
			#	@user_pick = Pick.where(user_id: yyy, pickchart_id: winner_hash[zzz].keys)
			#	if @user_pick.user_pick === winner_hash[zzz].values
			#		@wins_tot = @wins_tot + 1	
			#	else 
			#		@loss_tot = @loss_tot + 1
			#	end
			#end
			#@latest = Pickchart.maximum(:week)
		#	p "update standings stats"
			#p yyy
			#p @wins_tot
			#p @loss_tot
			#Standing.where(user_id: users_array[i-yyy], week: @latest).first_or_create
			#Standing.find_by(user_id: users_array[i-yyy], week: @latest).update(wins: @wins_tot, losses: @loss_tot)
		#end
	#end

end
