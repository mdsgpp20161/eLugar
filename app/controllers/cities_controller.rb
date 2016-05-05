class CitiesController < ApplicationController
  def index
    
  end

  def show_cities
    get_hash
    @citiesPaginated = City.paginate(:page => params[:page], :per_page => 6)
  	if(params[:find])
      @find = params[:find]
      @cities = City.where("name like ?", "%#{params[:find]}%")
      @cities = @cities.paginate(:page => params[:page], :per_page => 6)

      @cities.columns.each do |attr|
        if (attr.name == 'id' || attr.name == 'name' || attr.name == 'image' || attr.name == 'created.at' || attr.name == 'updated.at' || attr.name == 'uber')
          next
        end
        if(params[:"from_#{attr.name}"].present?) and (params[:"to_#{attr.name}"].present?)
          @cities = @cities.where("#{attr.name}": params[:"from_#{attr.name}"].to_f .. params[:"to_#{attr.name}"].to_f)
          sorted = true
          break
        end
      end

      sorted_cities = params[:sort_cities]
      sorted = false

      @cities.columns.each do |attr|
        if(sorted_cities == @hash[attr.name])
          @cities = @cities.sort_by{|obj| obj.send(attr.name.to_sym)}.reverse
          sorted = true
          break
        end
      end

      if(!sorted)
        @cities = @cities.sort{ |a,b| a.name.downcase <=> b.name.downcase }
      end
      
    else
  	  @cities = City.all.paginate(:page => params[:page], :per_page => 6)
      @cities = @cities.sort{ |a,b| a.name.downcase <=> b.name.downcase }
  	end
  


  end

  def show
    @oldID = params[:id]
    @city = City.find(@oldID)
    get_hash
    get_hash_text
    get_hash_values   
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

  def get_hash_text
    @hashText = Hash.new
    @hashText['population'] = "Esse dado indica a quantidade de pessoas que habitavam na cidade no ano de 2015 (Censo mais atual)."
    @hashText['demographic_density'] = 'Esse dado indica a quantidade de pessoas por quilômetro quadrado na cidade. Indica o quão cheia a cidade está.'
    @hashText['area'] = 'Esse dado indica o tamanho da cidade em quilômetros quadrados.'
    @hashText['fleet'] = 'Esse dado indica a quantidade de pessoas por veículos de transporte público,mostrando a cobertura do transporte público dentro da cidade.'
    @hashText['idh'] = 'Esse dado indica o quão desenvolvida a cidade se encontra. Combinado com o índice de Gini, trás uma análise importante sobre a condição da cidade.'
    @hashText['gini'] = 'Esse dado indica o nível de desigualdade existente na cidade. Combinado com o IDH, trás uma análise importante sobre a condição da cidade.'
    @hashText['health'] = 'Esse dado indica a cobertura total de estabelecimentos de saúde em relação a quantidade de pessoas e ao tamanho da cidade.'
    @hashText['violence'] = 'Esse dado mostra a quantidade de homícidios por armas de fogo na cidade.'
    @hashText['uber'] = 'Esse dado indica se a cidade possui ou não cobertura do serviço de caronas Uber.'
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
      elsif(0.6...0.7).include?(attr_value)
        return 4
      elsif attr_value > 0.7
        return 5
      end
    end
    
    @average = City.all.map(&attr_name.to_sym).inject(0, &:+)/City.all.length
    if (0...@average*0.6).include?(attr_value)
      return 1
    elsif (@average*0.6...@average*0.9).include?(attr_value)
      return 2
    elsif ((@average*0.9...@average*1.1).include?(attr_value))
      return 3
    elsif ((@average*1.1...@average*1.4).include?(attr_value))
      return 4
    elsif attr_value > @average*1.4
      return 5
    end
  end

  def get_hash_values
    @hashValue = Hash.new
    @hashValue['population'] = "Habitantes: #{@city.population}"
    @hashValue['demographic_density'] = "Densidade: #{@city.demographic_density}"
    @hashValue['area'] = "Área: #{@city.area}"
    @hashValue['fleet'] = "Frota: #{@city.fleet}"
    @hashValue['idh'] = "IDH: #{@city.idh}"
    @hashValue['gini'] = "Gini: #{@city.gini}"
    @hashValue['health'] = "Saúde: #{@city.health}"
    @hashValue['violence'] = "Violência: #{@city.violence}"
    @hashValue['uber'] = "Uber: " + if @city.uber then "Sim" else "Não" end 
  end
end
