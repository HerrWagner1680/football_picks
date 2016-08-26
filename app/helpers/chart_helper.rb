module ChartHelper
	def latest_wk(pickchart)
		Pickchart.maximum(:week)
		if Pickchart.maximum(:week).nil?
			return 1
		end
	end

	def prev_wk(pickchart)
		Pickchart.maximum(:week) - 1
	end

	def name_wk(week_num)
		p "XXXXXXX name_wk HELPER XXXXXX"
		if week_num >= 22 
			week_num = 22
		end
		if week_num < 1
			week_num = 1
		end
		week_names = ["Week 0 - DEMO TEST", "Week 1", "Week 2", "Week 3", "Week 4",
		 "Week 5", "Week 6", "Week 7", "Week 8", "Week 9", "Week 10", "Week 11", 
		 "Week 12", "Week 13", "Week 14", "Week 15", "Week 16", "Week 17", 
		 "Wild Card 1", "Wild Card 2", "Championship", "Playoff", "Playoff", "Playoff"]
		week_names[week_num]
	end

	def week_wo_week(week_num)
		p "XXXXXX week_wo_week HELPER XXXXXX"
		if week_num >= 22 
			week_num = 22
		end
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
		p "THIS IS THE STANDING TABLE"
		p Standing.where(user_id: id_of_user).order('week ASC')
	end

	def standing_cells(standing_user, week_num)
		Standing.where(user_id: standing_user, week: week_num)
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

end
