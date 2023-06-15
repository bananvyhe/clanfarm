class MobsController < ApplicationController
	before_action :authorize_access_request!
	include ExpCalcul 

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

# def calculate_level(exp)
#   level_data = [
#     [68, 1],
#     [369, 2],
#     [1168, 3],
#     [2884, 4],
#     [6038, 5],
#     [11287, 6],
#     [19423, 7],
#     [31378, 8],
#     [48229, 9],
#     [71202, 10],
#     [101677, 11],
#     [141193, 12],
#     [191454, 13],
#     [254330, 14],
#     [331867, 15],
#     [426288, 16],
#     [540000, 17],
#     [675596, 18],
#     [835862, 19],
#     [920357, 20],
#     [1015431, 21],
#     [1123336, 22],
#     [1246808, 23],
#     [1389235, 24],
#     [1554904, 25],
#     [1749413, 26],
#     [1980499, 27],
#     [2260321, 28],
#     [2634751, 29],
#     [2844287, 30],
#     [3093068, 31],
#     [3389496, 32],
#     [3744042, 33],
#     [3744042, 33]
#   ]

#   level_data.each_with_index do |data, i|
#     if exp <= data[0]
#       previous_exp = i > 0 ? level_data[i - 1][0] : 0
#       current_exp = data[0]
#       progress = (exp - previous_exp) / (current_exp - previous_exp) * 100
#       return [i + 1, progress]
#     end
#   end

#   nil # Experience exceeds maximum level
# end

	def calculate_experience(health)
	  min_health = 100 
	  max_health = 5_000_000 
	  min_experience = 50 
	  max_experience = 100_000 
	  
	  scaled_experience = min_experience + (health - min_health) * (max_experience - min_experience) / (max_health - min_health)
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