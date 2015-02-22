Feature: I want more information about the mood of another user

  Scenario: A happy user
    When I ask for more information about "@ngoodall"
    Then I will see "ngoodall is an ecstatic tweeter with a score of 5.28"
