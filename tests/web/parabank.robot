*** Settings ***
Resource	web-helper.robot

Variables	../../resource/config.py
Library	../../libs/utils.py	WITH NAME	UTILS

*** Test Cases ***
Register a Parabank User
	Given Parabank Page Is Open
		And Register page is Open
	When Register Parabank User
	Then Can See Welcome Page
		And Logout User
	
Signin a Parabank User
	Given Tab Is Open
	When Signin
	Then Can See Account Overview
		And Close Broswer

*** Keywords ***
Parabank Page Is Open
	Open URL    ${web_base_url}    ${browser}

Register Parabank User
	${profile}=	UTILS.generate_profile
	${username}	${password}	Register Profile	${profile}

	# To be used in Signin flow
	Set Suite Variable	${username}
	Set Suite Variable	${password}

Tab Is Open
        Open Tab	${web_base_url}

Signin
        Enter Credentials	${username}	${password}