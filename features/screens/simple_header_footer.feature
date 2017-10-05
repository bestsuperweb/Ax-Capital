Feature: Check the menus in navbar

Scenario: Menu entries for signed in user
  Given I am logged in
    And I am on root page
  Then I should see Home
    And I should see Withdraw
    And I should see Deposit
    And I should see Account History
    And I should see Settings
    And I should see Privacy Policy
    And I should see Risk Disclosure
    And I should see Preventing Money Laundering
    And I should see Contacts
    And I should see Security Instructions
    And I should see Terms and Conditions
