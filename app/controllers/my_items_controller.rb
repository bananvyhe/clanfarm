class MyItemsController < ApplicationController

  def getdrop
  	@items = Dropitem.joins(:mob).where('mobs.name = ?', 'pumpkin').includes(:listitem) 
  	# @items = Dropitem.includes(:listitem) 
  	# @items = Dropitem.joins(:mob).joins(:listitem).where('mobs.name = ?', 'pumpkin')  
  	# @items.inspect
  	@@drop = []
		@items.each do |item| 
		  puts item.listitem.inspect
		  rate = item.listitem.rate
		  puts rate
		  allchance = 100/rate
		  calc = rand(1..allchance.to_i)
		  # puts item.listitem
		  puts calc
		  if calc == 1
		  	@@drop << item.listitem.as_json(only: [:id, :title, :desc, :item, :rate])
		  end
		end

 		# puts drop.inspect
  	# @items = Listitem.find(4)
  	render json: @@drop
  end


	private
 
	def my_item_params
    params.require(:my_item).permit( :id, :my_item_id, :position, :qty, :listid )
  end		 	
end
