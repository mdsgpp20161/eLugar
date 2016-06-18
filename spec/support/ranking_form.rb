class RankingForm
	include Capybara::DSL
	
	def view_ranking_by(option)
		visit('/ranking')
		select option, :from => 'sort_cities'
		click_on('View Ranking')
		self
	end

end
