### Некоторые тонкие настройки (подходят для Win-7 и Vista) 

Пуск - Все программы - Стандартные - Командная строка (по правой кнопке "Запуск от имени админа") 
Дальше, по очереди, копируем отсюда текст команд, вставляем по правой кнопке и жмём Энтер. 

>Отключить DEP (предотвращение выполнения данных): 
bcdedit.exe /set {current} nx AlwaysOff 

>Отключить Тередо (хитрый прокси через сервер мелкомягких): 
netsh int teredo set state disable 

>Отключить туннелирование (может тормозить сеть): 
netsh int 6to4 set state disable disable 

>Ускорить Download 
netsh int tcp set global autotuninglevel=restricted 

>Ускорить Upload 
netsh int tcp set global congestionprovider=ctcp 

На каждую команду должно выскочить ОК. 
Закрываем окно. 

>Отключить IPv6 (еще пока не используется): 
В свойствах соединения - Сеть - снять флаг "Internet Protocol Version 6 (TCP/IPv6)" 

Делаем рестарт.  


### Prefetch
По умолчанию система кеширует всё что вы делаете, после старта винт долго "шуршит". 
Это делается для ускорения запуска приложений, кеш постепенно растёт и занимает 
много места на диске (и в памяти). Сам процесс кеширования занимает память и время, 
в результате бывает не ускорение а замедление работы... 
Оптимально нужно кешировать только файлы, которые загружаются в память при старте системы. 
Для этого правим реестр руками (или создаём в блокноте и запускаем файл Prefetch.reg): 

Code
Windows Registry Editor Version 5.00 

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters] 
"EnableSuperfetch"=dword:00000002 
"EnablePrefetcher"=dword:00000002

Значения параметра: 
0 - отключить кеширование 
3 - кешировать всё (по умолчанию) 
2 - кешировать загрузку системы 

Сам кеш хранится в папке: \Windows\Prefetch\ 
После изменения реестра удаляем из этой папки всё, кроме папки "ReadyBoot". 
После рестарта системы там появится новый кеш. Максимальной скорость загрузки системы 
будет после нескольких рестартов. 

### SoftwareDistribution
After updates c:\windows\SoftwareDistribution may take a lot of space. It may be cleaned:
 - Run cmd
 - type net stop wuauserv and press enter
 - type rename c:\windows\SoftwareDistribution softwaredistribution.oldand press enter
 - type net start wuauserv and press enter
 - Verify that the new software distribution folder created when you restart the update service is approxiamtely 1.5 MB in size (standard files). Restart the computer and del the folder if you have no issues.

### Windows 10

- Not working with cyrilic fonts: Control Panel\Clock and Region\Region\Administarative\Change system locale - select ukrainian fron non unicode programs

- Disable updates: gpedit.msc -> Comp configuration\Admin Templates\Win Components\Windows Update\Configure Auto Update -> Disabled

- Disable auto drivers install: gpedit.msc -> Comp configuration\Admin Templates\System\Driver installation\Turon off windows update...-> Enabled

- "netsh wfp set options netevents=off" - to disable constant writing to "wfpdiag.etl" on disk C

- "netsh wfp set options netevents=off" - to disable constant writing to "wfpdiag.etl" on disk C

- Disable auto drivers install: this PC -> System Properties -> Hardware -> Device instalation settings -> No

- Home edition does not have gpedit. To install it run: `gpedit-enabler.bat`

- If computer has predefined key for Home edition it will be installed automatically, you dont have a choise during installation. To add edition selector copy file `ei.cfg` to the flash drive with windows to `sources` folder.
