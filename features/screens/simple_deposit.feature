Feature: Deposit process

Scenario: Deposit process for signed in user
  Given I am logged in
    And I am on root page
  Then I should see Deposit
  When I follow Deposit
  Then I should see Deposit Funds
  When I follow Deposit Funds
  Then I should see Deposit Funds - Bank Wire Transfers
    And I should see For GBP Accounts
    And I should see Enter the amount you have transferred to your account:
    And I should see Additional notes
    # And I fill 100 in amount field
  When I follow Deposit
    And I follow Deposit History
  Then I should see Deposit List
    And I should see Created Date
    And I should see Amount
    And I should see Status
    And I should see Previous Balance
    And I should see New Balance
