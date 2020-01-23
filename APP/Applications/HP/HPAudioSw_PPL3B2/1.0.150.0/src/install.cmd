if "%log%"=="" set log=c:\system.sav\logs\CEPS
if exist %FCC_LOG_FOLDER% set log=%FCC_LOG_FOLDER%
if NOT exist %log% md %log%
set logSpec=%log%\Win10HPAudioSwitch.log
Set Cmdline=%log%\cmdline.txt

set CURRENT_DIR=%~dp0
set logA=%CURRENT_DIR%log.txt
if NOT exist "C:\System.sav\Logs\CEPS" mkdir "C:\System.sav\Logs\CEPS"

@echo %date% %time% Running msi file >> %logSpec%

msiexec /i %CURRENT_DIR%HPAudioSwitch.msi /l*v %logA%
echo msiexec /i %CURRENT_DIR%HPAudioSwitch.msi /l*v >> %Cmdline%
type %logA% >> %logSpec% 
del %logA%

@echo %date% %time%   Errorlevel=%errorlevel% >>  %logSpec%
@echo ---------------------------------------------------------------------  >>  %logSpec%
Set Exit_Code=%errorlevel%
Exit /b %errorlevel%