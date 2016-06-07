require 'rails_helper'

describe CitiesHelper do

	describe "check the hash top" do
		let!(:top_hash) { Hash.new  }
		it "match hash array" do
			top_hash['idh'] = City.all.order(idh: :desc).first(3)
			expect(assigns(:top)).to match_array(top_hash)
		end
	end

end
