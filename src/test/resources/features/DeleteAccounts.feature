@Re@Regression
Feature: Delete Accunt Feature

  Background: Setup test and create new account
    #we need to use twice callonce (to create account and genrate data)
    #* def result = callonce read('GenerateToken.feature')
    * def createdAccount = callonce read("CreateAccount.feature")
    * def validToken = createdAccount.validToken
    * def createdAccountId = createdAccount.response.id
    #And print createAccount
    Given url "https://tek-insurance-api.azurewebsites.net"

  Scenario: Successfull delete accoount
    Given path "api/accounts/delete-account"
    And param primaryPersonId = createdAccountId
    And header Authorization = "Bearer " + validToken
    When method delete
    Then status 200
    And print response
    And assert response == "Account Successfully deleted"
    Given path "api/accounts/delete-account"
    And param primaryPersonId = createdAccountId
    And header Authorization = "Bearer " + validToken
    When method delete
    Then status 404
    And print response
    And assert response.errorMessage == "Account with id " + createdAccountId + " not exist"
