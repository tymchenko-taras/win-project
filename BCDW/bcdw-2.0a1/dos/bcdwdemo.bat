@echo off

if not "%OS%" == "Windows_NT" goto start
if "%COMSPEC%" == "%SYSTEMROOT%\SYSTEM32\COMMAND.COM" goto start
command /e:4096 /c call bcdwdemo.bat
goto end

:start

::goto text_menu

goto graphics_menu

:i01_go
bcdw SetTextVideoMode
echo Boot from hard disk...
bcdw Boot C:\
goto ixx_go_err

:i02_go
bcdw SetTextVideoMode
echo Bart's Preinstalled Environment...
bcdw Boot \WNPE\setupldr.bin
goto ixx_go_err

:i03_go
bcdw SetTextVideoMode
echo Volkov Commander...
bcdw Boot \bcdw\bcdw2dos.ima \vc\vc.com
goto ixx_go_err

:i04_go
bcdw SetTextVideoMode
echo Microsoft Windows XP Setup...
bcdw Boot \I386\setupldr.bin
goto ixx_go_err

:i05_go
bcdw SetTextVideoMode
echo Microsoft Windows 98 Setup...
bcdw Boot \bcdw\bcdw2dos.ima \win9x\setup.exe
goto ixx_go_err

:i06_go
bcdw SetTextVideoMode
echo Linux...
bcdw Boot /linux/isolinux.bin /linux/kernel ramdisk_size=16384 initrd=/linux/rescue.gz root=/dev/ram0 rw
goto ixx_go_err

:i07_go
bcdw SetTextVideoMode
echo Acronis TrueImage Server...
bcdw Boot \acronis\tis.iso
goto ixx_go_err

:i08_go
bcdw SetTextVideoMode
echo Power Off...
bcdw PowerOff
goto ixx_go_err

:ixx_go_err
echo Error. Code: %BCDW_LastError%
if not "%BCDW_LastError%" == "0x559F" goto ixx_finish
bcdw CheckForBCDW
if "%BCDW_ExitCode%" == "0"; then goto ixx_finish
echo DOS loaded by BCDW2 (bcdw2dos.ima) is needed...

:ixx_finish
echo Press any key to return...
pause > nul
goto start

:text_menu

:: 80x50 text mode
:: bcdw SetTextVideoMode font.f08
:: if "%BCDW_ExitCode%" == "0" goto t_mode_ok
:: 80x25 text mode
bcdw SetTextVideoMode
if "%BCDW_ExitCode%" == "0" goto t_mode_ok

echo Fatal error 1.
echo Press any key to exit...
pause > nul

goto quit

:t_mode_ok

bcdw Dialog textmode.ini
if "%BCDW_ExitCode%" == "1" goto i01_go
if "%BCDW_ExitCode%" == "2" goto i02_go
if "%BCDW_ExitCode%" == "3" goto i03_go
if "%BCDW_ExitCode%" == "4" goto i04_go
if "%BCDW_ExitCode%" == "5" goto i05_go
if "%BCDW_ExitCode%" == "6" goto i06_go
if "%BCDW_ExitCode%" == "7" goto i07_go
if "%BCDW_ExitCode%" == "8" goto i08_go
goto quit

:graphics_menu

:: SVGA modes
bcdw SetGraphicsVideoMode 640 480 32
if "%BCDW_ExitCode%" == "0" goto g_mode_ok
bcdw SetGraphicsVideoMode 640 480 24
if "%BCDW_ExitCode%" == "0" goto g_mode_ok
bcdw SetGraphicsVideoMode 640 480 16
if "%BCDW_ExitCode%" == "0" goto g_mode_ok
bcdw SetGraphicsVideoMode 640 480 15
if "%BCDW_ExitCode%" == "0" goto g_mode_ok
:: bcdw SetGraphicsVideoMode 640 480 8
:: if "%BCDW_ExitCode%" == "0" goto g_mode_ok

:: VGA modes
bcdw SetGraphicsVideoMode 640 480 4
if "%BCDW_ExitCode%" == "0" goto g_mode_ok
:: bcdw SetGraphicsVideoMode 640 480 1
:: if "%BCDW_ExitCode%" == "0" goto g_mode_ok

:: EGA modes
:: bcdw SetGraphicsVideoMode 640 320 4
:: if "%BCDW_ExitCode%" == "0" goto g_mode_ok
:: bcdw SetGraphicsVideoMode 640 320 1
:: if "%BCDW_ExitCode%" == "0" goto g_mode_ok
:: bcdw SetGraphicsVideoMode 640 200 4
:: if "%BCDW_ExitCode%" == "0" goto g_mode_ok
:: bcdw SetGraphicsVideoMode 320 200 4
:: if "%BCDW_ExitCode%" == "0" goto g_mode_ok

