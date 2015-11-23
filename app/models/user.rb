class User < ActiveRecord::Base
	#set_primary_key :id
	has_secure_password
	attr_accessible :user_name, :email, :password, :password_digest, :created_at, :updated_at
	has_many :picks
end