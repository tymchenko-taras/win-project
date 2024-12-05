@echo off
echo Make bootable ISO image using mkisofs
echo Copyright (c)2004 by Alex Kopylov

if "%1" == "" goto usage

: *** Language specific options (not required for modified version of mkisofs)

:set charset_options=-input-charset cp1251 -output-charset cp866

: *** Storage optimization options

: *** Original mkisofs with dfl
:set optimize_options=-cache-inodes -f
: *** Modified mkisofs with -duplicates-once
set optimize_options=-duplicates-once

: -duplicates-once             Optimize storage by encoding duplicate files once

: *** File system options

set fs_options=

if "%1" == "-u"  set fs_options=-N -d -D -no-iso-translate -relaxed-filenames -J -joliet-long -udf
if "%1" == "-j"  set fs_options=-N -d -D -no-iso-translate -relaxed-filenames -J -joliet-long
if "%1" == "-l"  set fs_options=-N -d -D -no-iso-translate -relaxed-filenames -max-iso9660-filenames -allow-multidot -allow-leading-dots -allow-lowercase
if "%1" == "-lu" set fs_options=-N -d -D -no-iso-translate -relaxed-filenames -max-iso9660-filenames -allow-multidot -allow-leading-dots
if "%1" == "-s"  set fs_options=-N -d -D -no-iso-translate -relaxed-filenames
if "%1" == "-v2" set fs_options=-iso-level 4
if "%1" == "-v2u" set fs_options=-iso-level 4 -force-uppercase

: -N, -omit-version-number     Omit version number from ISO9660 filename (violates ISO9660)
: -d, -omit-period             Omit trailing periods from filenames (violates ISO9660)
: -D, -disable-deep-relocation Disable deep directory relocation (violates ISO9660)
: -no-iso-translate            Do not translate illegal ISO characters '~', '-' and '#' (violates ISO9660)
: -relaxed-filenames           Allow 7 bit ASCII except lower case characters (violates ISO9660)
: -max-iso9660-filenames       Allow 37 character filenames for ISO9660 names (violates ISO9660)
: -allow-multidot              Allow more than one dot in filenames (e.g. .tar.gz) (violates ISO9660)
: -L, -allow-leading-dots      Allow ISO9660 filenames to start with '.' (violates ISO9660)
: -allow-lowercase             Allow lower case characters in addition to the current character set (violates ISO9660)
: -force-uppercase             Do not allow lower case characters

if "%fs_options%" == "" goto unknown_file_system_type

if "%2" == "" goto one_folder_name_is_required

: *** Creating hidden part of CD

if "%3" == "" goto no_hidden_iso

: *** Check for Bootable CD Wizard v2.0

if not exist %3\bcdw\loader.bin goto bcdw_files_not_exist
if not exist %3\bcdw\bcdw.bin goto bcdw_files_not_exist

echo:
echo Creating %3.iso (hidden part of CD)...
if "%1" == "-u"  mkisofs.exe -quiet %optimize_options% %charset_options% %fs_options% %iso_boot_options% %joliet_boot_options% -o %3.iso %3/
if "%1" == "-j"  mkisofs.exe -quiet %optimize_options% %charset_options% %fs_options% %iso_boot_options% %joliet_boot_options% -o %3.iso %3/
if "%1" == "-l"  mkisofs.exe -quiet %optimize_options% %charset_options% %fs_options% %iso_boot_options% -o %3.iso %3/
if "%1" == "-lu" mkisofs.exe -quiet %optimize_options% %charset_options% %fs_options% %iso_boot_options% -o %3.iso %3/
if "%1" == "-s"  mkisofs.exe -quiet %optimize_options% %charset_options% %fs_options% %iso_boot_options% -o %3.iso %3/
if "%1" == "-v2" mkisofs.exe -quiet %optimize_options% %charset_options% %fs_options% %iso_boot_options% -o %3.iso %3/
if "%1" == "-v2u" mkisofs.exe -quiet %optimize_options% %charset_options% %fs_options% %iso_boot_options% -o %3.iso %3/
if errorlevel == 1 goto cannot_create_hidden_iso

