REM ========================================================
REM   Driver deliverable installation
REM 
REM   Template Version: V1.00
REM ========================================================

REM %Description of deliverable%
@ECHO OFF
Set FCC_LOG_FOLDER=C:\SYSTEM.SAV\logs\[FCC]_HP_Wireless_Button_Driver_for_cNB_-_DCHU_compliant
if defined FCC_LOG_FOLDER (SET "APP_LOG=%FCC_LOG_FOLDER%\%~n0.log") else (SET "APP_LOG=C:\System.sav\Logs\%~n0.log")

ECHO ############################################################# >> %APP_LOG%
ECHO  [%DATE%]                                                     >> %APP_LOG%
ECHO  [%TIME%] Beginning of the %~nx0                              >> %APP_LOG%
ECHO ############################################################# >> %APP_LOG%

REM ------------------- Script Entry ------------------------
:INSTALL
echo [%TIME%] Pnputil.exe /add-driver "%~dp0base\*.inf" /install >> %APP_LOG%
Pnputil.exe /add-driver "%~dp0base\*.inf" /install >> %APP_LOG%
if errorlevel 1 echo [%TIME%] Base INF install failed. >> %APP_LOG% & goto RESULTFAILED
echo [%TIME%] Base INF install success. >> %APP_LOG%

GOTO END

:RESULTFAILED
ECHO ERRRORLEVEL=%ERRORLEVEL% >> %APP_LOG%
GOTO END

:END
EXIT /B %errorlevel%

