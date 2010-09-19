Feature: Logging in
  In order to access the system
  As a user
  I want to login to the system

  @1 @shouldwork @happy_case
  Scenario: Sign up and log into the system
    Given I am on the signup page
    When I fill in "Email" with "billy@example.com"
    And I fill in "Password" with "secret"
    And I fill in "Password confirmation" with "secret"
    And I press "Submit"
#     Then I should see "signup successful"
    When I view the login page
    And I fill in "Email" with "billy@example.com"
    And I fill in "Password" with "secret"
    And I press "Submit"
    And I should see "Login successful!"
