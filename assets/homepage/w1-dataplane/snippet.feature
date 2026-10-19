    Then :user/alice should see 'Enter Verification Code'
    When :user/alice receives an SMS to '+15550001111' matching Reset.smsCode
    And :user/alice fills Login.code with {smsCode}
    And :user/alice clicks Login.submit
    Then :user/alice should see 'Code verified for alice'
