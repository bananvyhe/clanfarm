class MobsController < ApplicationController
	before_action :authorize_access_request!
	include ExpCalcul 
	include CpCalcul

	def calculate_experience(health)
	  min_health = 100 
	  max_health = 5_000_000 
	  min_experience = 50 
	  max_experience = 100_000 
	  
	  scaled_experience = min_experience + (health - min_health) * (max_experience - min_experience) / (max_health - min_health)
	end

	def hitghoul
		cpav = calcul_cp(1)
		if cpav != false 
			userfind = User.find(payload['user_id'])
			expa = userfind.expirience.to_i
			level_info = calcul_getexp(expa, false)
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

				expa = userfind.expirience.to_i
				level_info = calcul_getexp(expa, false)
				if level_info
				  level = level_info[0]
				  progress = level_info[1]
				  puts "Player Level: #{level}"
				  puts "Level Progress: #{progress.round(2)}%"
				else
				  puts "Experience exceeds maximum level"
				end
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
			response['avcpoints'] = cpav
			response['cpoints'] = current_user.cpoints			
			# puts @gho.inspect
			render json: response
		end
	end
 


	def hitboss
		cpav = calcul_cp(1)
		#расчет удара по боссу
		if cpav != false 
			expa = current_user.expirience.to_i
			level_info = calcul_getexp(expa, false)
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
		      .select("id", 'death', 'mob_id', 'damagedeal',' user_id')
		      .first
		      puts @ghochek.inspect
			@bosshit.hp -= hit
			@bosshit.save
			response =  @bosshit.as_json
			response['avcpoints'] = cpav
			response['cpoints'] = current_user.cpoints
			response['death'] = @ghochek.death
			response['ghohp'] = @ghochek.mob.hp
			if  rand(2) == 0
				if @ghochek.damagedeal != 0
					mob = Mob.new
					# hit = mob.hitcalcul(350, 5)
					hit = mob.hitcalcul(350, 5)
					puts hit
					health = current_user.health -= hit
					response['health'] = current_user.health

					if current_user.health <= 0
						current_user.health = 0
						response['health'] = 0
						current_user.dead = true
						level_info = calcul_getexp(expa, true)
						if level_info
						  level = level_info[0]
						  progress = level_info[1]
						  current_user.expirience = level_info[2]
						  puts "Player remaining_exp: #{level_info[2]}"
						  puts "Player Level: #{level}"
						  puts "Level Progress: #{progress.round(2)}%"
							response['lvl'] = level
							response['progress'] = progress.round(2)
							response['dead'] = true
							
						end					
					end

					current_user.save
				end
			@ghochek.damagedeal += 1
			@ghochek.save
			end
			render json: response
		else
			render json: { error: "недостаточно очков боя" }, status: :unprocessable_entity
		end
		
	end
end