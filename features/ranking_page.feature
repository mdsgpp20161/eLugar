Feature: Ranking Page

	In order to see other ranking
	As a user
	I want to see ranking by an attribute
	Scenario: user sees ranking by population
		Given there is a option to choose attribute to show ranking
		When I choose an option
		And Click to show the ranking
		Then I must see the ranking table
