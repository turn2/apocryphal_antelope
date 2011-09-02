Feature: Creating and updating FAQs
  In order to quickly inform the public about the promotion
  As a VFI project manager
  I need to be able to add and edit frequently asked questions

  Background:
    Given I am signed in as the VFI project manager

  Scenario: Input new question
    Given I go to the new faq page
    When I enter a new question and answer
    Then I should see the new question and answer
    But it should not be visible on the public page

  Scenario: Approve question/answer
    Given a frequently asked question has been created
    And I go to the manage faqs page
    When I mark the question Approved
    Then it should be visible on the public page

  Scenario: Hide question/answer
    Given a frequently asked question has been created
    And it is approved
    And I go to the manage faqs page
    When I mark the question Hidden
    Then it should not be visible on the public page
  
  Scenario: Edit question/answer
    Given a frequently asked question has been created
    And I go to the manage faqs page
    When I follow "Edit"
    And I change the answer
    Then the question should be updated    

  @js
  Scenario: Reordering FAQs
    Given 2 frequently asked questions have been created
    And I go to the manage faqs page
    When I drag the second question above the first question
    Then the questions should be reordered

  Scenario: Autolinking URLs
    Given a frequently asked question has been created
    And the faq answer contains "http://www.google.com"
    And it is approved
    When I go to the public faq page
    Then I should see an external link to "http://www.google.com"
