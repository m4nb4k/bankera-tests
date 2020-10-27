*** Settings ***
Library     Selenium2Library
Library     RequestsLibrary
Library     Collections
Resource    ../Pages/HomePage.robot
Resource    ../Pages/TickerHelper.robot
Resource    ../Resources/Commons.robot
Resource    TestData.robot

*** Test Cases ***
Check if currency rate change was positive
    [Setup]     Setup
    Enter referrence currency       ${CURRENCY}
    Check if currency change was positive    ${CURRENCY}
    [Teardown]  Close Browser

Currency ticker test
    ${reponse}=     Send request    ${FIRST_CURRENCY}   ${SECOND_CURRENCY}
    Check if response structure is correct    ${reponse}
    Check if status code is correct           ${reponse}
    Check if response body is correct         ${reponse}
    Check if response headers is correct      ${reponse}