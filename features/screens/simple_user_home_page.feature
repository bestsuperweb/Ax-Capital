Feature: Home page as logged in user

Scenario: Home page shows up for signed in user
  Given I am logged in
    And I am on root page
  Then I should see Welcome
    # And I should see Avatar
    And I should see Profile Completeness
    And I should see Email Verification
    And I should see Mobile Verification
    And I should see Email
    And I should see Mobile
    And I should see Address
    And I should see Account Information
    And I should see Account Type
    And I should see Account Number
    And I should see Financials
    And I should see Account Balance
    And I should see Base Currency