echo:
echo Merging %3\bcdw\loader.bin and %3.iso to %2\bcdwhide.bin...
copy /b %3\bcdw\loader.bin + %3.iso %2\bcdwhide.bin >nul
if not exist %2\bcdwhide.bin goto cannot_merge_files

echo:
echo Removing file %3.iso...
del %3.iso >nul

:no_hidden_iso

: *** Check for used bootloader

set boot_loader_name=Non bootable

if exist %2\bootsect.bin set boot_loader_name=CD boot sector
if exist %2\bootsect.bin set iso_boot_options=-no-emul-boot -b bootsect.bin -boot-load-size 4 -hide boot.catalog
if exist %2\bootsect.bin set joliet_boot_options=-hide-joliet boot.catalog
if exist %2\bootsect.bin set iso_patch_program=

if exist %2\acronis.wbt set boot_loader_name=Acronis boot image
if exist %2\acronis.wbt set iso_boot_options=-no-emul-boot -b acronis.wbt -boot-load-size 4 -hide boot.catalog
if exist %2\acronis.wbt set joliet_boot_options=-hide-joliet boot.catalog
if exist %2\acronis.wbt set iso_patch_program=

if exist %2\bscript\loader.bin set boot_loader_name=Boot Scriptor v1.x.x
if exist %2\bscript\loader.bin set iso_boot_options=-no-emul-boot -b bscript/loader.bin -boot-load-size 4 -hide boot.catalog
if exist %2\bscript\loader.bin set joliet_boot_options=-hide-joliet boot.catalog
if exist %2\bscript\loader.bin set iso_patch_program=

if exist %2\cdsh\loader.bin set boot_loader_name=CD Shell v2.0.10 or earlier
if exist %2\cdsh\loader.bin set iso_boot_options=-no-emul-boot -b cdsh/loader.bin -boot-load-size 4 -hide boot.catalog
if exist %2\cdsh\loader.bin set joliet_boot_options=-hide-joliet boot.catalog
if exist %2\cdsh\loader.bin set iso_patch_program=

if exist %2\boot\loader.bin set boot_loader_name=CD Shell v2.0.11+ or DiskEmu v2.x
if exist %2\boot\loader.bin set iso_boot_options=-no-emul-boot -b boot/loader.bin -boot-load-size 4 -hide boot.catalog
if exist %2\boot\loader.bin set joliet_boot_options=-hide-joliet boot.catalog
if exist %2\boot\loader.bin set iso_patch_program=

if exist %2\isolinux\isolinux.bin set boot_loader_name=isolinux
if exist %2\isolinux\isolinux.bin set iso_boot_options=-no-emul-boot -b isolinux/isolinux.bin -boot-info-table -hide boot.catalog
if exist %2\isolinux\isolinux.bin set joliet_boot_options=-hide-joliet boot.catalog
if exist %2\isolinux\isolinux.bin set iso_patch_program=

if exist %2\bcdwboot.bin set boot_loader_name=Bootable CD Wizard v1.xx
if exist %2\bcdwboot.bin set iso_boot_options=-no-emul-boot -b bcdwboot.bin -boot-load-size 4 -hide boot.catalog
if exist %2\bcdwboot.bin set joliet_boot_options=-hide-joliet boot.catalog
if exist %2\bcdwboot.bin set iso_patch_program=

if exist %2\bcdw\loader.bin set boot_loader_name=Bootable CD Wizard v2.0 in normal mode
if exist %2\bcdw\loader.bin set iso_boot_options=-no-emul-boot -b bcdw/loader.bin -boot-load-size 4 -hide boot.catalog
if exist %2\bcdw\loader.bin set joliet_boot_options=-hide-joliet boot.catalog
if exist %2\bcdw\loader.bin set iso_patch_program=

if exist %2\bcdwhide.bin set boot_loader_name=Bootable CD Wizard v2.0 in hidden mode
if exist %2\bcdwhide.bin set iso_boot_options=-no-emul-boot -b bcdwhide.bin -boot-load-size 4 -hide boot.catalog -hide bcdwhide.bin
if exist %2\bcdwhide.bin set joliet_boot_options=-hide-joliet boot.catalog -hide-joliet bcdwhide.bin
if exist %2\bcdwhide.bin set iso_patch_program=

