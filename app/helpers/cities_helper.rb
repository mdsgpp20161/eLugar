module CitiesHelper

	def search_cities
    	@cities = City.where("name like ?", "%#{params[:find]}%")
  	end

	def order_cities
		get_hash
    	sorted_cities = params[:sort_cities]
    	sorted = false

    	@cities.columns.each do |attr|
      		if(sorted_cities == @hash[attr.name])
        		if(attr.name == 'demographic_density' || attr.name == 'gini' || attr.name == 'violence' || 
          attr.name == 'fleet')
          			@cities = @cities.order(:"#{attr.name}")
        		else
          			@cities = @cities.order("#{attr.name}": :desc)
        		end
	          	sorted = true
    	      	break
	        end
    	  end

    	if(!sorted)
        	@cities = @cities.order(:name)
      	end
	end

	def attr_to_erb
		@attr_name = @hash.index(params[:sort_cities])
		@attr_rendered = Array.new(1)
		@cities.each do |c|
			aux = ERB.new("<%= c.#{@attr_name} %>").result(binding)
			@attr_rendered.push(aux)
		end
	end

	def top3
		@top = Hash.new
		#@top['demographic_density'] = City.order(demograhic_density: :desc).first(3)
		@top['gini'] = City.order(:gini).first(3)
		@top['violence'] = City.order(:violence).first(3)
		@top['fleet'] = City.order(:fleet).first(3)
		@top['idh'] = City.order(idh: :desc).first(3)
		@top['health'] = City.order(health: :desc).first(3)
	end

	def valid_attributes
		valid_attributes = Hash.new
		valid_attributes = {
			'population' => true,
			'demographic_density' => true,
			'area' => true,
			'fleet' => true,
			'idh' => true,
			'gini' => true,
			'health' => true,
			'violence' => true
		}
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

end
