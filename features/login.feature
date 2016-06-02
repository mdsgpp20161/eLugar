Feature: User wants to sign in
	
	Scenario: Signs in successfully
		Given I am on the root page
		When I press "Login" link
		And I will be redirect to login page
		And I fill in "Email" with "bianquinhaa@hotmail.com"
		And I fill in "Password" with "123456"
		When I press "Log in"
		# And I will be redirect to login page
		Then I should see "Perfil"
	Scenario: Signs in unsuccessfully
		Given I am on the root page
		When I press "Login" link
		And I will be redirect to login page
		And I fill in "Email" with "pedro123@,com"
		And I fill in "Password" with "1234"
		When I press "Log in"
		# And I will be redirect to login page
		Then I should see "Login"