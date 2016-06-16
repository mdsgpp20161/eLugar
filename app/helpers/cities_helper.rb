module CitiesHelper
  def search_cities
    @cities = City.where("name like ?", "%#{params[:find]}%")
  end

  def order_cities
    sorted_cities = params[:sort_cities]

    @cities.columns.each do |attr|
      if(sorted_cities == attribute_to_text[attr.name])
        if(attr.name == 'demographic_density' || attr.name == 'gini' || attr.name == 'violence' || 
        attr.name == 'fleet')
          @cities = @cities.order(:"#{attr.name}")
        else
          @cities = @cities.order("#{attr.name}": :desc)
        end
      end
    end

    if(!params[:sort_cities])
      @cities = @cities.order(:name)
    end
  end

  def attr_to_erb
    @attr_name = attribute_to_text.index(params[:sort_cities])
    @attr_rendered = Array.new(1)
    @cities.each do |c|
      aux = ERB.new("<%= c.#{@attr_name} %>").result(binding)
      @attr_rendered.push(aux)
    end
  end

  def top3
    top = Hash.new
    top = {
      'fleet' => City.order(:fleet).first(3),
      'idh' => City.order(idh: :desc).first(3),
      'gini' => City.order(:gini).first(3),
      'health' => City.order(health: :desc).first(3),
      'violence' => City.order(:violence).first(3)
    }
  end

  def valid_attributes_show_cities
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

  def valid_attributes_show
    valid_attributes = Hash.new
    valid_attributes = {
      'population' => true,
      'demographic_density' => true,
      'area' => true,
      'fleet' => true,
      'idh' => true,
      'gini' => true,
      'health' => true,
      'violence' => true,
      'uber' => true
    }
  end

  # Attributes that gets better when it gets higher
  def valid_attributes_compare_up
    valid_attributes = Hash.new
    valid_attributes = {
      'population' => true,
      'area' => true,
      'idh' => true,
      'health' => true
    }
  end

  # Attributes that gets worse when it gets higher
  def valid_attributes_compare_down
    valid_attributes = Hash.new
    valid_attributes = {
      'demographic_density' => true,
      'fleet' => true,
      'gini' => true,
      'violence' => true,
    }
  end

  def set_medals (city1, city2)
    medals = Hash.new
    City.columns.each do |attr|
      if(valid_attributes_compare_up[attr.name])
        if(get_average(city1, city2, attr.name) > 50)
          medals[attr.name] = true
        else
          medals[attr.name] = false
        end
      elsif(valid_attributes_compare_down[attr.name])
        if(get_average(city1, city2, attr.name) < 50)
          medals[attr.name] = true
        else
          medals[attr.name] = false
        end
      end
    end
    medals
  end

  def valid_attributes_ranking
    valid_attributes = Hash.new
    valid_attributes = {
      'population' => 'População Estimada 2015',
      'demographic_density' => 'Densidade Demográfica',
      'area' => 'Tamanho da Cidade',
      'fleet' => 'Transporte',
      'idh' => 'IDH',
      'gini' => 'Índice de Gini',
      'health' => 'Índice de Saúde',
      'violence' => 'Índice de Violência'
    }
  end

  def medal_names
    medal_name = Hash.new
    medal_name = {
      0 => 'gold_medal',
      1 => 'silver_medal',
      2 => 'bronze_medal'
    }
  end

  def attribute_to_text
    attribute_to_text = Hash.new
    attribute_to_text = {
      'name' => 'Nome',
      'population' => 'População Estimada 2015',
      'demographic_density' => 'Densidade Demográfica',
      'area' => 'Tamanho da Cidade',
      'fleet' => 'Transporte',
      'idh' => 'IDH',
      'gini' => 'Índice de Gini',
      'health' => 'Índice de Saúde',
      'violence' => 'Índice de Violência',
      'uber' => 'Uber'
    }
  end

  def attribute_to_description
    attribute_to_description = Hash.new
    attribute_to_description = {
      'population' => "Esse dado indica a quantidade de pessoas que habitavam na cidade no ano de 2015 (Censo mais atual).",
      'demographic_density' => 'Esse dado indica a quantidade de pessoas por quilômetro quadrado na cidade. Indica o quão cheia a cidade está.',
      'area' => 'Esse dado indica o tamanho da cidade em quilômetros quadrados.',
      'fleet' => 'Esse dado indica a quantidade de pessoas por veículos de transporte público,mostrando a cobertura do transporte público dentro da cidade.',
      'idh' => 'Esse dado indica o quão desenvolvida a cidade se encontra. Quanto maior o número, mais desenvolvida ela está.',
      'gini' => 'Esse dado indica o nível de desigualdade existente na cidade. Quanto maior o número, maior a desiguldade.',
      'health' => 'Esse dado indica a cobertura total de estabelecimentos de saúde em relação a quantidade de pessoas e ao tamanho da cidade.',
      'violence' => 'Esse dado mostra a taxa de homícidios por armas de fogo na cidade entre os anos de 2010 e 2012.',
      'uber' => 'Esse dado indica se a cidade possui ou não cobertura do serviço de caronas Uber.'
    }
  end

  def attribute_to_value
    attribute_to_value = Hash.new
    attribute_to_value = {
      'population' => "Habitantes: #{@city.population} Hab",
      'demographic_density' => "Densidade: #{@city.demographic_density} Hab/Km²",
      'area' => "Área: #{@city.area} Km²",
      'fleet' => "Frota: #{@city.fleet} Hab/Onibus",
      'idh' => "IDH: #{@city.idh}",
      'gini' => "Gini: #{@city.gini}",
      'health' => "Saúde: #{@city.health} Hospitais/Densidade",
      'violence' => "Violência: #{@city.violence} homícidios",
      'uber' => "Uber: " + if @city.uber then "Sim" else "Não" end
    }
  end

  def attribute_to_metric
    attribute_to_metric = Hash.new
    attribute_to_metric = {
      'population' => '(Número de habitantes)',
      'demographic_density' => '(Habitantes/Km²)',
      'area' => '(Km²)',
      'fleet' => '(Habitantes/Quantidade de onibus)',
      'health' => '(Densidade/Estabelecimentos de saúde)',
      'violence' => '(Quantidade de homicídios)'
    }
  end

  def get_emoji (attr_name, attr_value)
    emoji = 0
    if attr_name == 'uber'
      emoji = get_emoji_uber(attr_name, attr_value)
    elsif attr_name == 'gini' || attr_name == 'idh'
      emoji = get_emoji_idh_gini(attr_name,attr_value)
    else
      emoji = get_emoji_others(attr_name, attr_value)
    end
    emoji
  end

  def get_emoji_others (attr_name, attr_value)
    emoji = 0
    if valid_attributes_show_cities[attr_name]
      average = City.all.map(&attr_name.to_sym).inject(0, &:+) / City.all.length
      case true
      when (0...average * 0.6).include?(attr_value)
        if attr_name == 'health' then emoji = 1 else emoji = 5 end
      when (average * 0.6...average * 0.9).include?(attr_value)
        if attr_name == 'health' then emoji = 2 else emoji = 4 end
      when (average * 0.9...average * 1.1).include?(attr_value)
        emoji = 3
      when (average * 1.1...average * 1.4).include?(attr_value)
        if attr_name == 'health' then emoji = 4 else emoji = 2 end
      when attr_value > average * 1.4
        if attr_name == 'health' then emoji = 5 else emoji = 1 end
      end
    end
    emoji = set_emojis_by_user(attr_name,emoji)
    
    emoji
  end

  def set_emojis_by_user(attr_name, emoji)
    if logged_in?
      answers = Hash.new
      answers = get_users_preferences
      if !answers[attr_name]
        emoji = 6 - emoji
      else
        #do nothing
      end
    else
      #do nothing
    end
    emoji
  end

  def get_emoji_idh_gini (attr_name, attr_value)
    emoji = 0
    if attr_name == 'gini'
      attr_value = 1 - attr_value
    end
    if attr_value < 0.3
      emoji = 1
    elsif (0.3...0.4).include?(attr_value)
      emoji = 2
    elsif (0.4...0.6).include?(attr_value)
      emoji = 3
    elsif(0.6..0.7).include?(attr_value)
      emoji = 4
    elsif attr_value > 0.7
      emoji = 5
    end
    emoji
  end

  def get_emoji_uber(attr_name, attr_value)
    answers = Hash.new
    if attr_value then emoji = 5 else emoji = 1 end
    emoji = set_emojis_by_user(attr_name, emoji)    
    emoji
  end

  def get_average (city1, city2, attr_name)
    attr_value1 = city1.send(attr_name.to_sym)
    attr_value2 = city2.send(attr_name.to_sym)
    attr_value1 * 100 / (attr_value1 + attr_value2)
  end



  def get_users_preferences
    @profileQuiz = ProfileQuiz.new
    @current_user = User.find_by(id: session[:user_id])
    @profileQuiz.id = @current_user.profileQuiz_id
    @profileQuiz = ProfileQuiz.find_by(id: @profileQuiz.id)
    answers = Hash.new
     
    if @profileQuiz
      @profileQuiz.attributes.each do |attr_name, attr_value|
        if attr_name != 'id'
          answers[attr_name] = attr_value == 1
        else
          #do nothing
        end       
      end
    else
      #do nothing
    end
    answers
  end

end

