Set OptaneExist=
for /f "tokens=1,2 delims==." %%i in ('wmic /namespace:"\\root\HP\InstrumentedBIOS" path HP_BIOSSetting where ^(name^="Optane"^) get Value /value') do (if /i [%%i]==[Value] set "OptaneExist==Yes")
If /i "%OptaneExist%" == "=Yes" (
"SetupRST.exe" -s -noicc
) else (
"SetupRST.exe" -s -noicc -notray
)