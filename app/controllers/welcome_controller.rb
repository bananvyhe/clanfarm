class WelcomeController < ApplicationController
	def hello
		ActionCable.server.broadcast("RoomChannel", { body: "This Room is Best Room." })
	end
end
