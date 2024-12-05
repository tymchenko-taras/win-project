@echo off
TITLE Creating ISO Image of Windows XP 
ECHO.

:: ������� ���� � ������������ (������ ������������ �����)
SET DISTRO=C:\XPCD

:: ������� ��� ������� �������������� ISO �����
SET OUTPUT=C:

:: ������� ����� ���� (��� ��������!)
:: ��� �� ����� ������������ ��� ��� ISO ������
SET LABEL=WXPFPP_EN
:: ������ ����������� ����� 
:: Windows XP http://www.tacktech.com/display.cfm?ttid=342
:: Windows 2003 http://www.tacktech.com/display.cfm?ttid=355

:: ������ ��������� ������
ECHO Removing any possible attributes set on %DISTRO% and its subfolders...
attrib -R -H "%DISTRO%" /S /D
ECHO. 

:: �������� ISO
ECHO Creating ISO...
CDIMAGE.EXE -l"%LABEL%" -h -j1 -oci -m -bxpboot.img "%DISTRO%" "%OUTPUT%\%LABEL%.ISO"
ECHO.

PAUSE
EXIT