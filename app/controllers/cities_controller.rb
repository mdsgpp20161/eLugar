class CitiesController < ApplicationController
  include CitiesHelper

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
    @city = City.find(@oldID)
		top3
    get_hash
    get_hash_text
    get_hash_values
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
    if attr_name == 'uber'
      return 5 if attr_value
      return 1 if !attr_value
    end
    if attr_name == 'gini'
      attr_value = 1 - attr_value
    end
    if attr_name == 'idh' || attr_name == 'gini'
      if attr_value < 0.3
        return 1
      elsif (0.3...0.4).include?(attr_value)
        return 2
      elsif (0.4...0.6).include?(attr_value)
        return 3
      elsif(0.6..0.7).include?(attr_value)
        return 4
      elsif attr_value > 0.7
        return 5
      end
    end

    @average = City.all.map(&attr_name.to_sym).inject(0, &:+)/City.all.length
    if (0...@average*0.6).include?(attr_value)
      if attr_name == 'health' then return 1 else return 5 end
    elsif (@average*0.6...@average*0.9).include?(attr_value)
      if attr_name == 'health' then return 2 else return 4 end
    elsif ((@average*0.9...@average*1.1).include?(attr_value))
      return 3
    elsif ((@average*1.1...@average*1.4).include?(attr_value))
      if attr_name == 'health' then return 4 else return 2 end
    elsif attr_value > @average*1.4
      if attr_name == 'health' then return 5 else return 1 end
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
