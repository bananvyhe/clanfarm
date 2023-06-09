class Mob < ApplicationRecord
	has_many :dropitems
	has_many :listitems, :through => :dropitems
	has_many :mob_users
	has_many :users, through: :mob_users
	def hitcalcul(dmg, lvl )
 		hit = ((((dmg * (lvl.to_f / 10))) * (rand(0.02..0.12)) + 0.3) * 10).to_i
		puts hit
		return hit
	end
end
