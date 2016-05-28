require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

 

  # describe "#new" do
  # 	it "invalid sign_up" do
  # 		visit signup_path
  # 		before_count = User.count
  # 		post users_path, user: { name:  "",
  #                          email: "user@invalid",
  #                          password:              "foo",
  #                          password_confirmation: "bar" }
  #       after_count = User.count
  #       expect(before_count).not_to be(after_count)
  #   end
  # end




end
