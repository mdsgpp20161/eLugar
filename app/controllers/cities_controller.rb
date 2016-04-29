class CitiesController < ApplicationController
  def index
    
  end

  def show_cities
    sorted_cities = params[:sort_cities]
  	if(params[:find])
      @cities = City.where("name like ?", "%#{params[:find]}%")
      case sorted_cities
        when "Populacao"
          @cities = @cities.sort_by{|obj| obj.population}.reverse
        when "Densidade"
          @cities = @cities.sort_by{|obj| obj.demographic_density}.reverse
        when "Area"
          @cities = @cities.sort_by{|obj| obj.area}.reverse
        when "Frota"
          @cities = @cities.sort_by{|obj| obj.fleet}.reverse
        when "IDH"
          @cities = @cities.sort_by{|obj| obj.idh}.reverse
        when "Gini"
          @cities = @cities.sort_by {|obj| obj.gini}.reverse
        when "Saude"
          @cities = @cities.sort_by{|obj| obj.health}.reverse
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
