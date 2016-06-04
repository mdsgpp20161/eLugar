class ArticlesController < ApplicationController

  def index
    get_hash
    get_hash_metrics
    @city1 = City.find(params[:city1])
    @city2 = City.find(params[:city2])

    @articles = ["#{@city1.name}", "#{@city2.name}"]

    respond_to do |format|

      format.pdf do
        render :pdf => "Relatório de Comparação"
        # ,footer: {center: "[page] of [topage]"}
      end
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

  def get_hash_metrics
    @hashMetric = Hash.new
    @hashMetric['population'] = '(Número de habitantes)'
    @hashMetric['demographic_density'] = '(Habitantes/Km²)'
    @hashMetric['area'] = '(Km²)'
    @hashMetric['fleet'] = '(Habitantes/Quantidade de onibus)'
    @hashMetric['health'] = '(Densidade/Estabelecimentos de saúde)'
    @hashMetric['violence'] = '(Quantidade de homicídios)'
  end

end
