class MobsController < ApplicationController
	before_action :authorize_access_request!

	def hitghoul
		# hitghoul = Mob.find_by!(name: "ghoul")
		mob = Mob.new
		hit = mob.hitcalcul(110, 1)
		puts hit
		@gho = MobUser.where('user_id = ?', payload['user_id'])
	      .joins(:mob).where('name = ?', 'ghoul' )
	      .select('mob_id', 'id', "user_id",'damagedeal', 'mobs.name', 'mobs.hp','mobs.loa', 'death')
	      .first
 
		@gho.damagedeal += hit
		if @gho.damagedeal.to_i >= @gho.hp.to_i
			@gho.damagedeal = @gho.mob.hp
			@gho.death = true
			min = (@gho.mob.loa.to_i * 0.7).round
			max = (@gho.mob.loa.to_i * 1.3).round
			loa = rand(min..max)
			loa = loa.round
			loa = loa.to_i	
		end

		@gho.save
		response = @gho.as_json
		response['loa'] = loa
		response['hit'] = hit
		 
		# puts @gho.inspect
		render json: response
	end

	def hitboss
		@bosshit = Mob.find_by!(name: "boss")
		#проверка на жив ли моб
		@ghochek = MobUser.where('user_id = ?', payload['user_id'])
	      .joins(:mob).where('name = ?', 'ghoul' )
	      .select( 'death', 'mob_id')
	      .first
		response =  @bosshit.as_json
		response['death'] = @ghochek.death
		response['ghohp'] = @ghochek.mob.hp
		render json: response
	end
end