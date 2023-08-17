Feature: Generate Token

Scenario: Generate a valid token for tests

Scenario: Get Account API Call with existing account
	Given url "https://tek-insurance-api.azurewebsites.net"
	Given path "/api/token"
	And request { "username": "supervisor","password": "tek_supervisor"}
	When method post
	Then status 200
	And print response
	