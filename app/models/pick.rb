class Pick < ActiveRecord::Base
	belongs_to :pickchart
	belongs_to :user
end
