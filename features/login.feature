Feature: User wants to sign in
	
	Scenario: Signs in successfully and signs out successfully
		Given I am on the root page
    	When I press Cadastro link
    	And I will be redirect to Cadastro page
    	And I fill in Nome with biancaa
    	And I fill in Email with bianquinhaa@hotmail.com
    	And I fill in Password with 123456
    	And I fill in Confirmation with 123456
    	When I press "Create my account"
    	Then I should see Login
		When I press Login link
		And I will be redirect to Login page
		And I fill in Email with bianquinhaa@hotmail.com
		And I fill in Password with 123456
		When I press "Log in"
		Then I should see Perfil
		When I press "Log out"
		Then I should see Login
	Scenario: Signs in successfully and deletes account sccessfully
		Scenario: Setup preferences successfully
		Given I am on the root page
    	When I press Cadastro link
    	And I will be redirect to Cadastro page
    	And I fill in Nome with biancaa
    	And I fill in Email with bianquinhaa@hotmail.com
    	And I fill in Password with 123456
    	And I fill in Confirmation with 123456
    	When I press "Create my account"
    	Then I should see Login
		When I press Login link
		And I will be redirect to Login page
		And I fill in Email with bianquinhaa@hotmail.com
		And I fill in Password with 123456
		When I press "Log in"
		Then I should see Perfil
		When I press "Deletar conta"
		# Then I should see Você tem certeza?
		When I press "OK" button
		Then I should be in root page

	Scenario: Signs in unsuccessfully
		Given I am on the root page
		When I press Login link
		And I will be redirect to Login page
		And I fill in Email with pedro123@,com
		And I fill in Password with 1234
		When I press "Log in"
		Then I should see Login
