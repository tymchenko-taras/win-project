
start:

#goto text_menu

goto graphics_menu

i01_go:
bcdw SetTextVideoMode
show console
print "\n"
print "Boot from hard disk...\n"
bcdw Boot C:\
goto ixx_go_err

i02_go:
bcdw SetTextVideoMode
show console
print "\n"
print "Bart's Preinstalled Environment...\n"
bcdw Boot \WNPE\setupldr.bin
goto ixx_go_err

i03_go:
bcdw SetTextVideoMode
show console
print "\n"
print "Volkov Commander...\n"
bcdw Boot \bcdw\bcdw2dos.ima \vc\vc.com
goto ixx_go_err

i04_go:
bcdw SetTextVideoMode
show console
print "\n"
print "Microsoft Windows XP Setup...\n"
bcdw Boot \I386\setupldr.bin
goto ixx_go_err

i05_go:
bcdw SetTextVideoMode
show console
print "\n"
print "Microsoft Windows 98 Setup...\n"
bcdw Boot \bcdw\bcdw2dos.ima \win9x\setup.exe
goto ixx_go_err

i06_go:
bcdw SetTextVideoMode
show console
print "\n"
print "Linux...\n"
bcdw Boot /linux/isolinux.bin /linux/kernel ramdisk_size=16384 initrd=/linux/rescue.gz root=/dev/ram0 rw
goto ixx_go_err

i07_go:
bcdw SetTextVideoMode
show console
print "\n"
print "Acronis TrueImage Server...\n"
bcdw Boot \acronis\tis.iso
goto ixx_go_err

i08_go:
bcdw SetTextVideoMode
show console
print "\n"
print "Power Off...\n"
bcdw PowerOff
goto ixx_go_err

ixx_go_err:
print "Error. Code: $BCDW_LastError\n"
if $BCDW_LastError != 0x559F; then goto ixx_finish
bcdw CheckForBCDW
if $BCDW_ExitCode == 0; then goto ixx_finish
print "DOS loaded by BCDW2 (bcdw2dos.ima) is needed...\n"

ixx_finish:
print "Press any key to return...\n"
bcdw GetKey WaitKey
goto start

text_menu:

# 80x50 text mode
# bcdw SetTextVideoMode font.f08
# if $BCDW_ExitCode == 0; then goto t_mode_ok
# 80x25 text mode
bcdw SetTextVideoMode
if $BCDW_ExitCode == 0; then goto t_mode_ok

print "Fatal error 1.\n"
print "Press any key to exit...\n"
bcdw GetKey WaitKey

goto quit

t_mode_ok:
bcdw Dialog textmode.ini
if $BCDW_ExitCode == 1; then goto i01_go
if $BCDW_ExitCode == 2; then goto i02_go
if $BCDW_ExitCode == 3; then goto i03_go
if $BCDW_ExitCode == 4; then goto i04_go
if $BCDW_ExitCode == 5; then goto i05_go
if $BCDW_ExitCode == 6; then goto i06_go
if $BCDW_ExitCode == 7; then goto i07_go
if $BCDW_ExitCode == 8; then goto i08_go
goto quit

graphics_menu:

# SVGA modes
bcdw SetGraphicsVideoMode 640 480 32
if $BCDW_ExitCode == 0; then goto g_mode_ok
bcdw SetGraphicsVideoMode 640 480 24
if $BCDW_ExitCode == 0; then goto g_mode_ok
bcdw SetGraphicsVideoMode 640 480 16
if $BCDW_ExitCode == 0; then goto g_mode_ok
bcdw SetGraphicsVideoMode 640 480 15
if $BCDW_ExitCode == 0; then goto g_mode_ok
# bcdw SetGraphicsVideoMode 640 480 8
# if $BCDW_ExitCode == 0; then goto g_mode_ok

# VGA modes
bcdw SetGraphicsVideoMode 640 480 4
if $BCDW_ExitCode == 0; then goto g_mode_ok
# bcdw SetGraphicsVideoMode 640 480 1
# if $BCDW_ExitCode == 0; then goto g_mode_ok

# EGA modes
# bcdw SetGraphicsVideoMode 640 320 4
# if $BCDW_ExitCode == 0; then goto g_mode_ok
# bcdw SetGraphicsVideoMode 640 320 1
# if $BCDW_ExitCode == 0; then goto g_mode_ok
# bcdw SetGraphicsVideoMode 640 200 4
# if $BCDW_ExitCode == 0; then goto g_mode_ok
# bcdw SetGraphicsVideoMode 320 200 4
# if $BCDW_ExitCode == 0; then goto g_mode_ok

