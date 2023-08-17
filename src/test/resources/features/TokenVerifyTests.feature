@Smoke
Feature: Token Verify Test

Background: Setup Test URL
Given url "https://tek-insurance-api.azurewebsites.net"
* def result = callonce read('GenerateToken.feature')
And print result
* def validToken = result.response.token
Scenario: Verify Valid Token

Given path "/api/token/verify"
And param token = validToken
And param username = "supervisor"
When method get
Then status 200
And print response
And assert response == "true"

Scenario: Validate token with invalid username
Given path "/api/token/verify"
And param token = validToken
And param username = "wronguser"
When method get
Then status 400
And print response
And assert response.errorMessage == "Wrong Username send along with Token"

Scenario: Invalid token and valid username

Given path "/api/token/verify"
And param token = "Invalid_token"
And param username = "supervisor"
When method get
Then status 400
And print response
And assert response.errorMessage == "Token Expired or Invalid Token"

Scenario: Valid existing primaryId and Validate response
Given path "/api/accounts/get-account"
And header Authorization = "Bearer " + validToken
#with def step create variable and assign value for reusability
* def existingId = 9523
And param primaryPersonId = existingId
When method get 
Then status 200
And print response
And assert response.primaryPerson.id == existingId

Scenario: Validate a primaryPersonId that is not exist
Given path "/api/accounts/get-account"
And header Authorization = "Bearer " + validToken
And param primaryPersonId = 999955
When method get
Then status 404
And print response
And assert response.errorMessage == "Account with id 999955 not found"

Scenario: Plan Code
Then path "/api/plans/get-all-plan-code"
And header Authorization = "Bearer " + validToken
And method get
And status 200
Then print response






