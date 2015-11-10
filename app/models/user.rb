class User < ActiveRecord::Base
	has_secure_password
	#attr_accessible :user_name, :email, :password, :password_digest
	has_many :picks
end