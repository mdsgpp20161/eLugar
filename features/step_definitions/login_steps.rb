# Given (/^I am on the main page$/) do
# 	visit root_path
# end
When (/^I press "Login" link$/) do
	click_link("Login")
end
And (/^I will be redirect to login page$/) do
	expect(page).to have_content("Login")
end
# And (/^I fill in "Email" with "pedro@gmail.com"$/) do
# 	fill_in 'Email', :with => 'pedro@gmail.com'
# end
# And (/^I fill in "Password" with "123456"$/) do
# 	fill_in 'Password', :with => '123456'
# end
And (/^I fill in "Email" with "pedro123@,com"$/) do
	fill_in 'Email', :with => 'pedro123@,com'
end
And (/^I fill in "Password" with "1234"$/) do
	fill_in 'Password', :with => '1234'
end
When (/^I press "Log in"$/) do
	click_button("Log in")
end
Then (/^I should see "Perfil"$/) do
	expect(page).to have_content("Perfil")
end
Then (/^I should see "Login não foi efetuado com sucesso."$/) do
	expect(page).to have_content("Login")
end