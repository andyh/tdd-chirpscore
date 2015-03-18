Feature: I want to know what my chirpscore is

  Scenario: Happy Path!
    When I specify "@limeblast"
    Then I will see 1.14

    When I specify "limeblast"
    Then I will see 1.14

  Scenario: Sad Path :(
    When I specify "limeb last"
    Then I will see the error message "invalid handle"

    When I specify "elptics"
    Then I will see the error message "handle does not exist"
