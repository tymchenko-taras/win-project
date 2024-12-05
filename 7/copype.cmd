@echo off
setlocal

set _P=%~dp0%
set TEMPL=ISO

if /i "%1"=="" goto usage
if /i "%2"=="" goto usage
if /i not "%3"=="" goto usage
set SOURCE=%_P%%1
set DEST=%2

if not exist "%SOURCE%\winpe.wim" (
  echo File does not exist: "%SOURCE%\winpe.wim"
  exit /b 1
)

if exist "%DEST%" (
  echo Destination directory exists: %2
  exit /b 1
)

mkdir "%DEST%"
if errorlevel 1 (
  echo Unable to create destination: %2
  exit /b 1
)

echo.
echo ===================================================
echo Creating Windows PE customization working directory
echo.
echo     %DEST%
echo ===================================================
echo.

mkdir "%DEST%\%TEMPL%"
if errorlevel 1 goto :FAIL
mkdir "%DEST%\mount"
if errorlevel 1 goto :FAIL

if exist "%SOURCE%\bootmgr" copy "%SOURCE%\bootmgr" "%DEST%\%TEMPL%"
if errorlevel 1 goto :FAIL
if exist "%SOURCE%\bootmgr.efi" copy "%SOURCE%\bootmgr.efi" "%DEST%\%TEMPL%"
if errorlevel 1 goto :FAIL
if exist "%SOURCE%\boot\etfsboot.com" copy "%SOURCE%\boot\etfsboot.com" "%DEST%"
if errorlevel 1 goto :FAIL
if exist "%SOURCE%\boot\efisys.bin" copy "%SOURCE%\boot\efisys.bin" "%DEST%"
if errorlevel 1 goto :FAIL
if exist "%SOURCE%\boot\efisys_noprompt.bin" copy "%SOURCE%\boot\efisys_noprompt.bin" "%DEST%"
if errorlevel 1 goto :FAIL
if exist "%SOURCE%\boot" xcopy /cherky "%SOURCE%\boot" "%DEST%\%TEMPL%\boot\"
if errorlevel 1 goto :FAIL
if exist "%SOURCE%\EFI" xcopy /cherky "%SOURCE%\EFI" "%DEST%\%TEMPL%\EFI\"
if errorlevel 1 goto :FAIL
mkdir "%DEST%\%TEMPL%\sources"
if errorlevel 1 goto :FAIL
copy "%SOURCE%\winpe.wim" "%DEST%\winpe.wim"
if errorlevel 1 goto :FAIL

endlocal
echo.
echo Success
echo.
echo Updating path to include peimg, cdimage, imagex
echo.
echo    %~dp0
echo    %~dp0..\%PROCESSOR_ARCHITECTURE%
echo.

set PATH=%PATH%;%~dp0;%~dp0..\%PROCESSOR_ARCHITECTURE%
cd /d "%2"

goto :EOF

:usage
echo Usage: copype [x86 ^| amd64 ^| ia64] destination
echo.
echo Example: copype x86 c:\windowspe-x86
goto :EOF

:FAIL
echo Failed to create working directory
