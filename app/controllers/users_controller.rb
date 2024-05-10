class UsersController < ApplicationController
	before_action :authorize_access_request! 
	include HealthCalc

	def addtelegram
		current_user.update(telegramusername: params[:username], telegramid: params[:id])
		render json: params
	end

	def ressurect
		expa = current_user.expirience.to_i
			level_info = calcul_getexp(expa, false)
			if level_info
			  level = level_info[0]
			  progress = level_info[1]
			  puts "Player Level: #{level}"
			  puts "Level Progress: #{progress.round(2)}%"
				health = calculate_health_points(level, 1)* 0.2
 				req = {}.as_json
 				req['health'] = health
 				current_user.dead = false
 				current_user.health = health
 				current_user.save
				render json: req

			else
			  puts "Experience exceeds maximum level"
			end		 
	end

	def ghoulstat
		puts "ghoulstat"
		userfind = User.find(payload['user_id'])
		ghoulstat = Mob.find_by!(name: "ghoul")
		bossstat = Mob.find_by!(name: "boss")
		#проверка на наличие ада, если нет то создаем
		if userfind.mobs.include?(ghoulstat)
		  ghoul = ghoulstat
		else
		  userfind.mobs << ghoulstat
		  ghoul = ghoulstat
		end		
		rel = userfind.mob_users.includes(:mob).all
		@hashdata = {}
		rel.each do |relation|
			hashadd  = {death: relation.death, hpweak: relation.damagedeal, mobname: relation.mob.name, fullhp: relation.mob.hp}
			@hashdata.merge!(hashadd)
		end
		response = @hashdata.as_json
		response['bosshp'] = bossstat.hp

    mhp = calculate_health_points("boss", "boss")
    response['bossfullhp'] = mhp.round

		# response['bossfullhp'] = 1320500
    render json: response
	end	

	include ExpCalcul 
  def me
  	puts "---+++++use me controller++++------"
  	us = current_user.expirience.to_i
  	level_info = calcul_getexp(us, false)
		if level_info
		  level = level_info[0]
		  progress = level_info[1] 
		  puts "Player Level: #{level}"
		  puts "Level Progress: #{progress.round(2)}%"
		else
		  puts "Experience exceeds maximum level"
		end
 		
		response = current_user.as_json(only: [:updated_at, :id, :email, :role, :loa, :expirience, :health, :cpoints, :avcpoints, :karma, :cry, :pk, :dead])
   puts "---0000use me controller0000------"
    puts current_user.online_field
    response['lvl'] = level
    response['progress'] = progress.round(2)
    mhp = calculate_health_points(level, 1)
    response['maxhealth'] = mhp.round

    current_user.touch(:online_field)
    # response['online_field'] = current_user.online_field
    render json: response

    
    puts "---0000use me controller0000------"
    puts current_user.online_field
  end	

	def deluser
		@user = User.find(params[:id])
	  if @user.destroy
	  	render json: @user, status: :ok
	  else 	
	  end	 
	end	  
  private
  def current_user
    @current_user ||= User.find(payload['user_id'])
  end  
end
