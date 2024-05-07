*** Settings ***
Library	SeleniumLibrary

*** Variables ***
${URL}	https://parabank.parasoft.com/parabank/index.htm

*** Test Cases ***
Chrome - Open Browser
#########################################################################################################################
#	 ${chromeOptions}=	Evaluate	sys.modules['selenium.webdriver'].ChromeOptions()	sys, selenium.webdriver

#	 Call Method	${chromeOptions}	add_argument	--headless
#	 Call Method	${chromeOptions}	add_argument	--disable-gpu

#	 Open Browser  ${URL}  chrome  options=${chromeOptions}
#########################################################################################################################
	Open Browser  ${URL}  chrome

Goto Register
	Click Element	xpath=//a[text()='Register']	

Enter Register Form Data
	
	Input Text	id=customer.firstName	John
	Input Text	id=customer.lastName	Doe
	Input Text	id=customer.address.street	123 Main St
	Input Text	id=customer.address.city	Anytown
	Input Text	id=customer.address.state	CA
	Input Text	id=customer.address.zipCode	12345
	Input Text	id=customer.phoneNumber	123-456-7890
	Input Text	id=customer.ssn	123-45-6789
	Input Text	id=customer.username	johndoe
	Input Text	id=customer.password	password123
	Input Text	id=repeatedPassword	password123

	Sleep    5s
	Click Element    css=input.button[value='Register']
	Sleep    5s
	
	Close Browser