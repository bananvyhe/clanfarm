class Mob < ApplicationRecord
	has_many :dropitems
	has_many :listitems, :through => :dropitems
	has_many :mob_users
	has_many :users, through: :mob_users
end
