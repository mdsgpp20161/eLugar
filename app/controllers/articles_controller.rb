class ArticlesController < ApplicationController
  def generate_report
    @city1 = City.find(params[:city1])
    @city2 = City.find(params[:city2])

    @articles = ["#{@city1.name}", "#{@city2.name}"]

    respond_to do |format|
      format.pdf do
        render :pdf => "Relatório de Comparação"
      end
    end
  end
end
