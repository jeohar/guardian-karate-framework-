Feature: End to End Testing

Background: Preparing End to End Testing

	* def result = callonce read('GenerateToken.feature')
	* def validToken = result.response.token
	Given url "https://tek-insurance-api.azurewebsites.net"
	
	Scenario: Create New Account
	Given path "/api/accounts/add-primary-account"
	And header Authorization = "Bearer " + validToken
	
	* def generateDataObject = Java.type('api.utility.data.GenerateData')
	* def autoEmail = generateDataObject.randomEmail()
	* def autoName = generateDataObject.randomName()
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
	And assert response.firstName == autoName
	And assert response.email == autoEmail
	
	#Scenario: Add Phone Number to the Created Account
	Given path "/api/accounts/add-account-phone"
	And header Authorization = "Bearer " + validToken
		And param primaryPersonId = response.id
		* def generateDataObject1 = Java.type('api.utility.data.GenerateData')
	* def autoPhoneNumber = generateDataObject1.getPhoneNumber()
		And request
		"""
		{
  "phoneNumber": "#(autoPhoneNumber)",
  "phoneExtension": "22",
  "phoneTime": "Morning",
  "phoneType": "Mobile"
	}
		"""
		When method post
		Then status 201
		And print response
		And assert response.phoneNumber == autoPhoneNumber
		
		#Scenario: Add Address to the created account
		
		Given path "/api/accounts/add-account-address"
		And header Authorization = "Bearer " + validToken
		And param primaryPersonId = response.id
		* def autoAddress = generateDataObject1.getAddress()
		And request
		"""
		{
  "addressType": "Home Address",
  "addressLine1": "#(autoAddress)",
  "city": "Tarzana",
  "state": "California",
  "postalCode": "91335",
  "countryCode": "818",
  "current": true
}
		"""
		When method post
		Then status 201
		And print response
		And assert response.addressLine1 == autoAddress
		
		#Scenario: Add car to the created account
		
		Given path "/api/accounts/add-account-car"
		And header Authorization = "Bearer " + validToken
		And param primaryPersonId = response.id
		* def autoNumberPlate = generateDataObject1.getCarLicensePlate()
		And request
		"""
		
   		{
  	"id": 0,
  	"make": "Tesla",
  	"model": "SUV",
  	"year": "2024",
  	"licensePlate": "#(autoNumberPlate)"
		}

		"""
		When method post
		Then status 201
		And print response
		And assert response.licensePlate == autoNumberPlate
		
		#Scenario: Delete created account
		
		Given path "/api/accounts/delete-account"
		And header Authorization = "Bearer " + validToken
		And param primaryPersonId = response.id
		When method delete
		Then status 200
		And print response
		And assert response == "Account Successfully deleted"
	