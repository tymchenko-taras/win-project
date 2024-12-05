@echo off
echo Bootable CD Wizard v2.0 Configuration test
if exist bcdw\bcdw2dos\bcdw.com goto go
echo:
echo Error: Cannot find file: bcdw\bcdw2dos\bcdw.com
echo:
echo Press any key to exit...
pause >nul
goto exit
:go
bcdw\bcdw2dos\bcdw.com Dialog bcdw\bcdw.ini
:exit
