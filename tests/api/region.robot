*** Settings ***
Library	RequestsLibrary
Library  JSONLibrary

Variables    ../../resource/config.py

*** Variables ***
&{headers}	${auth_header_key}=${api_key}

*** Test Cases ***
Region Info
	Given Get Region Info
	When Parse Response
	Then Response Code is 200
	    And Region is Pakistan

*** Keywords ***
Get Region Info
	create session	region_info_session	${api_base_url}

	# Get request with auth header
	${response}	GET On session	region_info_session	/v2/ref/region/info/${region}	headers=${headers}
	Set Suite Variable    ${response}
Parse Response
	${status_code}	Convert To String	${response.status_code}
	${content}=	To Json	${response.content}
	${result}=	Get Value From Json	${content}	$.result
	${type}=	Get Value From Json	${content}	$.type
	Set Suite Variable    ${status_code}
	Set Suite Variable    ${content}
	Set Suite Variable    ${result}
	Set Suite Variable    ${type}

Response Code is 200
	Should Be Equal	${status_code}	200

Region is Pakistan
	Should Be Equal	${result[0]}	${validation_result}
	Should Be Equal	${type[0]}	${validation_type}