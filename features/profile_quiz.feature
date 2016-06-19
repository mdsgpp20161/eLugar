
Feature: User wants to setup his preferences
	Scenario: Setup preferences successfully
	Given I am on the root page
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
	When I answer uber_1
	When I answer demographic_density_1
	When I answer area_1
	When I answer population_1
	When I press "Confirmar"
	Then I should see Perfil
