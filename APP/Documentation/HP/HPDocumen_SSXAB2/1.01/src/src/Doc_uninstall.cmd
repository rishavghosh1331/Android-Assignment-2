@ECHO OFF
REM **********************************************************************
REM   DOC_UNINSTALL.CMD
REM
REM **********************************************************************

reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\HP_Documentation" /f
del /q /f "C:\Users\All Users\Microsoft\Windows\Start Menu\Programs\HP Help and Support\HP Documentation.lnk"
del /q /f "C:\Users\All Users\Microsoft\Windows\Start Menu\Programs\HP\HP Documentation.lnk"
del /q /f "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\HP Help and Support\HP Documentation.lnk"
del /q /f "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\HP\HP Documentation.lnk"
rmdir /S /Q "C:\Program Files\HP\Documentation"



