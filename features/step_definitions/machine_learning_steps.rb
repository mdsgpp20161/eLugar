Given(/^I am in a page of an city$/) do
  visit('/cities/0')
end

Then(/^I must see the suggested cities$/) do
  expect(page).to have_content(:partial)
end
