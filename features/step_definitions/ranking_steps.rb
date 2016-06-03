Given(/^there is a option to choose attribute to show ranking$/) do
		visit('/ranking')
end

When(/^I choose an option$/) do
		select('População Estimada', :from => 'sort_cities')
end

When(/^Click to show the ranking$/) do
		click_on('View Ranking')
end

Then(/^I must see the ranking table$/) do
		expect(page).to have_content()
end
