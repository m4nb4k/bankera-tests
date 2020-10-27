*** Keywords ***
Click on element
    [Arguments]                 ${ELEMENT}
    Element exists              ${ELEMENT}
    Scroll Element Into View    ${ELEMENT}
    Click Element               ${ELEMENT}

Element exists
    [Arguments]                         ${ELEMENT}
    Wait Until Page Contains Element    ${ELEMENT}
    Wait Until Element Is Visible       ${ELEMENT}

Enter text
    [Arguments]                         ${ELEMENT}      ${TEXT}
    Element exists                      ${ELEMENT}
    Page Should Contain Textfield       ${ELEMENT}
    Scroll Element Into View            ${ELEMENT}
    Input text                          ${ELEMENT}      ${EMPTY}
    Input Text                          ${ELEMENT}      ${TEXT}

Setup
    Open Browser  ${HOME_URL}      Chrome
    Maximize Browser Window
    Reload Page
    Accept cookie