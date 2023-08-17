@Regression
Feature: Create Account

  Background: Setup test and generate token
    * def result = callonce read("GenerateToken.feature")
    * def validToken = result.response.token
    Given url "https://tek-insurance-api.azurewebsites.net"

  Scenario: Create Valid Account
    Given path "/api/accounts/add-primary-account"
    And header Authorization = "Bearer " + validToken
    #Calling Java class in feature file. This utility will create object from Java class.
    * def generateDataObject = Java.type('api.utility.data.GenerateData')
    * def autoEmail = generateDataObject.randomEmail();
    * def autoName = generateDataObject.randomName();
    And request
      """
      {
        "email": "#(autoEmail)",
        "firstName": "#(autoName)",
        "lastName": "#(autoName)",
        "title": "Mr",
        "gender": "MALE",
        "maritalStatus": "MARRIED",
        "employmentStatus": "DevOps",
        "dateOfBirth": "2023-08-08"
        
      }
      """
    When method post
    Then status 201
    And print response
    And assert response.email == autoEmail
