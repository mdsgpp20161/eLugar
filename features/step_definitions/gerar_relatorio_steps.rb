Given "I am on the $n page" do |arg1|
  visit send("#{arg1}_path")
end

When(/^I press "([^"]*)" button$/) do |arg1|
	click_link_or_button(arg1)
end

And "I will press $n link" do |arg1|
	click_link_or_button(arg1)
end

Then "I should see $n" do |arg1|
	expect(page).to have_content(arg1)
end

And "I will press first city" do
	city = City.order(:name)
	click_link_or_button(city[0].id)
	# puts page.html
	#click_link("1")
end
