REM The following is required in all INSTALL.CMD files
Call c:\system.sav\util\SetVariables.cmd
Set block=%~dp0
CD /D "%block%"
Rem Remove the REM from the next line if your component does not support Silent Install (Application Recovery)
Erase /F /Q *.CVA

Set eDocDir="C:\Program Files\HP\Documentation"

REM *** Copy all files 
if not exist %eDocDir% mkdir %eDocDir%
xcopy /s/h/e/d/y .\src\*.* %eDocDir%

REM *** Find Microsoft signature image.

Findstr.exe /i /x /c:"ChannelId=25" C:\HP\BIN\RStone.ini
If not errorlevel 1 GOTO Microsoft

REM *** Create short cut.

DocShortCut.vbs
GOTO End

:Microsoft
DocShortCut1.vbs

:End
REM *** add uninstall option in Add or Remove Program
reg import HP_Documentation.reg
