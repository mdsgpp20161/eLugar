require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
	def setup
		@user = User.create(name: "Harrison", email: "pedro@gmail.com", password: "123456", password_confirmation: "123456")
	end

	test "login with invalid information" do
    get :new
    assert_template 'sessions/new'
    post :create, session: { email: "", password: "" }
    assert_template 'sessions/new'
    assert_not flash.empty?
    get :new
  end


  test "login with valid information" do
    get :new
    post :create, session: { email: "pedro@gmail.com", password: "123456" }
    assert_redirected_to @user
  end
end