: *** Create final ISO image

echo:
echo Creating %2.iso (bootloader: %boot_loader_name%)...

if "%1" == "-u"  mkisofs.exe -quiet %optimize_options% %charset_options% %fs_options% %iso_boot_options% %joliet_boot_options% -o %2.iso %2/
if "%1" == "-j"  mkisofs.exe -quiet %optimize_options% %charset_options% %fs_options% %iso_boot_options% %joliet_boot_options% -o %2.iso %2/
if "%1" == "-l"  mkisofs.exe -quiet %optimize_options% %charset_options% %fs_options% %iso_boot_options% -o %2.iso %2/
if "%1" == "-lu" mkisofs.exe -quiet %optimize_options% %charset_options% %fs_options% %iso_boot_options% -o %2.iso %2/
if "%1" == "-s"  mkisofs.exe -quiet %optimize_options% %charset_options% %fs_options% %iso_boot_options% -o %2.iso %2/
if "%1" == "-v2" mkisofs.exe -quiet %optimize_options% %charset_options% %fs_options% %iso_boot_options% -o %2.iso %2/
if "%1" == "-v2u" mkisofs.exe -quiet %optimize_options% %charset_options% %fs_options% %iso_boot_options% -o %2.iso %2/
if errorlevel == 1 goto cannot_create_final_iso
if "%iso_patch_program%" == "" goto no_iso_patch_program
%iso_patch_program% %2.iso
if errorlevel == 1 goto cannot_patch_iso

:no_iso_patch_program
echo Ok.
goto quit

:unknown_file_system_type
echo:
echo Error: Unknown file system type.
goto error_exit

:one_folder_name_is_required
echo:
echo Error: At least one folder name is required.
goto error_exit

:bcdw_files_not_exist
echo:
echo Error: BCDW files not exist in %3 folder (%3\bcdw\loader.bin and %3\bcdw\bcdw.bin is required).
goto error_exit

:cannot_create_hidden_iso
echo:
echo Error: Cannot create %3.iso (hidden part of CD).
goto error_exit

:cannot_merge_files
echo:
echo Error: Cannot merge files %3\bcdw\loader.bin and %3.iso to %2\bcdwhide.bin.
goto error_exit

:cannot_create_final_iso
echo:
echo Error: Cannot create %2.iso (final ISO).
goto error_exit

:cannot_patch_iso
echo:
echo Error: Command '%iso_patch_program% %2.iso' failed.
echo        Cannot patch %2.iso. Produced ISO may not work correctly.
goto error_exit

:usage
echo:
echo Usage: mkbtiso.bat file_system_type folder1 [folder2]
echo:
echo folder2 (optional)
echo   name of folder with hidden part of CD (without trailing slash!)
echo   (at least must contains \bcdw\loader.bin and \bcdw\bcdw.bin)
echo folder1
echo   name of folder with visible part of CD (without trailing slash!)
echo file_system_type
echo     -u - UDF / Joliet long filenames (103 symbols max.) / ISO 8.3 filenames
echo     -j - Joliet long filenames (103 symbols max.) / ISO 8.3 filenames
echo     -l - ISO long filenames (37 symbols max.)
echo    -lu - ISO long uppercased filenames (37 symbols max.)
echo     -s - ISO 8.3 filenames
echo    -v2 - ISO v2 long filenames (207 symbols max.) / ISO 8.3 filenames
echo   -v2u - ISO v2 long uppercased filenames (207 symbols max.) / ISO 8.3 filenames
echo   Warning! All file systems are not ISO9660-compliant. It optimized to
echo   store Windows filenames "AS IS", without (as possible) conversion to
echo   ISO9660-compliant form. Produced CDs can be unreadable outside Windows.
echo   Some files on CDs without ISO 8.3 filenames can be unreadable under DOS
echo   and Windows NT 3.51.
echo:
echo Example:
echo mkbtiso -j c:\mybootcd c:\mybootcdh

:error_exit
echo:
echo Press any key to continue...
pause>nul
:quit
