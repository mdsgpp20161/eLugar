require 'rails_helper'

describe UsersController, "creating a new user" do
  include SessionsHelper
  before :each do
    @user = User.new
    @user.id = 1
    @user.name = "Harrison"
    @user.email = "hpedro1195@gmail.com"
    @user.password = "123456"
    @user.password_confirmation = "123456"
    @user1 = User.new
    @user1.id = 2
    @user1.name = "Pedro"
    @user1.email = "pedro1195@gmail.com"
    @user1.password = "1234567"
    @user1.password_confirmation = "1234567"
  end

    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end


    it "should show a user" do
      user = FactoryGirl.create(:user)
      get :show, id: user  
      expect(assigns(:user)).to eq(user)
    end
    it "should create a valid user" do
      post :create, user: {name: "Harrison", email: "hpedro1195@gmail.com", password: "123456", password_confirmation: "123456"}
      expect(response).to be_redirect
    end
    it"should not create a invalid user" do
      post :create, user: {name: "Harrison", email: "peso123", password: "123456", password_confirmation:"123456"}
      expect(response).to render_template('new')
    end
    it "should redirect edit when not logged in" do
      get :edit, id: @user
      expect(response).to redirect_to(login_url)                        
    end
    it "should redirect edit when logged in as wrong user"do
    #  log_in(@user1)
      get :update, id: @user
      expect(response).to redirect_to(root_url)
  end
 end

