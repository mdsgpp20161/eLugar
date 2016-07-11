require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  include SessionsHelper
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


  test "login with valid information followed by logout" do
    get :new
    post :create, session: { email: "pedro@gmail.com", password: "123456" }
    assert_redirected_to @user
    delete :destroy
    assert_redirected_to root_url
  end
end