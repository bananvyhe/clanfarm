class User < ApplicationRecord
	has_secure_password
	has_many :my_items, :dependent => :destroy
	has_many :listitem, :through => :my_items
	enum role: %i[user manager admin].freeze
	
end
