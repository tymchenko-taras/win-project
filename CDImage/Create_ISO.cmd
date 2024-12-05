@echo off
TITLE Creating ISO Image of Windows XP 
ECHO.

:: Укажите путь к дистрибутиву (файлам создаваемого диска)
SET DISTRO=C:\XPCD

:: Укажите где создать результирующий ISO образ
SET OUTPUT=C:

:: Укажите метку тома (без пробелов!)
:: Она же будет использована как имя ISO образа
SET LABEL=WXPFPP_EN
:: Список стандартных меток 
:: Windows XP http://www.tacktech.com/display.cfm?ttid=342
:: Windows 2003 http://www.tacktech.com/display.cfm?ttid=355

:: Снятие атрибутов файлов
ECHO Removing any possible attributes set on %DISTRO% and its subfolders...
attrib -R -H "%DISTRO%" /S /D
ECHO. 

:: Создание ISO
ECHO Creating ISO...
CDIMAGE.EXE -l"%LABEL%" -h -j1 -oci -m -bxpboot.img "%DISTRO%" "%OUTPUT%\%LABEL%.ISO"
ECHO.

PAUSE
EXIT