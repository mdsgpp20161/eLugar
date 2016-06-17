Given(/^I am in a page of an city$/) do
  visit('/cities/0')
end

When(/^I see the suggested cities$/) do
  expect(page).to have_content(:partial)
end

Then(/^I must click in one suggested city$/) do
  click_on('suggestion1')
end