# any graphics mode (1x1 monochrome or better)
# bcdw SetGraphicsVideoMode 1 1 1
# if $BCDW_ExitCode == 0; then goto g_mode_ok

goto text_menu

g_mode_ok:

bcdw ShowGif item_01.gif 0 0
bcdw ShowGif item_02.gif 0 55
bcdw ShowGif item_03.gif 0 110
bcdw ShowGif item_04.gif 0 165
bcdw ShowGif item_05.gif 0 220
bcdw ShowGif item_06.gif 0 275
bcdw ShowGif item_07.gif 0 330
bcdw ShowGif item_08.gif 0 385

# 30 seconds timeout
bcdw ShowGif item_a.gif 0 0 30
if $BCDW_ExitCode == 0; then goto i01_go
goto i01_autorun

i01_active:
bcdw ShowGif item_a.gif 0 0 WaitKey
i01_autorun:
bcdw ShowGif item_p.gif 0 0
if $BCDW_LastKey == key[up]; then goto i08_active
if $BCDW_LastKey == key[down]; then goto i02_active
if $BCDW_LastKey == key[enter]; then goto i01_go
if $BCDW_LastKey == key[esc]; then goto quit
goto i01_active

i02_active:
bcdw ShowGif item_a.gif 0 55 WaitKey
bcdw ShowGif item_p.gif 0 55
if $BCDW_LastKey == key[up]; then goto i01_active
if $BCDW_LastKey == key[down]; then goto i03_active
if $BCDW_LastKey == key[enter]; then goto i02_go
if $BCDW_LastKey == key[esc]; then goto quit
goto i02_active

i03_active:
bcdw ShowGif item_a.gif 0 110 WaitKey
bcdw ShowGif item_p.gif 0 110
if $BCDW_LastKey == key[up]; then goto i02_active
if $BCDW_LastKey == key[down]; then goto i04_active
if $BCDW_LastKey == key[enter]; then goto i03_go
if $BCDW_LastKey == key[esc]; then goto quit
goto i03_active

i04_active:
bcdw ShowGif item_a.gif 0 165 WaitKey
bcdw ShowGif item_p.gif 0 165
if $BCDW_LastKey == key[up]; then goto i03_active
if $BCDW_LastKey == key[down]; then goto i05_active
if $BCDW_LastKey == key[enter]; then goto i04_go
if $BCDW_LastKey == key[esc]; then goto quit
goto i04_active

i05_active:
bcdw ShowGif item_a.gif 0 220 WaitKey
bcdw ShowGif item_p.gif 0 220
if $BCDW_LastKey == key[up]; then goto i04_active
if $BCDW_LastKey == key[down]; then goto i06_active
if $BCDW_LastKey == key[enter]; then goto i05_go
if $BCDW_LastKey == key[esc]; then goto quit
goto i05_active

i06_active:
bcdw ShowGif item_a.gif 0 275 WaitKey
bcdw ShowGif item_p.gif 0 275
if $BCDW_LastKey == key[up]; then goto i05_active
if $BCDW_LastKey == key[down]; then goto i07_active
if $BCDW_LastKey == key[enter]; then goto i06_go
if $BCDW_LastKey == key[esc]; then goto quit
goto i06_active

i07_active:
bcdw ShowGif item_a.gif 0 330 WaitKey
bcdw ShowGif item_p.gif 0 330
if $BCDW_LastKey == key[up]; then goto i06_active
if $BCDW_LastKey == key[down]; then goto i08_active
if $BCDW_LastKey == key[enter]; then goto i07_go
if $BCDW_LastKey == key[esc]; then goto quit
goto i07_active

i08_active:
bcdw ShowGif item_a.gif 0 385 WaitKey
bcdw ShowGif item_p.gif 0 385
if $BCDW_LastKey == key[up]; then goto i07_active
if $BCDW_LastKey == key[down]; then goto i01_active
if $BCDW_LastKey == key[enter]; then goto i08_go
if $BCDW_LastKey == key[esc]; then goto quit
goto i08_active

quit:
bcdw SetTextVideoMode
show console
print "\n"
bcdw Boot C:\
bcdw Reboot
end:
