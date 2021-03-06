require 'test_helper'

class CitiesHelperTest < ActionView::TestCase
  fixtures :cities
  include CitiesHelper
  include SessionsHelper

  def setup
    @cityBrasilia = cities(:brasilia)
    @cityCeara = cities(:ceara)
    @cityGoiania = cities(:goiania)
    @cityFlorianopolis = cities(:florianopolis)
    @cityCuiaba = cities(:cuiaba)
    @cityManaus = cities(:manaus)
    @cityMaceio = cities(:maceio)
    @user = User.create(name: "Harrison", email: "pedro@gmail.com", 
      password: "123456", password_confirmation: "123456")  
    @profile = ProfileQuiz.create(uber: 0, demographic_density: 0, area: 1, population: 1, users_id: @user.id)
    @user2 = User.create(name: "Junin", email: "junin@gmail.com", 
      password: "123456", password_confirmation: "123456", profileQuiz_id: @profile.id)
  end

  test "get_emoji should return 2" do
    valor = get_emoji_idh_gini('idh',0.3)

    assert (valor == 2)
  end


  test "get_emoji should return 3" do
    valor = get_emoji_idh_gini('idh',0.599)

    assert (valor == 3)
  end

  test "get_emoji should return 4" do
    valor = get_emoji_idh_gini('idh',0.7)

    assert (valor == 4)
  end

  test "should calculate valid average" do
    
    average = get_average(@cityBrasilia,@cityCeara, 'population')
    assert ((average - 4.166).abs > 0.0001)

    average = get_average(@cityBrasilia,@cityCeara, 'area')
    assert ((average - 42.856).abs > 0.0001)

    average = get_average(@cityBrasilia,@cityCeara, 'demographic_density')
    assert ((average - 59.999).abs > 0.0001)

    average = get_average(@cityBrasilia,@cityCeara, 'health')
    assert ((average - 19.999).abs > 0.0001)

    average = get_average(@cityBrasilia,@cityCeara, 'idh')
    assert ((average - 59.999).abs > 0.0001)

    average = get_average(@cityBrasilia,@cityCeara, 'gini')
    assert ((average - 59.999).abs > 0.0001)

    average = get_average(@cityBrasilia,@cityCeara, 'violence')
    assert ((average - 19.999).abs > 0.0001)

    average = get_average(@cityBrasilia,@cityCeara, 'fleet')
    assert ((average - 33.333).abs > 0.0001)
  end

  test "get_emoji_others should return 2 if params is health and be in some range" do
    
    emoji = get_emoji_others('health', @cityManaus.health)

    assert (emoji == 2), "#{emoji}"
  end

  test "get_emoji_others should return 3 if params is health and be in some range" do
    @cityMaceio.health += 0.5
    emoji = get_emoji_others('health', @cityMaceio.health)
    assert (emoji == 3), "#{emoji}"
  end

  test "get_emoji_others should return 4 if params is health and be in some range" do
    
    emoji = get_emoji_others('health', @cityFlorianopolis.health)
    assert (emoji == 4), "#{emoji}"

  end

  test "get_emoji_others should return 5 if params is health and be in some range" do
    
    emoji = get_emoji_others('health', @cityGoiania.health)
    assert (emoji == 5)

  end

  test "should get emojis according to user preferences when he doesn't support uber" do
      log_in(@user2)

      emoji = set_emojis_by_user('uber', 5)

      assert (emoji == 1)
  end

  test "should get emojis according to user preferences when he likes crowded cities" do
      log_in(@user2)

      emoji = set_emojis_by_user('demographic_density', 4)

      assert (emoji == 2)
  end

  test "should get a valid type of return on valid_attributes_order " do 
    param = valid_attributes_order

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

  test "should get a filled array of cities" do
   assert_not_empty city_data_array
  end

  test "should get 12 suggested cities" do
    assert_equal 12, suggest_city(City.all[0]).size
  end

  test "top3 by an attribute should not be empty" do
    assert_not_empty top3['idh']
  end

  test "should get valid_attributes_compare_down" do
    assert valid_attributes_compare_down
  end

  test "should get valid_attributes_compare_up" do
    assert valid_attributes_compare_up
  end

  test "set_medals should not be empty" do
    assert_not_empty set_medals(City.all[0], City.all[1])
  end

  test "should get attribute_to_metric" do
    assert attribute_to_metric
  end
end
