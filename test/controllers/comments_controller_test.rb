require 'test_helper'

class CommentsControllerTest < ActionController::TestCase
  fixtures :cities, :comments

  def setup
    @city1 = cities(:ceara)
    @city2 = cities(:brasilia)
  @comment1 = comments(:one)
  @comment2 = comments(:two)
  end

  test "should create comment" do
    get :create, city_id: @comment1.city_id, comment: {commenter: "Felipe", body: "Mensagem"}

    assert_response :redirect, "Blabalblalbalbal"
  end
end
