class MobsController < ApplicationController
	before_action :authorize_access_request!
	include ExpCalcul 
	include CpCalcul
	def hitghoul
		userfind = User.find(payload['user_id'])
		expa = userfind.expirience.to_i
		level_info = calcul_getexp(expa)
		if level_info
		  level = level_info[0]
		  progress = level_info[1]
		  puts "Player Level: #{level}"
		  puts "Level Progress: #{progress.round(2)}%"
		else
		  puts "Experience exceeds maximum level"
		end

		mob = Mob.new
		hit = mob.hitcalcul(150, level)
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

			exp = calculate_experience(@gho.mob.hp.to_i)	
			# puts exp
			
			userfind.expirience += exp
			userfind.loa += loa
			userfind.save
		end

		@gho.save
		response = @gho.as_json
		if  exp
			response['exp'] = exp
		end

		response['loa'] = loa
		response['hit'] = hit
		response['lvl'] = level
		response['progress'] = progress.round(2)
		
		# puts @gho.inspect
		render json: response
	end
 
	def calculate_experience(health)
	  min_health = 100 
	  max_health = 5_000_000 
	  min_experience = 50 
	  max_experience = 100_000 
	  
	  scaled_experience = min_experience + (health - min_health) * (max_experience - min_experience) / (max_health - min_health)
	end

	def hitboss
		cpav = calcul_cp(1)
		#расчет удара по боссу
		if cpav != false 
			expa = current_user.expirience.to_i
			level_info = calcul_getexp(expa)
			if level_info
			  level = level_info[0]
			  progress = level_info[1]
			  puts "Player Level: #{level}"
			  puts "Level Progress: #{progress.round(2)}%"
			else
			  puts "Experience exceeds maximum level"
			end
			mob = Mob.new
			hit = mob.hitcalcul(150, level)

			@bosshit = Mob.find_by!(name: "boss")

			#проверка на жив ли моб
			@ghochek = MobUser.where('user_id = ?', payload['user_id'])
		      .joins(:mob).where('name = ?', 'ghoul' )
		      .select( 'death', 'mob_id')
		      .first
			@bosshit.hp -= hit
			@bosshit.save
			response =  @bosshit.as_json

			response['death'] = @ghochek.death
			response['ghohp'] = @ghochek.mob.hp

			# if  rand(5) == 0
				mob = Mob.new
				# hit = mob.hitcalcul(350, 5)
				hit = mob.hitcalcul(350, 5)
				health = current_user.health -= hit
				current_user.save
				response['health'] = health
			# end
			render json: response
		end
		
	end
end