:: any graphics mode (1x1 monochrome or better)
:: bcdw SetGraphicsVideoMode 1 1 1
:: if "%BCDW_ExitCode%" == "0" goto g_mode_ok

goto text_menu

:g_mode_ok

bcdw ShowGif item_01.gif 0 0
bcdw ShowGif item_02.gif 0 55
bcdw ShowGif item_03.gif 0 110
bcdw ShowGif item_04.gif 0 165
bcdw ShowGif item_05.gif 0 220
bcdw ShowGif item_06.gif 0 275
bcdw ShowGif item_07.gif 0 330
bcdw ShowGif item_08.gif 0 385

:: 30 seconds timeout
bcdw ShowGif item_a.gif 0 0 30
if "%BCDW_ExitCode%" == "0" goto i01_go
goto i01_autorun

:i01_active
bcdw ShowGif item_a.gif 0 0 WaitKey
:i01_autorun
bcdw ShowGif item_p.gif 0 0
if "%BCDW_LastKey%" == "0x4800" goto i08_active
if "%BCDW_LastKey%" == "0x5000" goto i02_active
if "%BCDW_LastKey%" == "0x000D" goto i01_go
if "%BCDW_LastKey%" == "0x001B" goto quit
goto i01_active

:i02_active
bcdw ShowGif item_a.gif 0 55 WaitKey
bcdw ShowGif item_p.gif 0 55
if "%BCDW_LastKey%" == "0x4800" goto i01_active
if "%BCDW_LastKey%" == "0x5000" goto i03_active
if "%BCDW_LastKey%" == "0x000D" goto i02_go
if "%BCDW_LastKey%" == "0x001B" goto quit
goto i02_active

:i03_active
bcdw ShowGif item_a.gif 0 110 WaitKey
bcdw ShowGif item_p.gif 0 110
if "%BCDW_LastKey%" == "0x4800" goto i02_active
if "%BCDW_LastKey%" == "0x5000" goto i04_active
if "%BCDW_LastKey%" == "0x000D" goto i03_go
if "%BCDW_LastKey%" == "0x001B" goto quit
goto i03_active

:i04_active
bcdw ShowGif item_a.gif 0 165 WaitKey
bcdw ShowGif item_p.gif 0 165
if "%BCDW_LastKey%" == "0x4800" goto i03_active
if "%BCDW_LastKey%" == "0x5000" goto i05_active
if "%BCDW_LastKey%" == "0x000D" goto i04_go
if "%BCDW_LastKey%" == "0x001B" goto quit
goto i04_active

:i05_active
bcdw ShowGif item_a.gif 0 220 WaitKey
bcdw ShowGif item_p.gif 0 220
if "%BCDW_LastKey%" == "0x4800" goto i04_active
if "%BCDW_LastKey%" == "0x5000" goto i06_active
if "%BCDW_LastKey%" == "0x000D" goto i05_go
if "%BCDW_LastKey%" == "0x001B" goto quit
goto i05_active

:i06_active
bcdw ShowGif item_a.gif 0 275 WaitKey
bcdw ShowGif item_p.gif 0 275
if "%BCDW_LastKey%" == "0x4800" goto i05_active
if "%BCDW_LastKey%" == "0x5000" goto i07_active
if "%BCDW_LastKey%" == "0x000D" goto i06_go
if "%BCDW_LastKey%" == "0x001B" goto quit
goto i06_active

:i07_active
bcdw ShowGif item_a.gif 0 330 WaitKey
bcdw ShowGif item_p.gif 0 330
if "%BCDW_LastKey%" == "0x4800" goto i06_active
if "%BCDW_LastKey%" == "0x5000" goto i08_active
if "%BCDW_LastKey%" == "0x000D" goto i07_go
if "%BCDW_LastKey%" == "0x001B" goto quit
goto i07_active

:i08_active
bcdw ShowGif item_a.gif 0 385 WaitKey
bcdw ShowGif item_p.gif 0 385
if "%BCDW_LastKey%" == "0x4800" goto i07_active
if "%BCDW_LastKey%" == "0x5000" goto i01_active
if "%BCDW_LastKey%" == "0x000D" goto i08_go
if "%BCDW_LastKey%" == "0x001B" goto quit
goto i08_active

:quit
bcdw SetTextVideoMode
bcdw Boot C:\
bcdw Reboot
:end
