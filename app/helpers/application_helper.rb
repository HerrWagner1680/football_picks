module ApplicationHelper

# NOTES for August 2017 UPDATE

# adding a standings page for 2016-2017 season
# by assigning the total wins and losses as
# wins and losses for fictional week 24

# Season 2017 - 2018 will be weeks 26 - 49 (approx)
# so, week 26 in the database will display as
# week 1 of Season 2017-2018.

# I want to list all the lines that need tweaking
# date or week-wise.
# HELPERS
# ADMIN HELPER:
#     	def uniq_week_array
#      	def current_week_and_next
#    	  def cookie_wk     starts on line 130
# chart_helper.rb needs complete revision

# CONTROLLERS AFFECTED:
# Users > standing CONTROLLER
# Admin CONTROLLER
# home is unused yet affected if used
# picks CONTROLLER
# users CONTROLLER

# Pickchart.maximum(:week) is a phrase requiring a .where("created_at > ?", "2017-08-16")
# style update
# .maximum(:week) should be at the end of a query
# EXAMPLE  (Careful, this searches BEFORE, meaning < )
# Pickchart.where("created_at < ?", "2017-08-16 17:51:04").maximum(:week)

# Really, you only need to timestamp filter pickcharts and standings.

# GLOBAL $TIMESTAMP VARIABLES IN admin_helper.rb

end
