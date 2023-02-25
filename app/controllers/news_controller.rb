class NewsController < ApplicationController

	def index
  	puts "==========="
  	@news = News.limit(16).order(created_at: :desc).offset(params[:pos])

		puts params[:pos]
	 
		render json: @news
		puts "||||||||||"
  end

end
