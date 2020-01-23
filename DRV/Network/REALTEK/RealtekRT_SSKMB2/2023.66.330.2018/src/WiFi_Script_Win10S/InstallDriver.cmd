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
echo ***  Batch Install Realtek Wireless LAN Driver               
echo ***                                                            
echo ***  Please wait a moment	                  
echo=

if %PROCESSOR_ARCHITECTURE%==AMD64 (
    set WiFiDIR="C:\Program Files (x86)\Realtek\PCIE Wireless LAN"
    set DriverSrcPath=%~dp0RTWLANE_Driver\Win10X64
    set DPInstPath=%~dp0RTWLANE_Driver\DPInst\X64
    set EAPSrcPath=%~dp0EAP\X64
)
if %PROCESSOR_ARCHITECTURE%==x86 (
    set WiFiDIR="C:\Program Files\Realtek\PCIE Wireless LAN"
    set DriverSrcPath=%~dp0RTWLANE_Driver\Win10X86
    set DPInstPath=%~dp0RTWLANE_Driver\DPInst\X86
    set EAPSrcPath=%~dp0EAP\X86
)
set RtlS5WakePath=%~dp0RTWLANE_Driver\RtlS5Wake
set VersionPath=%~dp0RTWLANE_Driver\Version
set var=%WiFiDIR:~1,-1%

xcopy /y "%RtlS5WakePath%\*" "%var%\RtlS5Wake\" /s /e > nul
xcopy /y "%VersionPath%\*" "%var%\" /s /e > nul
xcopy /y "%DriverSrcPath%\*" "%var%\" /s /e > nul
xcopy /y "%DPInstPath%\*" "%var%\" /s /e > nul

pnputil /add-driver "%var%\*.inf" /install >%WiFiDIR%\pnp.log

msiexec /qn /i "%EAPSrcPath%\EAP-FAST.msi"
msiexec /qn /i "%EAPSrcPath%\EAP-PEAP.msi"
msiexec /qn /i "%EAPSrcPath%\EAP-LEAP.msi"

@>nul 2>&1 "%WiFiDIR%\RtlS5Wake\RtlS5Wake.exe" 

if %PROCESSOR_ARCHITECTURE%==AMD64 (
start "" "C:\Program Files (x86)\Realtek\PCIE Wireless LAN\RtlS5Wake\RtlS5Wake.exe"
)
if %PROCESSOR_ARCHITECTURE%==x86 ( 
start "" ""C:\Program Files\Realtek\PCIE Wireless LAN\RtlS5Wake\RtlS5Wake.exe""
)
echo=     
echo **************************************************************
echo ***  Driver Install Finished                                       
echo=

pause
