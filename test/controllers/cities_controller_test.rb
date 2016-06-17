require 'test_helper'

class CitiesControllerTest < ActionController::TestCase
  fixtures :cities
  include CitiesHelper
  include SessionsHelper

  def setup
    @cityBrasilia = cities(:brasilia)
    @cityCeara = cities(:ceara)
    @cityGoiania = cities(:goiania)
    @cityFlorianopolis = cities(:florianopolis)
    @cityCuiaba = cities(:cuiaba)
    @user = User.create(name: "Harrison", email: "pedro@gmail.com", 
      password: "123456", password_confirmation: "123456")
    @profile = ProfileQuiz.create(uber: 1, demographic_density: 1, area: 1, population: 1, users_id: @user.id)
    controller = CitiesController.new
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

test "should get compare when searching city using search bar" do
  get :compare, id: @cityBrasilia.id, newID: @cityCeara.id, find: 'bra'
  assert_response :success
end

test "should get compare when user doesn't search a city" do
  get :compare, id: @cityBrasilia.id, newID: @cityCeara.id
  assert_response :success
end

test "should get ranking" do
  get :ranking
  assert_response :success
end

test "should show city using filter for population" do
  get :show_cities, find: 'a', from_population: 3, to_population: 5
  assert_response :success
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

test "get_emoji should return 5 when attr_name is health with some params and is setted" do
  controler = CitiesController.new
  @cityBrasilia.health = 5
  valor = controler.get_emoji('health', @cityBrasilia.health)

  assert (valor == 5), "valor = #{valor}"
end


  test "should get users preferences" do
  log_in(@user)
  hash1 = Hash.new
  @user.profileQuiz_id = @profile.id
  @profile.id = @user.profileQuiz_id
  @profile = ProfileQuiz.find_by(id: @profile.id)
  @profile.save!
  get_users_preferences
  assert_not_equal @profile, nil
end

test "ranking should get all cities" do
  get :ranking, :sort_cities => 'IDH'
  assert_not_empty assigns(:cities)
end
