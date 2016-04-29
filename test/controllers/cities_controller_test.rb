require 'test_helper'

class CitiesControllerTest < ActionController::TestCase
	fixtures :cities

  def setup
	@cityBrasilia = cities(:brasilia)
  end

  test "should get index" do
    get :index
    assert_response :success
  end

   test "should get city" do
  	get :show, id: @cityBrasilia.id

  	assert_response :success

  end

end
