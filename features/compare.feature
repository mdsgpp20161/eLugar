Feature: Compare Cities

		Scenario: User compare two cities
			Given I am in a page of an city
			When I click in compare
			And I am redirected to a page with the cities
			And I click in one city
			Then I have to see the comparation between the choosen cities
