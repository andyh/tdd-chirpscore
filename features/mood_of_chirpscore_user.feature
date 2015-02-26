Feature: I want more information about the mood of another user

  Scenario: A happy user
    When I ask for more information about "@ngoodall"
    Then I will see "ngoodall is an ecstatic tweeter with a score of 5.28"

  Scenario: A sad user
    When I ask for more information about "@skynews"
    Then I will see "skynews is an irritated tweeter with a score of -1.43"
