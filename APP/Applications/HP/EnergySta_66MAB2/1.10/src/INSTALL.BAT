IF EXIST "C:\Program Files (X86)" GOTO INSTALLX64

IF NOT EXIST "C:\Program Files (X86)" GOTO INSTALLX86


:INSTALLX64
msiexec.exe /i "EnergyStarX64.msi"  /PASSIVE
GOTO END

:INSTALLX86
msiexec.exe /i "EnergyStar.msi"  /PASSIVE
GOTO END

:END
