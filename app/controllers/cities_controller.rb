class CitiesController < ApplicationController
  include CitiesHelper
  include SessionsHelper

  def index
  end

	def ranking
		@cities = City.all
		order_cities
		@cities = @cities.paginate(:page => params[:page], :per_page => 10)
		if params[:sort_cities]
		  attr_to_erb
		end
	end

  def show_cities
    @citiesPaginated = City.paginate(:page => params[:page], :per_page => 6)
    get_hash
    if(params[:find])
      @find = params[:find]
      search_cities
      @cities = @cities.paginate(:page => params[:page], :per_page => 6)

      @cities.columns.each do |attr|
        if(params[:"from_#{attr.name}"].present?) and (params[:"to_#{attr.name}"].present?)
          @cities = @cities.where("#{attr.name}": params[:"from_#{attr.name}"].to_f .. params[:"to_#{attr.name}"].to_f)
          sorted = true
          break
        end
      end

      order_cities

    else
      @cities = City.all.paginate(:page => params[:page], :per_page => 6)
      @cities = @cities.order(:name)
  	end
  end


  def show
    @oldID = params[:id]
		if @oldID != nil
    	@city = City.find(@oldID)
    	get_hash_values
		end
		top3
    get_hash
    get_hash_text
  end

  def compare
    get_hash
    get_hash_metrics
    if(params[:id])
      @oldID = params[:id]
      @city1 = City.find(@oldID)
    end
    if(params[:newID])
      @newID = params[:newID]
      @city2 = City.find(@newID)
      #@population = @city1.population*100/(@city1.population + @city2.population)
    end
    if(params[:find])
      search_cities
      order_cities
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

  def get_hash_text
    @hashText = Hash.new
    @hashText['population'] = "Esse dado indica a quantidade de pessoas que habitavam na cidade no ano de 2015 (Censo mais atual)."
    @hashText['demographic_density'] = 'Esse dado indica a quantidade de pessoas por quilômetro quadrado na cidade. Indica o quão cheia a cidade está.'
    @hashText['area'] = 'Esse dado indica o tamanho da cidade em quilômetros quadrados.'
    @hashText['fleet'] = 'Esse dado indica a quantidade de pessoas por veículos de transporte público,mostrando a cobertura do transporte público dentro da cidade.'
    @hashText['idh'] = 'Esse dado indica o quão desenvolvida a cidade se encontra. Quanto maior o número, mais desenvolvida ela está.'
    @hashText['gini'] = 'Esse dado indica o nível de desigualdade existente na cidade. Quanto maior o número, maior a desiguldade.'
    @hashText['health'] = 'Esse dado indica a cobertura total de estabelecimentos de saúde em relação a quantidade de pessoas e ao tamanho da cidade.'
    @hashText['violence'] = 'Esse dado mostra a taxa de homícidios por armas de fogo na cidade entre os anos de 2010 e 2012.'
    @hashText['uber'] = 'Esse dado indica se a cidade possui ou não cobertura do serviço de caronas Uber.'
  end

  def get_hash_metrics
    @hashMetric = Hash.new
    @hashMetric['population'] = '(Número de habitantes)'
    @hashMetric['demographic_density'] = '(Habitantes/Km²)'
    @hashMetric['area'] = '(Km²)'
    @hashMetric['fleet'] = '(Habitantes/Quantidade de onibus)'
    @hashMetric['health'] = '(Densidade/Estabelecimentos de saúde)'
    @hashMetric['violence'] = '(Quantidade de homicídios)'
  end

  helper_method :get_emoji
    def get_emoji (attr_name, attr_value)
      @current_user = User.find_by(id: session[:user_id])
      if logged_in? && @current_user.profileQuiz_id != nil
        get_preferences(attr_name, attr_value)
      else
        get_common_preferences(attr_name, attr_value)
      end
  end

  def get_hash_values
    @hashValue = Hash.new
    @hashValue['population'] = "Habitantes: #{@city.population} Hab"
    @hashValue['demographic_density'] = "Densidade: #{@city.demographic_density} Hab/Km²"
    @hashValue['area'] = "Área: #{@city.area} Km²"
    @hashValue['fleet'] = "Frota: #{@city.fleet} Hab/Onibus"
    @hashValue['idh'] = "IDH: #{@city.idh}"
    @hashValue['gini'] = "Gini: #{@city.gini}"
    @hashValue['health'] = "Saúde: #{@city.health} Hospitais/Densidade"
    @hashValue['violence'] = "Violência: #{@city.violence} homícidios"
    @hashValue['uber'] = "Uber: " + if @city.uber then "Sim" else "Não" end
  end

  helper_method :get_average
  def get_average (city1, city2, attr_name)
    attr_value1 = city1.send(attr_name.to_sym)
    attr_value2 = city2.send(attr_name.to_sym)

    attr_value1*100/(attr_value1 + attr_value2)
  end
end
