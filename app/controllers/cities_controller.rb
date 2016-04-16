class CitiesController < ApplicationController
  
  def index
  	if(params[:find])
  		@cities = City.where("name like ?", "%#{params[:find]}%")
  	else
  		@cities = City.all.order('CREATED AT DESC')
  	end
  end

end
