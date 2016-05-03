class CitiesController < ApplicationController
  def index
    
  end

  def show_cities
  	if(params[:find])
      @cities = City.where("name like ?", "%#{params[:find]}%")

      if (params[:from_idh].present?) and (params[:to_idh].present?)
        @cities = @cities.where(idh: params[:from_idh].to_f .. params[:to_idh].to_f)
      end
      if (params[:from_population].present?) and (params[:to_population].present?)
        @cities = @cities.where(population:params[:from_population].to_i .. params[:to_population].to_i)
      end
      if (params[:from_density].present?) and (params[:to_density].present?)
        @cities = @cities.where(demographic_density: params[:from_density].to_f .. params[:to_density].to_f)
      end
      if (params[:from_area].present?) and (params[:to_area].present?)
        @cities = @cities.where(area: params[:from_area].to_f .. params[:to_area].to_f)
      end
      if (params[:from_fleet].present?) and (params[:to_fleet].present?)
        @cities = @cities.where(fleet: params[:from_fleet].to_f .. params[:to_fleet].to_f)
      end
      if (params[:from_gini].present?) and (params[:to_gini].present?)
        @cities = @cities.where(gini: params[:from_gini].to_f .. params[:to_gini].to_f)
      end
      if (params[:from_health].present?) and (params[:to_health].present?)
        @cities = @cities.where(health: params[:from_health].to_f .. params[:to_health].to_f)
      end
      if (params[:from_violence].present?) and (params[:to_violence].present?)
        @cities = @cities.where(violence: params[:from_violence].to_f .. params[:to_violence].to_f)
      end
      if (params[:uber_rb])
        @cities = @cities.where(uber: 'Sim')
      end

      sorted_cities = params[:sort_cities]
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
    get_hash
    @oldID = params[:id]
    @city = City.find(@oldID)
  end

  def compare
    get_hash
    if(params[:id])
      @oldID = params[:id]
      @city1 = City.find(@oldID)
    end
    if(params[:newID])
      @newID = params[:newID]
      @city2 = City.find(@newID)
      @population = @city1.population*100/(@city1.population + @city2.population)
    end
    if(params[:find])
      @cities = City.where("name like ?", "%#{params[:find]}%").sort{ |a,b| a.name.downcase <=> b.name.downcase }
    else
      @cities = City.all.sort{ |a,b| a.name.downcase <=> b.name.downcase }
    end
  end

  def get_hash
    @hash = Hash.new
    @hash['name'] = 'Nome'
    @hash['population'] = 'População Estimada 2015'
    @hash['demographic_density'] = 'Densidade Demográfica'
    @hash['area'] = 'Tamanho da Cidade'
    @hash['fleet'] = 'Transporte'
    @hash['idh'] = 'IDH'
    @hash['gini'] = 'Índice de Gini'
    @hash['health'] = 'Índice de Saúde'
    @hash['violence'] = 'Índice de Violência'
    @hash['uber'] = 'Uber'
  end
end
