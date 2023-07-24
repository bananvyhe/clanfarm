class HealthpWorker < ApplicationController
	include Sidekiq::Worker
 	include ExpCalcul 
	include HealthCalc
	def perform
		users = User.all
		users.each do |c|
	  	us = c.expirience.to_i
	  	level_info = calcul_getexp(us, false)
			if level_info
			  level = level_info[0]
			  progress = level_info[1] 
			end	
	    mhp = calculate_health_points(level, 1)
			if c.dead == false && c.health < mhp.round
 				heal = mhp.round*0.13
 				c.health += heal
 				if c.health > mhp.round
 					c.health = mhp.round
 				end
			end
			c.save
		end 
	end
end