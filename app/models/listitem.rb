class Listitem < ApplicationRecord
		has_many :my_items 
	has_many :users, :through => :my_items
	has_many :mobs, :through => :dropitems
end
