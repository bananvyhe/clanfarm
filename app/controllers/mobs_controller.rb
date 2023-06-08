class MobsController < ApplicationController
	before_action :authorize_access_request!

	def hitboss
		@bosshit = Mob.find_by!(name: "boss")
		puts "hit"
		render json: @bosshit
	end
end