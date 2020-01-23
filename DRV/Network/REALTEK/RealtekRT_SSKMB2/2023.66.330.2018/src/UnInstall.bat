echo Please wait for uninstalling ...
@echo off
set RootPath=%CD%\Uninstall.iss
Setup.exe /uninst /s /f1"%RootPath%" /f2"c:\setup.log"