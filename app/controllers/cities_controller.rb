class CitiesController < ApplicationController
  def index
    order = params[:order]
  	if(params[:find])
      if(order == "Populacao")
        @cities = City.where("name like ?", "%#{params[:find]}%").sort_by{|obj| obj.population.to_f}.reverse
      end
      if(order == "Densidade")
        @cities = City.where("name like ?", "%#{params[:find]}%").sort_by{|obj| obj.demographic_density.to_f}.reverse
      end
      if(order == "Area")
        @cities = City.where("name like ?", "%#{params[:find]}%").sort_by{|obj| obj.area.to_f}.reverse
      end
      if(order == "Frota")
        @cities = City.where("name like ?", "%#{params[:find]}%").sort_by{|obj| obj.fleet.to_f}.reverse
      end
      if(order == "IDH")
        @cities = City.where("name like ?", "%#{params[:find]}%").sort_by{|obj| obj.idh.to_f}.reverse
      end
      if(order == "Gini")
        @cities = City.where("name like ?", "%#{params[:find]}%").sort_by {|obj| obj.gini.to_f}.reverse
      end
      if(order == "Saude")
        @cities = City.where("name like ?", "%#{params[:find]}%").sort_by{|obj| obj.health.to_f}.reverse
      end
      if(order == "")
  		  @cities = City.where("name like ?", "%#{params[:find]}%").sort{ |a,b| a.name.downcase <=> b.name.downcase }
      end
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
