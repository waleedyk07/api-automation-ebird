*** Settings ***
Library  Collections
Library	SeleniumLibrary
Library	../../libs/utils.py	WITH NAME		UTILS

Variables    ../../resource/config.py

*** Keywords ***
Parabank Page Is Open
	Open Browser	${web_base_url}	${browser}
	Sleep	1s

Register Parabank User
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

	Click Element	css=input.button[value='Register']
Register page is Open
        Click Element	xpath=//a[text()='Register']
Can See Welcome Page
	# Check if user is successfully registered
	${p_text}=	Get Text	xpath=//div[@id='rightPanel']/p
	Should Be Equal	${p_text}	${validation_register_content}

Logout User
	Click Element	xpath=//a[text()='Log Out']
	Sleep	2s

Tab Is Open
	Execute JavaScript	window.open('${web_base_url}', '_blank')
	Switch Window	NEW
Enter Credentials
	Input Text	name=username	${username}
	Input Text	name=password	${password}
	Click Element	css=input.button[value='Log In']

	Sleep	2s
Can See Account Overview
	${h1_title}=	Get Text	xpath=//h1[@class='title']
	Should Be Equal	${h1_title}    ${validation_login_content}

Close Broswer
	Close Browser