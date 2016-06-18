require 'test_helper'

class CitiesControllerTest < ActionController::TestCase
  fixtures :cities

  def setup
    @cityBrasilia = cities(:brasilia)
    @cityCeara = cities(:ceara)
    @cityGoiania = cities(:goiania)
  end

  test "should get index" do
    get :index
    assert_response :success
  end

   test "should get city" do
    get :show, id: @cityBrasilia.id

    assert_response :success, "ssadas#{@cityBrasilia.id}"
  end

  test "should get show_att" do
    get :show_cities, name: @cityBrasilia.name
    get :show_cities, population: @cityBrasilia.population
    get :show_cities, demographic_density: @cityBrasilia.demographic_density
    assert_response :success
  end

  test "search city" do
    get :show_cities, :find => 'brasilia'
    assert_not_nil assigns(:cities)
  end 

  test "should save city" do
    assert @cityCeara.save
  end

test "should get compare" do
  get :compare, id: @cityBrasilia.id
  assert_response :success
end

test "get_emoji should return 2" do
  controler = CitiesController.new
  valor = controler.get_emoji('idh',0.3)

  assert (valor == 2)
end


test "get_emoji should return 3" do
  controler = CitiesController.new
  valor = controler.get_emoji('idh',0.599)

  assert (valor == 3)
end

test "get_emoji should return 4" do
  controler = CitiesController.new
  valor = controler.get_emoji('idh',0.7)

  assert (valor == 4)
end

test "should calculate valid average" do
  controler = CitiesController.new
  
  average = controler.get_average(@cityBrasilia,@cityCeara, 'population')
  assert ((average - 4.166).abs > 0.0001)

  average = controler.get_average(@cityBrasilia,@cityCeara, 'area')
  assert ((average - 42.856).abs > 0.0001)

  average = controler.get_average(@cityBrasilia,@cityCeara, 'demographic_density')
  assert ((average - 59.999).abs > 0.0001)

  average = controler.get_average(@cityBrasilia,@cityCeara, 'health')
  assert ((average - 19.999).abs > 0.0001)

  average = controler.get_average(@cityBrasilia,@cityCeara, 'idh')
  assert ((average - 59.999).abs > 0.0001)

  average = controler.get_average(@cityBrasilia,@cityCeara, 'gini')
  assert ((average - 59.999).abs > 0.0001)

  average = controler.get_average(@cityBrasilia,@cityCeara, 'violence')
  assert ((average - 19.999).abs > 0.0001)

  average = controler.get_average(@cityBrasilia,@cityCeara, 'fleet')
  assert ((average - 33.333).abs > 0.0001)
end

test "get_emoji should return 1 when uber condition is false" do
  controler = CitiesController.new
  valor = controler.get_emoji('uber', !@cityBrasilia.uber)
  
  assert (valor == 1)
end

test "get_emoji should return 3 when attr_name is health with some params" do
  controler = CitiesController.new
  @cityBrasilia.health = 5
  valor = controler.get_emoji('health', @cityBrasilia.health)

  assert (valor == 3), "valor = #{valor}"
end


test "get_emoji should return 5 when attr_name is health with some params" do
  controler = CitiesController.new
  valor = controler.get_emoji('health', @cityGoiania.health)

  assert (valor == 5), "valor = #{valor}"
end

#test "should get compare from show" do
#  get :compare, id: @cityBrasilia.id
#  assert_response :success
#  assert_match /https:\/\/localhost:3000\/compare/, @response.redirect_url
#end
end
