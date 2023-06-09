class MobsController < ApplicationController
	before_action :authorize_access_request!

	def hitghoul
		# hitghoul = Mob.find_by!(name: "ghoul")
		mob = Mob.new
		hit = mob.hitcalcul(110, 1)
		puts hit
		@gho = MobUser.where('user_id = ?', payload['user_id'])
	      .joins(:mob).where('name = ?', 'ghoul' )
	      .select('mob_id', 'id', "user_id",'damagedeal', 'mobs.name')
	      .first

		@gho.damagedeal += hit
		@gho.save
		# puts @gho.inspect

		render json: @gho
	end

	def hitboss
		@bosshit = Mob.find_by!(name: "boss")
		 
		render json: @bosshit
	end
end