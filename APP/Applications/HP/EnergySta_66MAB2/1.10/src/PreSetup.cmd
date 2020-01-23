Set block=%~dp0

REM Energy Star
@ECHO OFF
SETLOCAL
SET APP_NAME=Energy Star
SET BIT_NAME=EStar
SET APP_STAGE=Install_BBV_2
REM SET APP_FEATURE="MIR,SR,MUI"
SET APP_CHKFILE="C:\Program Files\Hewlett-Packard\Energy Star\ClearSysReg.exe"
SET APP_LOG=C:\System.sav\LOGS\BB\%BIT_NAME%.LOG
IF NOT EXIST C:\System.sav\LOGS\BB MD C:\System.sav\LOGS\BB

ECHO ############################################################# >> %APP_LOG%
ECHO  [%DATE%]                                                                                                         >> %APP_LOG%
ECHO  [%TIME%] Beginning of the %~nx0                                                                   >> %APP_LOG%
ECHO ############################################################# >> %APP_LOG%

ECHO [%TIME%] ================ The Installation of %APP_NAME% ================ >> C:\System.sav\LOGS\%APP_STAGE%.LOG
ECHO [%TIME%] Item=%APP_NAME% >>C:\System.sav\LOGS\%APP_STAGE%.LOG
REM ECHO [%TIME%] Feature=%APP_FEATURE% >>C:\System.sav\LOGS\%APP_STAGE%.LOG
ECHO [%TIME%] Log=%APP_LOG% >>C:\System.sav\LOGS\%APP_STAGE%.LOG

REM ------------------- Script Entry ------------------------
:INSTALL
Pushd "%block%"
ECHO [%TIME%] Install %APP_NAME% >>%APP_LOG%
HPSetup.exe
Popd

IF ERRORLEVEL 1 GOTO RESULTFAILED
IF %ERRORLEVEL% EQU 0 GOTO AppCheck

:AppCheck
ECHO [%TIME%] Check installation result file: %APP_CHKFILE% >> %APP_LOG%
IF NOT EXIST %APP_CHKFILE% ECHO Install Failed. >> %APP_LOG% & GOTO RESULTFAILED
IF EXIST %APP_CHKFILE% ECHO Install PASSED. >> %APP_LOG% & GOTO RESULTPASSED

:RESULTFAILED
ECHO [%TIME%] Result of the %APP_NAME% >> %APP_LOG%
ECHO ERRRORLEVEL=%ERRORLEVEL% >> %APP_LOG%
ECHO RESULT=FAILED >> %APP_LOG%
ECHO RESULT=FAILED >> C:\System.sav\LOGS\%APP_STAGE%.LOG
GOTO END

:RESULTPASSED
REM Erase failure flag file when install succeeded. Most applications return zero to indicate success.
popd
ERASE /F /Q FAILURE.FLG 
ECHO [%TIME%] Result of the %APP_NAME% >> %APP_LOG%
ECHO RESULT=PASSED >> %APP_LOG%
ECHO RESULT=PASSED >> C:\System.sav\LOGS\%APP_STAGE%.LOG
GOTO END

:END
ECHO [%TIME%] ============= End the Installation of %APP_NAME% ================ >> C:\System.sav\LOGS\%APP_STAGE%.LOG
ENDLOCAL
@ECHO ON

