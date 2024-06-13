class User < ApplicationRecord
	has_secure_password
	has_many :my_items, :dependent => :destroy
	has_many :listitem, :through => :my_items
	enum role: %i[user manager admin].freeze
	has_many :mob_users
	has_many :mobs, through: :mob_users	
	has_many :scheduled_tasks, :dependent => :destroy
end
