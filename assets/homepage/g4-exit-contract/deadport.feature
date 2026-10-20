Feature: Dead port

  Scenario: The app is not listening
    When :user/reader opens the browser to 'http://127.0.0.1:9999/'
    Then :user/reader should see 'Welcome'
