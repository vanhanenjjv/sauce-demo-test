*** Settings ***
Library           SeleniumLibrary     run_on_failure=Nothing
Suite Teardown    Close Browser


*** Variables ***
${URL}              https://www.saucedemo.com/
${DRIVER}           Chrome      

${USERNAME}         standard_user
${PASSWORD}         secret_sauce

${FIRST NAME}       Matti
${LAST NAME}        Meikäläinen
${POSTAL CODE}      60100


*** Test Cases ***
Login With Valid Credentials
    Open Browser To Login Page
    Set Selenium Speed            0.125
    Input Username                ${USERNAME}
    Input Password                ${PASSWORD}
    Submit Credentials
    Products Page Should Be Open

Add Product To Cart
    View First Item
    Add Item To Cart
    Go To Cart
    Should Contain Item

Checkout
    Go To Checkout
    Input First Name    ${FIRST NAME}
    Input Last Name     ${LAST NAME}
    Input Postal Code   ${POSTAL CODE}
    Go To Overview
    Should Contain Item
    Confirm Order
    Order Should Be Successful


*** Keywords ***
Open Browser To Login Page
    Open Browser                ${URL}      ${DRIVER}
    Login Page Should Be Open

Login Page Should Be Open
    Title Should Be             Swag Labs

Products Page Should Be Open
    Element Text Should Be      class:product_label      Products

Input Username
    [Arguments]     ${username}
    Input Text      id:user-name     ${username}

Input Password
    [Arguments]     ${password}
    Input Text      id:password     ${password}

Submit Credentials
    Click Element   id:login-button

View First Item
    Click Element   xpath: //*[@id="inventory_container"]/div/div[1]/div[2]/a

Add Item To Cart
    Click Element   xpath: //*[contains(text(), "ADD TO CART")]

Go To Cart
    Click Element   class:shopping_cart_link

Go To Checkout
    Click Element   class:checkout_button

Go To Overview
    Click Element   //*[@id="checkout_info_container"]/div/form/div[2]/input

Should Contain Item
    Page Should Contain Element        class:cart_item

Confirm Order
    Click Element   //*[@id="checkout_summary_container"]/div/div[2]/div[8]/a[2]

Input First Name
    [Arguments]     ${FIRST NAME}
    Input Text      id:first-name       ${FIRST NAME}

Input Last Name
    [Arguments]     ${LAST NAME}
    Input Text      id:last-name        ${LAST NAME}

Input Postal Code
    [Arguments]     ${POSTAL CODE}
    Input Text      id:postal-code      ${POSTAL CODE}

Order Should Be Successful
    Page Should Contain         THANK YOU FOR YOUR ORDER
    