Given(/^there is a data about top 1 city$/) do
	visit('/cities/0')
end

Given(/^there is a data about top 2 city$/) do
	visit('/cities/1')
end

Given(/^there is a data about top 3 city$/) do
	visit('/cities/3')
end

When(/^I see an information that is top (\d+) in Brazil$/) do |arg1|
  expect(page).to have_content('IDH')
end

Then(/^I must see a gold medal close to the information$/) do
  expect(page).to have_css("img[src*='/assets/gold_medal.png']")
end

Then(/^I must see a silver medal close to the information$/) do
  expect(page).to have_css("img[src*='/assets/silver_medal.png']")
end

Then(/^I must see a bronze medal close to the information$/) do
  expect(page).to have_css("img[src*='/assets/bronze_medal.png']")
end
