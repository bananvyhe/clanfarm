class NewsController < ApplicationController
	skip_before_action :verify_authenticity_token
	def index
  	puts "==========="
  	@news = News.limit(16).order(created_at: :desc).offset(params[:pos])

		puts params[:pos]
	 
		render json: @news
		puts "||||||||||"
  end

	def fullnews
		puts "===-----------fullnews----------===="
		puts params[:id]
		 
		full = News.find(params[:id]) 
		 
		 if full.fullarticle.nil?

			agent = Mechanize.new
	    url = full.link 

	    page = agent.get(url)

	    tokenr = News.tokenmake
	 #    get = page.css('.body').to_s
	 #    get = get.force_encoding("utf-8")
		# File.open('777.html', 'w'){ |file| file.write get } 
			url = url.to_s
			compare = url[0..20]

 			if compare == 'https://www.blockchai'
				# puts "entry"
 				@get = page.css('.entry-content').to_s
 				# @get = get[58..-7]
 			elsif compare == 'https://www.pocketgam'
				# puts "body"
 				@get = page.css('.body').to_s
 				# getp = article.gsub '<div class="body" itemprop="articleBody">', ''
				# get = getp.gsub '</div>', ''
				# @get =	get[1..-4]
			elsif compare == 'https://massivelyop.c'
 
				@get = page.css('.td-post-content').to_s

			else
 			end
 			
			# artbody = News.tranklukate(@get, tokenr) 
			# getp =  artbody.gsub 'a href="/','a href="https://massivelyop.com/'
 
 		# 	full.fullarticle = getp
 		# 	full.save!
 
		end
 

			render json: full
 
	end  
	private
	  def news_params
    params.require(:news).permit(:pic, :link, :head, :date, :desc, :tokenrapid)
  end
end
