*** Settings ***
Library     Selenium2Library
Library     String
Resource    ../TestCases/TestData.robot

*** Variables ***
${CURRENCY_SEARCH_BOX}         xpath: //input[contains(@id, 'react-select-2-input')]
${SEARCH_RESULTS_LIST}         xpath: //div[contains(@class, ' css-m038ox-menu')]
${CURRENCY_TABLE}              xpath: //table[contains(@class, 'xp')]
${COOKIE_ACCEPT}               xpath: //button[text()='Accept']

*** Keywords ***
Enter referrence currency
    [Arguments]         ${CURRENCY}
    Enter text          ${CURRENCY_SEARCH_BOX}      Bitcoin
    Click on element    ${SEARCH_RESULTS_LIST}

Currency change was positive
    [Arguments]         ${CURRENCY}
    ${value}=   Get currency change rate    ${CURRENCY}
    Should Be True    ${value} > 0

Get currency change rate
    [Arguments]         ${CURRENCY}
    ${cell}=            Get Table Cell  ${CURRENCY_TABLE}  2   3
    ${value}=           Remove String       ${cell}     %   +
    [Return]            ${value}

Accept cookie
    Click on element    ${COOKIE_ACCEPT}
