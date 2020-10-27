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
    Enter referrence currency       Bitcoin
    Currency change was positive    Bitcoin
    [Teardown]  Close Browser

Currency ticker test
    ${reponse}=                 Send request    ${FIRST_CURRENCY}   ${SECOND_CURRENCY}
    Check response structure    ${reponse}
    Check status code           ${reponse}
    Check response body         ${reponse}
    Check response headers      ${reponse}