class GhotimeWorker < ApplicationController
	include Sidekiq::Worker
	require 'time'
	def perform
		# eight_hours_ago = Time.now - (28800000)
		# eight_hours_ago = Time.now - (8 * 60 * 60)
		if APP_CONFIG[:apiUrl] == "http://localhost:3000"
			eight_hours_ago = Time.now - (60 )
		else
			eight_hours_ago = Time.now - (5 * 60 * 60)
		end
	 	gho = MobUser.all
	 	.joins(:mob).where('name = ?', 'ghoul' )
 		gho.each do |c|
 			if c.death == true
 				if eight_hours_ago > c.updated_at 
 					puts "time"
 					c.death = false
 					c.damagedeal = 0
 					c.save
 				end
 			end
 		end
	end
end