@echo off
set RootPath=%CD%\UninstallUI.iss
setup.exe -uninst -s -f1"%RootPath%" -f2"c:\setup.log"