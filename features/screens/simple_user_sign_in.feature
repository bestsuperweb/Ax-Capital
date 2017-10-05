Feature: sign_in as normal user

Scenario: Sign in form works
  Given I am on signin page
  Then I should see Log in
    And I should see Email
    And I should see Password
    And I should see Sign up
    And I should see Forgot your password?