REM The following is required in all INSTALL.CMD files
Call c:\system.sav\util\SetVariables.cmd
Set block=%~dp0
CD /D "%block%"
REM Remove the REM from the next line if your component does not support Silent Install (Application Recovery)
REM Erase /F /Q *.CVA
REM Add the command-line to have your component to be installed properly

set logfile=c:\system.sav\logs\install_FPP.log
if not exist "c:\system.sav\logs" md "c:\system.sav\logs"

echo. >> "%logfile%"
echo ^>^> %~f0 >> "%logfile%"
echo ^>^> %date% %time% >> "%logfile%"
echo. >> "%logfile%"

rem --------------------------------------------------------------------------
rem We will not have HP_TOOLS to host UEFI Diagnostics if DRV0 is requested
rem and the HD is in MBR, since only max. of 4 primary partition are allowed.
rem --------------------------------------------------------------------------
if exist c:\system.sav\flags\DRV0.flg if not exist c:\system.sav\flags\gpt.flg (
    echo ***WARNING***  DRV0 and MBR --^> won't create HP_TOOLS! >> "%logfile%"
    echo *del /f /q FAILURE.FLG >> "%logfile%"
    del /f /q FAILURE.FLG >> "%logfile%" 2>&1
    echo *del /f /q *.CVA >> "%logfile%"
    del /f /q *.CVA >> "%logfile%" 2>&1
    goto end_install
)

if exist c:\system.sav\tweaks\PreFBIOnline if exist c:\system.sav\tweaks\PostFBIOnline goto lbl_doCopyMethod

:lbl_RunSetup
pushd src
"setup.exe" /qn
popd

REM Erase failure flag file when install succeeded. Most applications return zero to indicate success.
IF %ERRORLEVEL% EQU 0 ERASE /F /Q FAILURE.FLG
IF %ERRORLEVEL% EQU 3010 ERASE /F /Q FAILURE.FLG

goto end_install

:lbl_doCopyMethod
echo *xcopy /fherkyiv src\Windows\*.* c:\Windows >> "%logfile%"
xcopy /fherkyiv src\Windows\*.* c:\Windows >> "%logfile%" 2>&1
if errorlevel 1 goto end_install

echo *xcopy /fherkyiv src\system.sav\*.* c:\system.sav >> "%logfile%"
xcopy /fherkyiv src\system.sav\*.* c:\system.sav >> "%logfile%" 2>&1
if errorlevel 1 goto end_install

echo *del /f /q FAILURE.FLG >> "%logfile%"
del /f /q FAILURE.FLG >> "%logfile%" 2>&1

:end_install

rem
rem Delete the src\Windows and src\system.sav folders since they're for CMIT DASH only
rem
if exist src\Windows (
    echo *rd /s /q src\Windows >> "%logfile%"
    rd /s /q src\Windows >> "%logfile%" 2>&1
)

if exist src\system.sav (
    echo *rd /s /q src\system.sav >> "%logfile%"
    rd /s /q src\system.sav >> "%logfile%" 2>&1
)

echo. >> "%logfile%"
echo ^<^< %~f0 >> "%logfile%"
echo ^<^< %date% %time% >> "%logfile%"
echo. >> "%logfile%"
