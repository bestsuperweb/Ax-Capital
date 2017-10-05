Feature: Withdraw process

Scenario: Withdraw process for signed in user
  Given I am logged in
    And I am on root page
  Then I should see Withdraw
  When I follow Withdraw
  Then I should see Withdraw Funds
  When I follow Withdraw Funds
  Then I should see XM Account ID
    And I should see XM Account Name
    And I should see Full name
    And I should see Address
    And I should see Account
    And I should see Terms & Conditions
    And I should see Accept terms and conditions
    And I should see Enter the amount you want to withdraw from your account
    And I should see Additional notes
  When I follow Withdraw
    And I follow Withdraw History
  Then I should see Withdrawal List
    And I should see Created Date
    And I should see Amount
    And I should see Status
    And I should see Previous Balance
    And I should see New Balance
