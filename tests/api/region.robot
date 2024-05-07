*** Settings ***
Library	RequestsLibrary
Library	Collections

*** Variables ***
# Config variables
${base_url}	https://api.ebird.org
${auth_header_key}	x-ebirdapitoken
${api_key}	lk264dq7b9e9

${region}	PK
&{headers}	${auth_header_key}=${api_key}

*** Test Cases ***
Region Info

	# Session creation 
	create session	region_info_session	${base_url}

	# Get request with auth header
	${response}	GET On session	region_info_session	/v2/data/obs/${region}/recent	headers=${headers}

	# Response parsing
	${status_code}	Convert To String	${response.status_code}
	${region_list}	Convert To List	${response.content}
	${region_list_count}	Get Length	${region_list}
	
	# Validation
	Should Be Equal	${status_code}	200
	Should Be True	${region_list_count}>0