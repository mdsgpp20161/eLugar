require 'test_helper'

class ArticlesControllerTest < ActionController::TestCase
  fixtures :all

  def setup
    @city1 = cities(:brasilia)
    @city2 = cities(:ceara)
  end

  test "should redirect to report " do
    get :generate_report, city1: @city1.id, city2: @city2.id, format: :pdf
    assert_response :success
  end
end
