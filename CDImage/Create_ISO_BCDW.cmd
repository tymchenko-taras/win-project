@echo off
TITLE Creating ISO Image of BCDW project 
ECHO.

:: Укажите путь к дистрибутиву (файлам создаваемого диска)
SET DISTRO=D:\Downloads\cleen_XP\ru-winxp-pro-with-sp3

:: Укажите где создать результирующий ISO образ
SET OUTPUT=D:

:: Укажите метку тома (без пробелов!)
:: Она же будет использована как имя ISO образа
SET LABEL=KaktyS_DVD
:: Список стандартных меток 
:: Windows XP http://www.tacktech.com/display.cfm?ttid=342
:: Windows 2003 http://www.tacktech.com/display.cfm?ttid=355

:: Снятие атрибутов файлов
ECHO Removing any possible attributes set on %DISTRO% and its subfolders...
attrib -R -H "%DISTRO%" /S /D
ECHO. 

:: Создание ISO
ECHO Creating ISO...

:: Предполагается, что папка с BCDW в корне создававемого диска. 
:: Измените путь к загрузчику (.bin) если необходимо. 

:: Для BCDW 2.0a1
CDIMAGE.EXE -l"%LABEL%" -h -j1 -oci -m -b"%DISTRO%\bcdw\loader.bin" "%DISTRO%" "%OUTPUT%\%LABEL%.ISO"

ECHO.

PAUSE
EXIT