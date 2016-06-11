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
		@top['fleet'] = City.order(fleet: :desc).first(3) #in refactoring in merge it will have to be fixed
		@top['idh'] = City.order(idh: :desc).first(3)
		@top['health'] = City.order(health: :desc).first(3)
	end


end
