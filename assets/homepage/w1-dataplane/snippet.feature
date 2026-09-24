    Then :user/alice should see 'Enter Verification Code'
    When [:sms] :user/alice receives an SMS to '+15550001111' matching /verification code is: (?<code>\d{6})/
    And :user/alice fills Login.code with {code}
    And :user/alice clicks Login.submit
    Then :user/alice should see 'Code verified for alice'
