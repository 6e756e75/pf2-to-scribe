<# : batch script
@echo off
setlocal
cd %~dp0
powershell -NoExit -executionpolicy remotesigned -Command "Invoke-Expression $([System.IO.File]::ReadAllText('%~f0'))"
endlocal
goto:eof
#>
./Init.ps1