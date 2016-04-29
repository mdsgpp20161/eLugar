class CitiesController < ApplicationController
  def index
    
  end

  def show_cities
    sorted_cities = params[:sort_cities]
  	if(params[:find])
      @cities = City.where("name like ?", "%#{params[:find]}%")
      case sorted_cities
        when "Populacao"
          @cities = @cities.sort_by{|obj| obj.population.to_f}.reverse
        when "Densidade"
          @cities = @cities.sort_by{|obj| obj.demographic_density.to_f}.reverse
        when "Area"
          @cities = @cities.sort_by{|obj| obj.area.to_f}.reverse
        when "Frota"
          @cities = @cities.sort_by{|obj| obj.fleet.to_f}.reverse
        when "IDH"
          @cities = @cities.sort_by{|obj| obj.idh.to_f}.reverse
        when "Gini"
          @cities = @cities.sort_by {|obj| obj.gini.to_f}.reverse
        when "Saude"
          @cities = @cities.sort_by{|obj| obj.health.to_f}.reverse
        else
  		    @cities = @cities.sort{ |a,b| a.name.downcase <=> b.name.downcase }
      end
  	else
  		@cities = City.all
      @cities = @cities.sort{ |a,b| a.name.downcase <=> b.name.downcase }
  	end
  end

  def show
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
