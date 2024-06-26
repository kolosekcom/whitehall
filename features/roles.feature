Feature: Administering Roles
  This feature allows the administration of the various different roles in the system

  Background:
    Given I am an admin
    And the editionable worldwide organisation feature flag is disabled

  Scenario: Adding a traffic commissioner role
    Given the organisation "Department for Transport" exists
    And a person called "Terence Traffic"
    When I add a new "Traffic commissioner" role named "Traffic Commissioner for Scotland" to the "Department for Transport"
    Then I should be able to appoint "Terence Traffic" to the new role

  Scenario: Adding a chief scientist
    Given the organisation "Foreign Office" exists
    And a person called "Susan Scientist"
    When I add a new "Chief scientific advisor" role named "Chief Scientific Advisor to the FCO" to the "Foreign Office"
    Then I should be able to appoint "Susan Scientist" to the new role

  Scenario: Adding a new role with the editionable worldwide organisation feature flag enabled
    Given the organisation "Foreign Office" exists
    And a person called "Susan Scientist"
    And the editionable worldwide organisation feature flag is enabled
    Then I should not see the woldwide organisation input field
    When I add a new "Chief scientific advisor" role named "Chief Scientific Advisor to the FCO" to the "Foreign Office"
    Then I should be able to appoint "Susan Scientist" to the new role

  Scenario: Adding a primary role to a worldwide organisation
    Given the worldwide organisation "British embassy in Spain" exists
    And a person called "Giles Paxman"
    When I add a new "Ambassador" role named "Her Majesty's Ambassador to Spain" to the "British embassy in Spain" worldwide organisation
    Then I should be able to appoint "Giles Paxman" to the new role

  Scenario: Adding a deputy role to a worldwide organisation
    Given the worldwide organisation "British embassy in Spain" exists
    And a person called "Andrew Tomkins"
    When I add a new "Deputy head of mission" role named "Deputy Head of Mission" to the "British embassy in Spain" worldwide organisation
    Then I should be able to appoint "Andrew Tomkins" to the new role

  Scenario: Adding a new translation
    Given the worldwide organisation "British embassy in Spain" exists
    And an ambassador role named "Her Majesty's Ambassador to Spain" in the "British embassy in Spain" worldwide organisation
    And a person called "Giles Paxman" appointed as "Her Majesty's Ambassador to Spain" with a biography in "Español"
    When I add a new "Español" translation to the role "Her Majesty's Ambassador to Spain" with:
      | name             | Su Majestad Embajador en España           |
      | responsibilities | Retrato del Reino Unido en una buena luz. |
    Then I should see the role translation "Español (Spanish)" with:
      | name             | Su Majestad Embajador en España           |
      | responsibilities | Retrato del Reino Unido en una buena luz. |
