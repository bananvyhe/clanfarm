class HealthbWorker < ApplicationController
	include Sidekiq::Worker
	include HealthCalc 
	def perform
		bossstat = Mob.find_by!(name: "boss")
		mhp = calculate_health_points("boss", "boss")
    if bossstat.hp < mhp.round
    	bossstat.hp += 16666
    	if bossstat.hp > mhp.round
    		bossstat.hp = mhp.round
    	end
    end
    bossstat.save
	end
end