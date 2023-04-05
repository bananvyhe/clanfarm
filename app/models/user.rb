class User < ApplicationRecord
	has_secure_password
	has_many :myItems, :dependent => :destroy
	has_many :listitem, :through => :myItems
	enum role: %i[user manager admin].freeze
	
end
