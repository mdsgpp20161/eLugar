# require 'test_helper'

# class UsersEditTest < ActionDispatch::IntegrationTest
#   fixtures :users
#   include SessionsHelper
#   def setup
#     @user = users(:user)
#   end

#   test "unsuccessful edit" do
#     log_in(@user)
#     get edit_user_path(@user)
#     assert_template 'users/edit'
#     user_path(@user), user: { name:  "",
#                                     email: "foo@invalid",
#                                     password:              "foo",
#                                     password_confirmation: "bar" }
#     assert_template 'users/edit'
#   end
# end