*** Settings ***
Library	RequestsLibrary
Library	Collections

Variables    ../../resource/config.py

*** Variables ***
&{headers}	${auth_header_key}=${api_key}

*** Test Cases ***
Get Observations
	Given Get Recent Observations
	When Parse Response
	Then Response Code is 200
	    And There are more than Zero observations

*** Keywords ***
Get Recent Observations
	create session	recent_obs_session	${api_base_url}
	${response}	GET On session	recent_obs_session	/v2/data/obs/${region}/recent	headers=${headers}
	Set Suite Variable    ${response}

Parse Response
	${status_code}	Convert To String	${response.status_code}
	${obs_list}	Convert To List	${response.content}
	${obs_list_count}	Get Length	${obs_list}
	Set Suite Variable    ${status_code}
	Set Suite Variable    ${obs_list_count}

Response Code is 200
	Should Be Equal	${status_code}	200

There are more than Zero observations
	Should Be True	${obs_list_count}>0