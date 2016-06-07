Feature: User wants to generate a compare's report

   Scenario: Report successfully generated
	   Given I am on the root page
	   When I press "VER CIDADES" button
	   Then I should see Escolha a cidade que deseja conhecer
	   And I will press first city
	   And I press "Compare" button
	   And I will press first city
	   When I press "Relatório de Comparação" button
	   Then I should see Relatório de Comparação
