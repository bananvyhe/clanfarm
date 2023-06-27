class CpWorker < ApplicationController
	include Sidekiq::Worker
	def perform
		users = User.all
		users.each do |c|
			if c.dead == false && c.cpoints > c.avcpoints 
				c.avcpoints += 2
				if c.avcpoints > c.cpoints && c.karma < 0
					c.avcpoints = c.cpoints 
				end
				c.save
			elsif c.avcpoints >= c.cpoints && c.avcpoints < c.cpoints+2 &&  c.karma >= 0
				c.avcpoints += 2
				if c.avcpoints > c.cpoints+2  
					c.avcpoints = c.cpoints+2 
				end
				c.save
			end
		end 
	end
end