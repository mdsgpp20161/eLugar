class CitiesController < ApplicationController
  def index
  	if(params[:find])
  		@cities = City.where("name like ?", "%#{params[:find]}%").sort{ |a,b| a.name.downcase <=> b.name.downcase }
  	else
  		@cities = City.all.sort{ |a,b| a.name.downcase <=> b.name.downcase }
  	end
  end

  def show
    # @city = City.find(params[:id])
    @oldID = params[:id]
    @city = City.find(@oldID)
  end

  def compare
    if(params[:id])
      @oldID = params[:id]
      @city1 = City.find(@oldID)
    end
    if(params[:newID])
      @newID = params[:newID]
      @city2 = City.find(@newID)
    end
    if(params[:find])
      @cities = City.where("name like ?", "%#{params[:id]}%").sort{ |a,b| a.name.downcase <=> b.name.downcase }
    else
      @cities = City.all.sort{ |a,b| a.name.downcase <=> b.name.downcase }
    end
  end
end
