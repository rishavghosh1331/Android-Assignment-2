@echo off
setlocal enabledelayedexpansion

:: BatchGotAdmin
:-------------------------------------
REM  --> Check for permissions
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"

    wscript "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    if exist "%temp%\getadmin.vbs" ( del "%temp%\getadmin.vbs" )
    pushd "%CD%"
    CD /D "%~dp0"
:--------------------------------------

echo **************************************************************
echo ***  Batch Uninstall Realtek Wireless LAN Driver               
echo ***                                                            
echo ***  Please wait a moment	                  
echo=

if %PROCESSOR_ARCHITECTURE%==AMD64 (
    set WiFiDIR="C:\Program Files (x86)\Realtek\PCIE Wireless LAN"
)
if %PROCESSOR_ARCHITECTURE%==x86 (
    set WiFiDIR="C:\Program Files\Realtek\PCIE Wireless LAN"
)


set var=%WiFiDIR:~1,-1%

"%var%\dpinst.exe" /Q /D /U "%var%\netrtwlane.inf"

start taskkill /F /IM RtlS5Wake.exe /T

msiexec /qn /x{51C7AD07-C3F6-4635-8E8A-231306D810FE}
msiexec /qn /x{ED5776D5-59B4-46B7-AF81-5F2D94D7C640}
msiexec /qn /x{64BF0187-F3D2-498B-99EA-163AF9AE6EC9}
msiexec /qn /x{AF312B06-5C5C-468E-89B3-BE6DE2645722}
msiexec /qn /x{0A4EF0E6-A912-4CDE-A7F3-6E56E7C13A2F}

rd /q /s %WiFiDIR%

echo=
echo **************************************************************
echo ***  Driver Uninstall Finished              
echo ***                                                            
echo ***  Please restart your unit after installation finished                  
echo=

pause