require 'rails_helper'
require 'spec_helper'

include CitiesHelper

class CitiesHelperTest < ActionController::TestCase

	def setup
		let!(:controller) { CitiesController.new }
	end

	describe CitiesController, :type => :controller do

			describe "check the hash top" do
				let!(:top_hash) { Hash.new }
				it "match hash array" do
					get :show
					top_hash = City.all.order(idh: :desc).first(3)
					expect(assigns(:top)['idh']).to match_array(top_hash)
				end
			end

	end
end
