class Pickchart < ActiveRecord::Base
	has_many :picks

	def to_param
    	pickchart_number.to_s
	end
end
