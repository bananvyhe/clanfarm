class UsersController < ApplicationController
	before_action :authorize_access_request! 
	

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

  def me
    render json: current_user.as_json(only: [:id, :email, :role, :loa])
  end	

	def deluser
		@user = User.find(params[:id])
	  if @user.destroy
	  	render json: @user, status: :ok
	  else 	
	  end	 
	end	  
end
