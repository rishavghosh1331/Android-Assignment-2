ECHO OFF
cd %~dp0

IF EXIST "C:\system.sav\Logs\" GOTO HPSE
MD "C:\system.sav\Logs\"

:HPSE
IF EXIST "C:\HP\DATA\HPSE\" GOTO INSTALL
MD "C:\HP\DATA\HPSE"

:INSTALL
COPY ".\Button.dat" "C:\HP\DATA\HPSE\" >>C:\system.sav\Logs\HPSEU.log
COPY ".\Hotkey.dat" "C:\HP\DATA\HPSE\" >>C:\system.sav\Logs\HPSEU.log
COPY ".\SmartAdapter.dat" "C:\HP\DATA\HPSE\" >>C:\system.sav\Logs\HPSEU.log
COPY ".\Default.ini" "C:\HP\DATA\HPSE\" >>C:\system.sav\Logs\HPSEU.log
COPY ".\WMIEvent9.dat" "C:\HP\DATA\HPSE\" >>C:\system.sav\Logs\HPSEU.log
COPY ".\WMIEvent1.dat" "C:\HP\DATA\HPSE\" >>C:\system.sav\Logs\HPSEU.log
COPY ".\StandardHotkey.dat" "C:\HP\DATA\HPSE\" >>C:\system.sav\Logs\HPSEU.log
COPY ".\WMIEvent12.dat" "C:\HP\DATA\HPSE\" >>C:\system.sav\Logs\HPSEU.log
COPY ".\WMIEvent20001.dat" "C:\HP\DATA\HPSE\" >>C:\system.sav\Logs\HPSEU.log
COPY ".\WMIEvent14.dat" "C:\HP\DATA\HPSE\" >>C:\system.sav\Logs\HPSEU.log

REG DELETE "HKCU\Software\HP\HP System Event" /f
REG DELETE "HKCU\Software\Hewlett-Packard\HP System Event" /f
msiexec.exe /i  HPSystemEventUtility.msi /passive /norestart
vc_redist.x64.exe /quiet 

IF NOT EXIST "C:\Windows\System32\CheckNetIsolation.exe" GOTO END
C:\Windows\System32\CheckNetIsolation.exe LoopbackExempt -a -p=S-1-15-2-3494391362-645846966-2664288422-1104730290-679965363-4273658097-3560940607 >>C:\system.sav\Logs\HPSEU.log
REM C:\Windows\System32\CheckNetIsolation.exe LoopbackExempt -a -p=S-1-15-2-382914950-390428822-379821503-1991989555-2387142107-400976959-4192610564 >>C:\system.sav\Logs\HPSEU.log
C:\Windows\System32\CheckNetIsolation.exe LoopbackExempt -s >>C:\system.sav\Logs\HPSEU.log

:END