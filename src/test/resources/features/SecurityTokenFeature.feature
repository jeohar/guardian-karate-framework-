@Smoke
Feature: Security Token Tests
Scenario: Generate valid token with valid username and password
#Prepare request
Given url "https://tek-insurance-api.azurewebsites.net"
And path "/api/token"
And request { "username": "supervisor","password": "tek_supervisor"}
When method post
Then status 200
And print response

Scenario: Validate token with invalid username
Given url "https://tek-insurance-api.azurewebsites.net"
And path "/api/token"
And request { "username": "supervisor1","password": "tek_supervisor"}
When method post
Then status 400
And print response
And assert response.errorMessage == "User not found"

Scenario: Validate token with invalid password
Given url "https://tek-insurance-api.azurewebsites.net"
And path "api/token"
And request { "username": "supervisor","password": "tek_supervisor1"}
When method post
Then status 400
And print response
And assert response.errorMessage == "Password Not Matched"

