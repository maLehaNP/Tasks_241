# Пишем юниты

## 1 Создайте скрипт который создаёт папку заполняет её файлами (имена 1-4) и записывает в них информацию о текущей дате, версии ядра, имени компьютера и списе всех файлов в домашнем каталоге пользователя от которого выполняется скрипт (не забудьте сделать проверку на существование файлов и папок)
```bash
#!/bin/bash
set -euo pipefail

if [ ! -d "papka" ]; then
        mkdir papka
fi
cd papka

date >> 1

cat /proc/version >> 2

hostname >> 3

ls -a ~ >> 4
```
## 2 Создайте юнит который будет вызывать этот скрипт при запуске. Проверьте
Юнит (/ect/systemd/system/my5script.service):
```bash
[Unit]
Description = Task 2 script

[Service]
Type=oneshot
ExecStart=/home/student/Tasks_241/5-Systemd/script.sh
RemainAfterExit=true
```
До:
```bash
ls -l
итого 40
-rwxr-xr-x 1 student student  143 дек 22 21:22 script.sh
-rw-rw-rw- 1 root    root     143 дек  7 10:07 script.sh~
-rw-rw-rw- 1 root    root     405 ноя 21 17:23 taks1.md
-rw-r--r-- 1 student student  447 дек 22 21:22 task1_script.sh
-rw-rw-rw- 1 root    root     378 дек  7 09:38 task1_script.sh~
-rw-r--r-- 1 student student 1673 дек 22 21:22 task1_solution.md
-rw-rw-rw- 1 root    root    1673 дек  7 09:35 task1_solution.md~
-rw-rw-rw- 1 root    root    1482 ноя 21 17:23 task2.md
-rw-r--r-- 1 student student 1861 дек 22 22:06 task2_solution.md
-rw-r--r-- 1 student student 1678 дек 22 22:04 task2_solution.md~
```
После запуска:
```bash
ls -l
итого 40
drwxr-xr-x 2 root    root    4096 дек 22 22:21 papka
-rwxr-xr-x 1 student student  248 дек 22 22:20 script.sh
-rwxr-xr-x 1 student student  212 дек 22 22:19 script.sh~
-rw-r--r-- 1 student student  447 дек 22 21:22 task1_script.sh
-rw-rw-rw- 1 root    root     378 дек  7 09:38 task1_script.sh~
-rw-r--r-- 1 student student 1673 дек 22 21:22 task1_solution.md
-rw-rw-rw- 1 root    root    1673 дек  7 09:35 task1_solution.md~
-rw-rw-rw- 1 root    root    1482 ноя 21 17:23 task2.md
-rw-r--r-- 1 student student 2574 дек 22 22:13 task2_solution.md
-rw-r--r-- 1 student student 2571 дек 22 22:07 task2_solution.md~
```
```bash
cat papka/1
Sun Dec 22 10:21:24 PM MSK 2024
```
```bash
cat papka/2
Linux version 5.10.194-std-def-alt1 (builder@localhost.localdomain) (gcc-10 (GCC) 10.3.1 20210703 (ALT Sisyphus 10.3.1-alt2), GNU ld (GNU Binutils) 2.35.2.20210110) #1 SMP Sat Sep 2 09:32:37 UTC 2023
```
```bash
cat papka/3
S-vm-202
```
```bash
cat papka/4
.
..
.bash_history
.bash_logout
.bash_profile
.bashrc
.i18n
.rpmmacros
.ssh
.tcshrc
tmp
.viminfo
.zlogout
.zprofile
.zshenv
.zshrc
```
## 3 Создайте таймер который будет вызывать выполнение одноимённого systemd юнита каждые 5 минут
Немного изменим юнит:
```bash
[Unit]
Description = Task 2 script

[Service]
Type=oneshot
ExecStart=/home/student/Tasks_241/5-Systemd/script.sh

[Install]
WantedBy=multi-user.target
```
Таймер:
```bash
[Unit]
Description = My timer
Requires=my5script.service

[Timer]
Unit=my5script.service
OnUnitActiveSec=1min
OnCalendar=*:0/5

[Install]
WantedBy=timers.target
```
## 4 От какого пользователя вызыаются юниты поумолчанию?
От root'а.
## 5 Создайте пользователя от имени которого будет выполняться ваш скрипт
```bash
sudo useradd scripter
```
## 6 Дополните юнит информацией о пользователе от которого должен выплняться скрипт
```bash
[Unit]
Description = Task 2 script

[Service]
Type=oneshot
User=scripter
ExecStart=/home/student/Tasks_241/5-Systemd/script.sh

[Install]
WantedBy=multi-user.target
```
## 7 Дополните ваш скрипт так, что бы он независимо от местоположения всега выполнялся в домашней папке того кто его вызывает
```bash
#!/bin/bash
set -euo pipefail

if [ ! -d "~/papka" ]; then
        mkdir ~/papka
fi
cd ~/papka

date >> 1

cat /proc/version >> 2

hostname >> 3

ls -a ~ >> 4
```
