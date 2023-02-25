class NewsController < ApplicationController
	  def index

  	puts "==========="
  	# @news = News.limit(16).order(created_at: :desc).offset(params[:pos])
@news = News.limit(16)
		puts @news.inspect
	 
		render json: @news
		puts "||||||||||"
 
  end
end
