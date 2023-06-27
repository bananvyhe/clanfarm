class CpWorker < ApplicationController
	include Sidekiq::Worker
	def perform
		users = User.all
		users.each do |c|
			if c.dead == false && c.cpoints > c.avcpoints 
				c.avcpoints += 2
				puts c.avcpoints 
				puts c.cpoints
				cp = c.avcpoints-2
				if c.avcpoints > c.cpoints && c.karma < 0
					c.avcpoints = c.cpoints 
				elsif cp > c.cpoints && c.karma >= 0
					c.avcpoints = c.cpoints+2
				end
				c.save
			end

		end 
	end
end