Feature: Top 3

	Seeing the information of a city
	As a user
	I want to see if the city is the top 3 in an attribute
	
	Scenario: user see the city that is top 1 in an attribute
		Given there is a data about top 1 city
		When I see an information that is top 1 in Brazil
		Then I must see a gold medal close to the information

	Scenario: user see the city that is top 2 in an attribute
		Given there is a data about top 2 city
		When I see an information that is top 2 in Brazil
		Then I must see a silver medal close to the information

	Scenario: user see the city that is top 3 in an attribute
		Given there is a data about top 3 city
		When I see an information that is top 3 in Brazil
		Then I must see a bronze medal close to the information
