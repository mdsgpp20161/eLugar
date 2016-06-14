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


	def get_preferences(attr_name, attr_value)
	  @profileQuiz = ProfileQuiz.new
	  @current_user = User.find_by(id: session[:user_id])
      @profileQuiz.id = @current_user.profileQuiz_id
      @profileQuiz = ProfileQuiz.find_by(id: @profileQuiz.id)
      if attr_name == 'uber'
        if @profileQuiz.answer1 == 1 || @profileQuiz.id == nil
          return 5 if attr_value
          return 1 if !attr_value
        else
          return 1 if attr_value
          return 5 if !attr_value
        end
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
          if attr_name == 'population'
            if @profileQuiz.answer4 == 1 then return 1 else return 5 end
          end
          if attr_name == 'area'
            if @profileQuiz.answer3 == 1 then return 1 else return 5 end
          end
          if attr_name == 'demographic_density'
            if @profileQuiz.answer2 == 1 then return 1 else return 5 end
          end
          if attr_name == 'health' then return 1 else return 5 end
        elsif (@average*0.6...@average*0.9).include?(attr_value)
          if attr_name == 'population'
            if @profileQuiz.answer4 == 1 then return 2 else return 4 end
          end
          if attr_name == 'area'
            if @profileQuiz.answer3 == 1 then return 2 else return 4 end
          end
          if attr_name == 'demographic_density'
            if @profileQuiz.answer2 == 1 then return 2 else return 4 end
          end
          if attr_name == 'health' then return 2 else return 4 end
        elsif ((@average*0.9...@average*1.1).include?(attr_value))
          return 3
        elsif ((@average*1.1...@average*1.4).include?(attr_value))
          if attr_name == 'population'
            if @profileQuiz.answer4 == 1 then return 4 else return 2 end
          end
          if attr_name == 'area'
            if @profileQuiz.answer3 == 1 then return 4 else return 2 end
          end
          if attr_name == 'demographic_density'
            if @profileQuiz.answer2 == 1 then return 4 else return 2 end
          end
          if attr_name == 'health' then return 4 else return 2 end
        elsif attr_value > @average*1.4
          if attr_name == 'population'
            if @profileQuiz.answer4 == 1 then return 5 else return 1 end
          end
          if attr_name == 'area'
            if @profileQuiz.answer3 == 1 then return 5 else return 1 end
          end
          if attr_name == 'demographic_density'
            if @profileQuiz.answer2 == 1 then return 5 else return 1 end
          end
          if attr_name == 'health' then return 5 else return 1 end
        end
	end

	def get_common_preferences(attr_name,attr_value)
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

end
