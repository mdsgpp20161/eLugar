class CitiesController < ApplicationController
  
  def index
  	if(params[:find])
  		@cities = City.where("name like ?", "%#{params[:find]}%")
  	else
  		@cities = City.all.order('created_at DESC')
  	end
  end

end
