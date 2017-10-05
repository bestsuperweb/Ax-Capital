Feature: Check the menus in navbar

Scenario: Menu entries for signed in user
  Given I am logged in
    And I am on root page
  Then I should see Contacts
  When I follow Contacts
  Then I should see Office Location
    And I should see Map
    And I should see Select Department
    And I should see Subject
    And I should see Message
    And I should see Privacy Policy 
  When I follow Privacy Policy
  Then I should see Privacy Policy
    And I should see Risk Disclosure
  When I follow Risk Disclosure
  Then I should see Risk Disclosure
    And I should see Preventing Money Laundering
  When I follow Preventing Money Laundering
  Then I should see Preventing Money Laundering
    And I should see Security Instructions
  When I follow Security Instructions
  Then I should see Security Instructions
    And I should see Terms and Conditions
  When I follow Terms and Conditions
  Then I should see Terms and Conditions