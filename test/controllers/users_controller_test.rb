require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  
  fixtures :users
  include SessionsHelper
  def setup
    @user       = users(:user)
    @other_user = users(:other_user)
    @user1 = User.create(name: "Harrison", email: "pedro@gmail.com", password: "123456", password_confirmation: "123456", profileQuiz_id: 1)
    @profile = ProfileQuiz.new
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
    assert_equal(@user.id, users(:user).id)
  end

  test "should redirect root when try to edit a wrong user" do
    log_in(@other_user)
    get :edit, id: @user
    assert_redirected_to root_url
  end

  test "should get edit user" do
      log_in(@user)
      get :edit, id: @user.id
      assert_template 'edit'
    end
    test "should not update user" do
      log_in(@user)
      get :edit, id: @user.id
      assert_template 'edit'
      put :update, :id => users(:user), user: { name:  "",
                                                email: "foo@invalid",
                                                password:              "foo",
                                                password_confirmation: "bar" }
      assert_not_equal "", User.find(users(:user).id).name
    end

    test "should update user" do
      log_in(@user)
      get :edit, id: @user.id
      assert_template 'edit'
      put :update, :id => users(:user), user: { name:  "Pedrinho",
                                                email: "foo@invalid.com",
                                                password:              "foobar",
                                                password_confirmation: "foobar" }
      assert_equal "Pedrinho", User.find(users(:user).id).name
      assert_redirected_to @user
    end

    test "should show user" do
      log_in(@user)
      get :show, id: @user.id
      assert_template 'show'
    end

    test "should delete user" do
      log_in(@other_user)
      get :show, :id => users(:other_user)
      assert_template 'show'
      assert_difference 'User.count', -1 do
        delete :destroy, :id => users(:other_user)
      end
    end

    test "quiz not answered" do
          log_in(@user)
          get :show, :id => users(:user)
          assert_equal nil, User.find(users(:user).id).profileQuiz_id
        end

    test "quiz answered" do
      log_in(@user1)
      get :show, :id => @user1.id, :uber => 1, :demographic_density => 1, :area => 1, :population => 1
      @profile.uber = @request.params[:uber].to_i
      @profile.demographic_density = @request.params[:demographic_density].to_i
      @profile.area = @request.params[:area].to_i
      @profile.population = @request.params[:population].to_i
      @profile.users_id = @user1.id
      @profile.save!
      assert_not_nil @profile.users_id
      assert (@profile.uber == 1)
      assert (@profile.demographic_density == 1)
      assert (@profile.area == 1)
      assert (@profile.population == 1)
      assert (@request.params[:uber].to_i == @profile.uber)
      assert (@request.params[:demographic_density].to_i == @profile.demographic_density)
      assert (@request.params[:area].to_i == @profile.area)
      assert (@request.params[:population].to_i == @profile.population)
      #assert_not_equal @request.params[:uber].to_i, nil
      #assert_equal @request.params[:answer2].to_i, @profile.demographic_density
      #assert_equal @request.params[:answer3].to_i, @profile.area
      #assert_equal @request.params[:answer4].to_i, @profile.population

    end

end