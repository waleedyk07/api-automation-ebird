*** Settings ***
Resource    web-helper.robot

*** Test Cases ***
Register a Parabank User
        Given Parabank Page Is Open
            And Register page is Open
        When Register Parabank User
        Then Can See Welcome Page
            And Logout User
	
Signin a Parabank User
        Given Tab Is Open
        When Enter Credentials
        Then Can See Account Overview
            And Close Broswer