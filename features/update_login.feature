Feature: User wants to update account
	
	Scenario: Signs in successfully and update account successfully
		Given I am on the root page
		When I press Login link
		And I will be redirect to Login page
		And I fill in Email with bianquinhaa@hotmail.com
		And I fill in Password with 123456
		When I press "Log in"
		Then I should see Perfil
		When I press "Atualizar Perfil"
		Then I should see Atualize seu Perfil
		And I fill in Nome with Teste
		And I fill in Email with valid@hotmail.com
		And I fill in Senha with 123456
		And I fill in Confirmação with 123456
		Then I should see Perfil