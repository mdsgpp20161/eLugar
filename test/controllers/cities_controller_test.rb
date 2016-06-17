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

test "get_emoji_others should return 2 if params is health and be in some range" do
  
  emoji = get_emoji_others('health', @cityFlorianopolis.health)
  assert (emoji == 2)

end

test "get_emoji_others should return 3 if params is health and be in some range" do
  
  emoji = get_emoji_others('health', @cityCuiaba.health)
  assert (emoji == 3)

end

test "get_emoji_others should return 4 if params is health and be in some range" do
  
  emoji = get_emoji_others('health', @cityCeara.health)
  assert (emoji == 4)

end

test "get_emoji_others should return 5 if params is health and be in some range" do
  
  emoji = get_emoji_others('health', @cityGoiania.health)
  assert (emoji == 5)

end

test "should get emojis according to user preferences when he doesn't support uber" do
    log_in(@user)

    emoji = set_emojis_by_user('uber', 5)

    assert (emoji == 1)
end

test "should get emojis according to user preferences when he likes crowded cities" do
    log_in(@user)

    emoji = set_emojis_by_user('demographic_density', 4)

    assert (emoji == 2)
end

test "should get a valid type of return on valid_attributes_ranking " do 
  param = valid_attributes_ranking

  assert (param.class == Hash)
end

test "should get a valid type of return on valid_attributes_compare_down" do 
  param = valid_attributes_compare_down

  assert (param.class == Hash)
end

test "should get a valid type of return on valid_attributes_compare_up" do 
  param = valid_attributes_compare_up

  assert (param.class == Hash)
end

  test "should get users preferences" do
  log_in(@user)
  hash = Hash.new
  hash1 = Hash.new
  get_users_preferences
  
  hash1 = @profile.attributes
  puts "id2: "+@profile.users_id.to_s
  @user.profileQuiz_id = @profile.id
  assert_equal @user.profileQuiz_id, @profile.id

  @profile.attributes.each do |attr_name, attr_value|
        if attr_name != 'id'
          hash[attr_name] = attr_value == 1
        end
      end
 # puts hash1['uber']
  if hash1['id']!= false
    hash1['id'] = false
  end
  @profileQuiz = ProfileQuiz.find_by(id: @user.profileQuiz_id)
  puts @profileQuiz.population
  #assert_nil hash2['id']
  assert_not_includes(hash,'id')
  assert_equal hash['uber'], true
  assert_equal hash1['uber'], 1
  get_users_preferences

  #assert_equal (assigns(hash[attr_name])), 'uber'
end

#test "should get compare from show" do
#  get :compare, id: @cityBrasilia.id
#  assert_response :success
#  assert_match /https:\/\/localhost:3000\/compare/, @response.redirect_url
#end
end
