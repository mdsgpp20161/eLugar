require 'test_helper'

class UsersControllerTest < ActionController::TestCase
	
  fixtures :users
  include SessionsHelper
  def setup
  	@user       = users(:user)
    @other_user = users(:other_user)
  end

  test "should redirect edit when logged in as wrong user" do
    log_in(@other_user)
    get :edit, id: @user
    assert_redirected_to root_url
  end
end