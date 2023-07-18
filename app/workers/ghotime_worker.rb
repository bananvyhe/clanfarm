class GhotimeWorker < ApplicationController
	include Sidekiq::Worker
	require 'time'
	def perform
		eight_hours_ago = Time.now - (28800000)
		# eight_hours_ago = Time.now - (288 )
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