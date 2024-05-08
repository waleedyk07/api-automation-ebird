*** Settings ***
Library	RequestsLibrary
Library	Collections

Variables    ../../resource/config.py

*** Variables ***
&{headers}	${auth_header_key}=${api_key}

*** Test Cases ***
Region Info

	# Session creation 
	create session	recent_obs_session	${api_base_url}

	# Get request with auth header
	${response}	GET On session	recent_obs_session	/v2/data/obs/${region}/recent	headers=${headers}

	# Response parsing
	${status_code}	Convert To String	${response.status_code}
	${obs_list}	Convert To List	${response.content}
	${obs_list_count}	Get Length	${obs_list}
	
	# Validation
	Should Be Equal	${status_code}	200
	Should Be True	${obs_list_count}>0