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
echo ***  Batch Uninstall Realtek Bluetooth Filter Driver               
echo ***                                                            
echo ***  Please wait a moment	                  
echo=

if %PROCESSOR_ARCHITECTURE%==AMD64 (
    set BTDIR="C:\Program Files (x86)\REALTEK\Realtek Bluetooth"
)
if %PROCESSOR_ARCHITECTURE%==x86 (
    set BTDIR="C:\Program Files\REALTEK\Realtek Bluetooth"
)


set var=%BTDIR:~1,-1%

"%var%\dpinst.exe" /Q /D /U "%var%\Rtkfilter.inf"

sc stop RtkBtManServ
sc delete RtkBtManServ

rd /q /s %BTDIR%

echo=
echo **************************************************************
echo ***  Driver Uninstall Finished              
echo ***                                                            
echo ***  Please restart your unit after installation finished                  
echo=

pause