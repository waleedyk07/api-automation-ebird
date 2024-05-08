*** Settings ***
Library  Collections
Library	SeleniumLibrary
Library	../../libs/utils.py	WITH NAME		UTILS

*** Variables ***
${URL}	https://parabank.parasoft.com/parabank/index.htm

*** Test Cases ***
Chrome - Open Browser
	Open Browser	${URL}	chrome
	Sleep	1s

Goto Register
	Click Element	xpath=//a[text()='Register']

Enter Register Form Data
	# Generate Reandom profile from python lib
	${profile}=	UTILS.generate_profile
	
	${firstName}=	Get From Dictionary	${profile}	firstName
	${lastName}=	Get From Dictionary	${profile}	lastName
	${street}=	Get From Dictionary	${profile}	street
	${city}=	Get From Dictionary	${profile}	city
	${state}=	Get From Dictionary	${profile}	state
	${zipCode}=	Get From Dictionary	${profile}	zipCode
	${phoneNumber}=	Get From Dictionary	${profile}	phoneNumber
	${ssn}=	Get From Dictionary	${profile}	ssn
	${username}=	Get From Dictionary	${profile}	username
	${password}=	Get From Dictionary	${profile}	password

	# Share this variable to test suit to used for login
	Set Global Variable	  ${username}
	Set Global Variable	  ${password} 
	
	# Enter Values to register a profile & Submit
	Input Text	id=customer.firstName	${firstName}
	Input Text	id=customer.lastName	${lastName}
	Input Text	id=customer.address.street	${street}
	Input Text	id=customer.address.city	${city}
	Input Text	id=customer.address.state	${state}
	Input Text	id=customer.address.zipCode	${zipCode}
	Input Text	id=customer.phoneNumber	${phoneNumber}
	Input Text	id=customer.ssn	${ssn}
	Input Text	id=customer.username	${username}
	Input Text	id=customer.password	${password}
	Input Text	id=repeatedPassword	${password}

	Sleep	2s

	# Register
	Click Element	css=input.button[value='Register']

	# Check if user is successfully registered
	${p_text}=	Get Text	xpath=//div[@id='rightPanel']/p
	Should Be Equal	${p_text}	Your account was created successfully. You are now logged in.

Logout the new created user
	Click Element	xpath=//a[text()='Log Out']
	Sleep	2s
	
Open in new tab and Login with Credentials
	# Open New Tab
	Execute JavaScript	window.open('${URL}', '_blank')
	Switch Window	NEW

	# Enter previously credentials & Submit
	Input Text	name=username	${username}
	Input Text	name=password	${password}
	Click Element	css=input.button[value='Log In']

	Sleep	2s

	# Check if user is successfully logged in
	${h1_title}=	Get Text	xpath=//h1[@class='title']
	Should Be Equal	${h1_title}    Accounts Overview
	
	Close Browser