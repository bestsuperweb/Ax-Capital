Feature: Edit Profile as logged in user

Scenario: Edit profile page shows with fields
  Given I am logged in
    And I am on edit profile page
  Then I should see Edit User Profile
    And I should see Profile completeness
    And I should see General Information
    And I should see Address Information
    And I should see Security Information
    And I should see Default Information
    And I should see First name
    And I should see Last name
    And I should see Date of birth
    And I should see I am a united kingdom resident
    And I should see Current password
    And I should see Back
  When I follow Address Information
  Then I should see Address
    And I should see City
    And I should see State
    And I should see Zip
  When I follow Security Information
  Then I should see Send security token to email
    And I should see Send security token to mobile
    And I should see Password
    And I should see Password confirmation
  When I follow Plan Information
  When I follow Default Information
  Then I should see Mobile
    And I should see Email
