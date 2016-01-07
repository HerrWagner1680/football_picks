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

end
