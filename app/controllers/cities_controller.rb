class CitiesController < ApplicationController
  
  def index
  	if(params[:find])
  		@cities = City.where("name like ?", "%#{params[:find]}%").sort{ |a,b| a.name.downcase <=> b.name.downcase }
  	else
  		@cities = City.all.sort{ |a,b| a.name.downcase <=> b.name.downcase }
  	end
  end


  def show
  	@city = City.find(params[:id])
  end

end
