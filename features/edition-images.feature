@design-system-only
Feature: Images tab on edit edition

  Scenario: Accessing the images tab with correct permissions
    Given I am a writer
    And I have the "Preview images update" permission
    And I start drafting a new publication "Standard Beard Lengths"
    When I am on the edit page for publication "Standard Beard Lengths"
    Then I can navigate to the images tab

  Scenario: Images tab is hidden by default
    Given I am a writer
    And I start drafting a new publication "Standard Beard Lengths"
    When I am on the edit page for publication "Standard Beard Lengths"
    Then the page should not have an images tab

  Scenario: Images are listed on the images tab
    Given I am a writer
    And I have the "Preview images update" permission
    And a draft document with images exists
    When I visit the images tab of the the document with images
    Then I should see a list of the images