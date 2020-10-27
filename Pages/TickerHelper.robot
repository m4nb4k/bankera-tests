*** Settings ***
Library     Selenium2Library
Library     String
Library     DateTime
Resource    ../TestCases/TestData.robot

*** Keywords ***
Send request
    [Arguments]         ${FIRST_CURRENCY}   ${SECOND_CURRENCY}
    Create Session      Get_tick        ${BASE_URL}
    ${before}=          Get Current Date    result_format=epoch
    ${reponse}=         Get Request     Get_tick    ${FIRST_CURRENCY}/${SECOND_CURRENCY}
    ${after}=           Get Current Date    result_format=epoch
    ${response_time}=   Evaluate    ${after} - ${before}
    Should be True      ${response_time} < 2
    Set Global Variable     ${before}
    [Return]            ${reponse}

Check response structure
    [Arguments]         ${reponse}
    ${dictionary}=      Set variable    ${reponse.json()}
    ${keys}=            Get Dictionary Keys         ${dictionary}
    ${length}=          Get Length      ${keys}
    ${count}=           Convert to string   ${length}
    Should be equal     ${count}   8
    Dictionary Should Contain Key   ${dictionary}   currencyFrom
    Dictionary Should Contain Key   ${dictionary}   currencyFromScale
    Dictionary Should Contain Key   ${dictionary}   currencyTo
    Dictionary Should Contain Key   ${dictionary}   currencyToScale
    Dictionary Should Contain Key   ${dictionary}   last
    Dictionary Should Contain Key   ${dictionary}   lastHP
    Dictionary Should Contain Key   ${dictionary}   timestamp
    Dictionary Should Contain Key   ${dictionary}   friendlyLast

Check response body
    [Arguments]         ${reponse}
    ${dictionary}=      Set variable    ${reponse.json()}
    Dictionary Should Contain Item   ${dictionary}   currencyFrom   ${FIRST_CURRENCY}
    Dictionary Should Contain Item   ${dictionary}   currencyTo     ${SECOND_CURRENCY}
    ${key}=      Get From Dictionary     ${dictionary}   timestamp
    Should be True      ${key} > ${before}

Check response headers
    [Arguments]         ${reponse}
    ${contentType}=     Get from dictionary    ${reponse.headers}   Content-Type
    Should be equal     ${contentType}   application/json

Check status code
    [Arguments]             ${reponse}
    ${statusCode}=          Convert to string           ${reponse.status_code}
    Should be equal         ${statusCode}               200
