  Feature: User wants to generate a compare's report

#	Scenario: Report not successfully generated when not logged in
#		Given I am

	Scenario: Report successfully generated
		Given I am on the root page
		When I press "Ver cidades" button
		And I will be redirect to find page
		And I will press cities/25 link
		And I will be redirect to cities/25 page
		And I will press Compare button
		And I will be redirected to compare?id=25 page
		And I will press compare?id=25&newID=11 link
		And I will be redirected to compare?id=25&newID=11 page
		When I press "Relatorio de Comparação" button

		Then I should be redirected articles.pdf?city1=25&city2=11 page
		# Then the user page is loaded with notice message "Relatório de Comparação"




    # Scenario: Signs in successfully and signs out successfully
    #		Given I am on the root page
    #    And I will be redirect to Login page
    #		When I press Login link
    #		And I fill in Email with bianquinhaa@hotmail.com
    #		And I fill in Password with 123456
    #		When I press "Log in"
    #		Then I should see Perfil
    #		When I press "Log out"
    #		Then I should see Login
    #	Scenario: Signs in successfully and deletes account sccessfully
    #		Given I am on the root page
    #		When I press Login link
    #		And I will be redirect to Login page
    #		And I fill in Email with bianquinhaa@hotmail.com
    #		And I fill in Password with 123456
    #		When I press "Log in"
    #		Then I should see Perfil
    #		When I press "Deletar conta"
    #		# Then I should see Você tem certeza?
    #		When I press "OK" button
    #		Then I should be in root page

    #	Scenario: Signs in unsuccessfully
    #		Given I am on the root page
    #		When I press Login link
    #		And I will be redirect to Login page
    #		And I fill in Email with pedro123@,com
    #		And I fill in Password with 1234
    #		When I press "Log in"
    #		Then I should see Login
