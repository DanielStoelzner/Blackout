@echo off
PowerShell -NoProfile -ExecutionPolicy Bypass -Command "Invoke-ps2exe -InputFile 'blackout.ps1' -OutputFile 'blackout.exe'  -NoConsole"
pause