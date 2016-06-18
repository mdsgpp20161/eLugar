Feature: User wants to generate a compare's report


Scenario: Report successfully generated
	Given I am on the root page
	When I press "Ver Cidades"
	Then I should see Escolha a cidade que deseja conhecer
	And I will press first city
	When I press "Compare"
	And I will press first city
	When I press "Relatório de Comparação"
	Then I see pdf
