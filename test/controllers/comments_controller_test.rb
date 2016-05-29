require 'test_helper'

class CommentsControllerTest < ActionController::TestCase
	fixtures :comments

  def setup
		@comment1 = comments(:one)
		@comment2 = comments(:two)
  end

  test "should create comment" do
		get :create
		assert_response :success
  end

end
