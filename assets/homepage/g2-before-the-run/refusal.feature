Feature: Login

  @because=CHK-4412
  Scenario: Alice logs in
    When :user/alicce opens the browser to 'http://127.0.0.1:9095/login'
    And :user/alice fills {:id "username"} with 'alice'
    And :user/alice clcks {:css "button[type='submit']"}
    Then :user/alice should see 'Welcome, alice!'
