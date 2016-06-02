Given (/^I am on the root page$/) do
	visit root_path
end
When (/^I press "Cadastro" link$/) do
	click_link("Cadastro")
end
And (/^I will be redirect to signup page$/) do
	expect(page).to have_content("Cadastro")
end
And (/^I fill in "Nome" with "biancaa"$/) do
	fill_in 'Nome', :with => 'biancaa'
end
And (/^I fill in "Nome" with "Harrison"$/) do
	fill_in 'Nome', :with => 'Harrison'
end
And (/^I fill in "Email" with "bianquinhaa@hotmail.com"$/) do
	fill_in 'Email', :with => 'bianquinhaa@hotmail.com'
end
And (/^I fill in "Email" with "harrison@gmail.com"$/) do
	fill_in 'Email', :with => 'harrison@gmail.com'
end
And (/^I fill in "Password" with "123456"$/) do
	fill_in 'Password', :with => '123456'
end
And (/^I fill in "Confirmation" with "123456"$/) do
	fill_in 'Confirmation', :with => '123456'
end
When (/^I press "Create my account" button$/) do
	click_button("Create my account")
end
Then(/^I should see "Login"$/) do
	expect(page).to have_content("Login")
end
Then(/^I should see "Cadastro inválido"$/) do
	expect(page).to have_content("Cadastro inválido")
end