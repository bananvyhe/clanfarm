class UsersController < ApplicationController
	before_action :authorize_access_request! 
	

	def ghoulstat
		puts "ghoulstat"
		# userfind = User.find(payload['user_id'])
		# ghoulstat = Mob.find_by!(name: "ghoul")
		# if userfind.mobs.include?(ghoulstat)
		#   ghoul = true 
		# else
		#   ghoul = userfind.ghoulstats << ghoulstat

		#   puts "A connection has been created between the user and the object."
		# end		
  #   # combined_object = {
  #   #   userfind: @userfind,
  #   #   ghoulstat: @ghoulstat
  #   # }
  #   render json: ghoul
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
