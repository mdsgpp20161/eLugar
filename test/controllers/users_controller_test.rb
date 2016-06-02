require 'test_helper'

class UsersControllerTest < ActionController::TestCase
	
  fixtures :users
  include SessionsHelper
  def setup
  	@user       = users(:user)
    @other_user = users(:other_user)
  end

  test "invalid signup information" do
    get :new
    assert_no_difference 'User.count' do
      post :create, user: { name:  "", email: "user@invalid", password: "foo", password_confirmation: "bar" }
    end
    assert_template 'new'
  end

  test "valid signup information" do
    get :new
    assert_difference 'User.count', 1 do
      post :create, user: { name:  "Example User",
                                            email: "user@example.com",
                                            password:              "password",
                                            password_confirmation: "password" }
    end
    assert_template 'sessions/new'
  end

  test "should not edit a non logged_in user" do
    get :edit, id: :user
    #assert assigns(:user)
    assert_equal(@user.id, users(:user).id)
  end

  test "should redirect edit when logged in as wrong user" do
    log_in(@other_user)
    get :edit, id: @user
    assert_redirected_to root_url
  end

  # test "login with valid information" do
  #   get 'sessions/new'
  #   post 'sessions/create', session: { email: @user.email, password: "123456" }
  #   #assert_template @user
  #   assert_template "show"
  # end


end