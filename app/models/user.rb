class User < ActiveRecord::Base
	#set_primary_key :id
	validates_uniqueness_of :user_name, :email
	has_secure_password
	#attr_accessible :user_name, :email, :password, :password_digest
	has_many :picks
end