module ChartHelper
	def latest_wk(pickchart)
		Pickchart.maximum(:week)
	end

	def prev_wk(pickchart)
		Pickchart.maximum(:week) - 1
	end

end
