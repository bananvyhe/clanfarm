class UsersController < ApplicationController
	before_action :authorize_access_request! 
	include HealthCalc 

	def ghoulstat
		puts "ghoulstat"
		userfind = User.find(payload['user_id'])
		ghoulstat = Mob.find_by!(name: "ghoul")
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
    render json: @hashdata
	end	
	include ExpCalcul 
  def me
  	us = current_user.expirience.to_i
  	level_info = calcul_getexp(us)
		if level_info
		  level = level_info[0]
		  progress = level_info[1] 
		  puts "Player Level: #{level}"
		  puts "Level Progress: #{progress.round(2)}%"
		else
		  puts "Experience exceeds maximum level"
		end
 
		response = current_user.as_json(only: [:id, :email, :role, :loa, :expirience, :health, :cpoints, :avcpoints, :karma, :cry, :pk, :dead])
    response['lvl'] = level
    response['progress'] = progress.round(2)
    mhp = calculate_health_points(level)
    response['maxhealth'] = mhp.round
    render json: response
  end	

	def deluser
		@user = User.find(params[:id])
	  if @user.destroy
	  	render json: @user, status: :ok
	  else 	
	  end	 
	end	  
end
