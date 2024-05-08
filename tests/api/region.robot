*** Settings ***
Library	RequestsLibrary
Library  JSONLibrary

Variables    ../../resource/config.py

*** Variables ***
&{headers}	${auth_header_key}=${api_key}

*** Test Cases ***
Region Info

	# Session creation 
	create session	region_info_session	${api_base_url}

	# Get request with auth header
	${response}	GET On session	region_info_session	/v2/ref/region/info/${region}	headers=${headers}

	# Response parsing
	${status_code}	Convert To String	${response.status_code}
	${content}=	To Json	${response.content}
	${result}=	Get Value From Json	${content}	$.result
	${type}=	Get Value From Json	${content}	$.type

	
	# Validation
	Should Be Equal	${status_code}	200
	Should Be Equal	${result[0]}	${validation_result}
	Should Be Equal	${type[0]}	${validation_type}