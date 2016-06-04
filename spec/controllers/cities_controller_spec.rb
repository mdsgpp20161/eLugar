require 'rails_helper'

describe CitiesController do
	describe "get all cities" do
		let!(:array) { City.all }
		it "assigns @cities" do
			get :ranking
			response.should be_success
			expect(assigns(:cities)).to be_a_kind_of(City::ActiveRecord_Relation)
			expect(assigns(:cities)).to match_array(array)
		end

	end
end
