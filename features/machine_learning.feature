Feature: Machine Learning

	In order to see similar cities
	As a user
	I want to see one of suggested cities by the system

	Scenario: user see suggested cities
		Given I am in a page of an city
		When I see the suggested cities
		Then I must click in one suggested city
