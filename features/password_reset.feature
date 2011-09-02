Feature: Manager password reset for wholesalers
  In order to sign in even if user forgot their password
  A user
  Should be able to reset it

  Scenario: Successful reset
    Given a user "wholesaler@domain.com" for the wholesaler "Joe's Wholesaler"
    And I am signed in as the VFI project manager
    When I go to the wholesaler page for "Joe's Wholesaler"
    And I follow "Edit"
    And I follow "Edit the user account for this wholesaler"
    And I fill in "Password" with "newpassword"
    And I fill in "Confirm password" with "newpassword"
    And I press "Update user"
    Then I should see "wholesaler@domain.com's password changed successfully"
    And the password for "wholesaler@domain.com" should be "newpassword"

  Scenario: Bad password confirmation
    Given a user "wholesaler@domain.com" for the wholesaler "Joe's Wholesaler"
    And I am signed in as the VFI project manager
    When I go to the password change page for the wholesaler "Joe's Wholesaler"
    And I fill in "Password" with "newpassword"
    But I fill in "Confirm password" with "whoops"
    And I press "Update user"
    Then I should see "Password doesn't match confirmation"

  Scenario: Empty email
    Given a user "wholesaler@domain.com" for the wholesaler "Joe's Wholesaler"
    And I am signed in as the VFI project manager
    When I go to the password change page for the wholesaler "Joe's Wholesaler"
    And I fill in "Email" with ""
    And I fill in "Password" with "newpassword"
    And I fill in "Confirm password" with "newpassword"
    And I press "Update user"
    Then I should see "Email can't be blank"

  @backlog
  Scenario: Empty password
    Given a user "wholesaler@domain.com" for the wholesaler "Joe's Wholesaler"
    And I am signed in as the VFI project manager
    When I go to the password change page for the wholesaler "Joe's Wholesaler"
    And I fill in "Password" with ""
    And I fill in "Confirm password" with ""
    And I press "Update user"
    Then I should see "Password can't be blank"
