Set MY_LOG=C:\System.sav\Logs\CEPS\Win10HPAudioSwitch.log
set CURRENT_DIR=%~dp0
set log=%CURRENT_DIR%log.txt
if NOT exist "C:\System.sav\Logs\CEPS" mkdir "C:\System.sav\Logs\CEPS"

@echo %date% %time% Uninstalling application >> %MY_LOG%

msiexec /x %CURRENT_DIR%HPAudioSwitch.msi /l*v %log%
type %log% >> %MY_LOG%
del %log%

@echo %date% %time%   Errorlevel=%errorlevel% >>  %MY_LOG%
@echo ---------------------------------------------------------------------  >>  %MY_LOG%
Set Exit_Code=%errorlevel%
Exit /b %errorlevel%