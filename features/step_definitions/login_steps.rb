Given "I am on the $n page" do |arg1|
  visit send("#{arg1}_path")
  # puts "#{arg1}_path"
end

When "I press $n link" do |arg1|
  click_link_or_button(arg1)
end

When(/^I press "([^"]*)"$/) do |arg1|
  click_link_or_button(arg1)
end

When(/^I press "OK" button$/) do
  page.driver.browser.switch_to.alert.accept
end

And "I will be redirect to $n page" do |arg1|
  expect(page).to have_content(arg1)
end

And "I fill in $n with $n" do |arg1,arg2|
  fill_in arg1, :with => arg2
end

Then "I should see $n" do |arg1|
  expect(page).to have_content(arg1)
end

Then "I should be in $n page" do |arg1|
  expect current_path == send("#{arg1}_path")
end