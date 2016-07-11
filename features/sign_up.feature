Feature: Viewer wants to sign up
    Scenario: Signs up successfully
        Given I am on the root page
        When I press Cadastro link
        And I will be redirect to Cadastro page
        And I fill in Nome with biancaa
        And I fill in Email with bianquinhaa@hotmail.com
        And I fill in Password with 123456
        And I fill in Confirmation with 123456
        When I press "Create my account"
        Then I should see Login
    Scenario: Signs up unsuccessfully
        Given I am on the root page
        When I press Cadastro link
        And I will be redirect to Cadastro page
        And I fill in Nome with Harrison
        And I fill in Email with harrison@gmail.com
        And I fill in Password with 123456
        And I fill in Confirmation with 12345
        When I press "Create my account"
        Then I should see Cadastro inválido