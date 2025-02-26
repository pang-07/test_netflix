*** Settings ***
Library  SeleniumLibrary

*** Variables ***
${URL}       https://www.netflix.com/th-en/login
${BROWSER}   Chrome
${EMAIL}     your_email@example.com
${PASSWORD}  your_password

*** Test Cases ***
Test Login to Netflix
    Open Browser  ${URL}  ${BROWSER}
    Maximize Browser Window
    Sleep  10  # เพิ่มเวลาให้หน้าเว็บโหลดก่อน

    # รอให้ช่องกรอกอีเมลปรากฏ
    Wait Until Element Is Visible  xpath=//input[@name="userLoginId"]  10s
    Input Text  xpath=//input[@name="userLoginId"]  ${EMAIL}
    
    # รอให้ช่องกรอกรหัสผ่านปรากฏ
    Wait Until Element Is Visible  xpath=//input[@name="password"]  10s
    Input Text  xpath=//input[@name="password"]  ${PASSWORD}

    # รอให้ปุ่ม "Sign In" ปรากฏ
    Wait Until Element Is Visible  xpath=//button[@data-uia='sign-in-button']  10s
    Click Button  xpath=//button[@data-uia='sign-in-button']

    Sleep  3  # เพิ่มเวลาเพื่อให้การเข้าสู่ระบบเสร็จสิ้น
    
  

    Capture Page Screenshot
    Close Browser

*** Keywords ***
Handle Failed Login
   Log  Login failed. Checking error message.
    # รอให้ข้อความแสดงข้อผิดพลาดปรากฏ
    Wait Until Element Is Visible  xpath=//span[contains(text(), 'Incorrect password')]  10s
    Capture Page Screenshot  failed_login.png  # จับภาพหน้าจอเมื่อ login ล้มเหลว
    Log  Error message: Incorrect password for ${EMAIL}
    Fail  Login failed with error: Incorrect password for ${EMAIL}อ login ล้มเหลว
   

Handle Successful Login
    Log  Login successful!
