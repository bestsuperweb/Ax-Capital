Feature: sign_up as simple user

Scenario: Sign up page works
  Given I am on signup page
  Then I should see Sign up
    And I should see Terms of Service
    And I should see Mobile
    And I should see Email
    And I should see Password
    And I should see Password confirmation
    And I should see Accept terms of service
    And I should see Log in
