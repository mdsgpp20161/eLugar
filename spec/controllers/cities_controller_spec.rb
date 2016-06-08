require 'rails_helper'

describe CitiesController do

	describe "check if request rank is ok" do
		it "checks the request" do
			get:ranking
			expect(response).to render_template("ranking")
		end
	end

	describe "get all cities" do
		let!(:array) { City.all }
		it "assigns @cities" do
			get :ranking
			expect(assigns(:cities)).to match_array(array)
			expect(assigns(:cities)).to be_truthy
		end

		describe "pagination" do
			it "checks pagination" do
				get :ranking
				expect(assigns(:cities).total_pages).to be_truthy 
			end	
		end

	end
end
