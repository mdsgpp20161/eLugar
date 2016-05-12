require 'test_helper'

class CitiesControllerTest < ActionController::TestCase
  fixtures :cities

  def setup
  @cityBrasilia = cities(:brasilia)
  @cityCeara = cities(:ceara)
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

#test "should get compare from show" do
#  get :compare, id: @cityBrasilia.id
#  assert_response :success
#  assert_match /https:\/\/localhost:3000\/compare/, @response.redirect_url
#end

end
