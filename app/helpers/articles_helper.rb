module ArticlesHelper
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
end
