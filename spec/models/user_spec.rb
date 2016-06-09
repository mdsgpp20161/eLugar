# require 'rails_helper'
# describe User do
# 	before :each do
# 		@user = User.new
# 		@user.name = "Harrison"
# 		@user.email = "hpedro1195@gmail.com"
# 	end
#
#
# 	it 'is a valid user' do
# 		expect(build(:user)).to be_valid
# 	end
#
# 	it "name should be present" do
# 		expect(build(:user,name: nil)).not_to be_valid
# 	end
#
#
# 	it "email should be present" do
# 		expect(build(:user, email:nil)).not_to be_valid
# 	end
#
#
#
# 	it "name should not be too long" do
# 		expect(build(:user, name: "a"*51)).not_to be_valid
# 	end
#
#
#
# 	it "email should not be valid" do
# 		expect(build(:user, email: "pedro123,com")).not_to be_valid
# 	end
#
#
#
# 	it "email should be valid" do
# 		expect(build(:user, email: "pedro123@gmail.com")).to be_valid
# 	end
#
#
#
# 	it "email should be unique" do
# 		user2 = @user.dup
# 		user2.email = @user.email.upcase
# 		@user.save
# 		expect(user2).not_to be_valid
# 	end
#
# 	it "password confirmation must match password" do
# 		expect(build(:user, password_confirmation: "123456")).to be_valid
# 	end
#
# 	it "password should not be blank" do
# 		expect(build(:user, password: ""*6)).not_to be_valid
# 	end
# 	it "password should has atleast 6 chars" do
# 		expect(build(:user, password: "12345", password_confirmation: "12345")).not_to be_valid
# 	end
#
#
# end
