@echo off
TITLE Creating ISO Image of BCDW project 
ECHO.

:: ������� ���� � ������������ (������ ������������ �����)
SET DISTRO=D:\Downloads\cleen_XP\ru-winxp-pro-with-sp3

:: ������� ��� ������� �������������� ISO �����
SET OUTPUT=D:

:: ������� ����� ���� (��� ��������!)
:: ��� �� ����� ������������ ��� ��� ISO ������
SET LABEL=KaktyS_DVD
:: ������ ����������� ����� 
:: Windows XP http://www.tacktech.com/display.cfm?ttid=342
:: Windows 2003 http://www.tacktech.com/display.cfm?ttid=355

:: ������ ��������� ������
ECHO Removing any possible attributes set on %DISTRO% and its subfolders...
attrib -R -H "%DISTRO%" /S /D
ECHO. 

:: �������� ISO
ECHO Creating ISO...

:: ��������������, ��� ����� � BCDW � ����� ������������� �����. 
:: �������� ���� � ���������� (.bin) ���� ����������. 

:: ��� BCDW 2.0a1
CDIMAGE.EXE -l"%LABEL%" -h -j1 -oci -m -b"%DISTRO%\bcdw\loader.bin" "%DISTRO%" "%OUTPUT%\%LABEL%.ISO"

ECHO.

PAUSE
EXIT