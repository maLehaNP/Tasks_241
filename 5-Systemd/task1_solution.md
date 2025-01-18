# Юниты

## 1 Что такое systemd юнит?
Это файл конфигурации, хранящий информацию о сервисе, сокете, и т. п.. Каждая единица может требовать другие единицы, конфликтовать с ними, запускаться до (After) или после (Before) определенной единицы.
## 2 Проверье статус любого systemd юнита, какую информацию выводит эта команда?
```bash
systemctl status alteratord.service
● alteratord.service - Alterator backend server
     Loaded: loaded (/lib/systemd/system/alteratord.service; enabled; vendor preset: disabled)
     Active: active (running) since Fri 2024-12-06 23:44:39 MSK; 9h ago
TriggeredBy: ● alteratord.socket
   Main PID: 2111 (alteratord)
      Tasks: 6 (limit: 2341)
     Memory: 13.6M
        CPU: 200ms
     CGroup: /system.slice/alteratord.service
             └─ 2111 /usr/bin/guile --no-auto-compile /usr/sbin/alteratord

дек 06 23:44:39 S-vm-202 systemd[1]: Started Alterator backend server.
```
## 3 Попробуйте остановить сервис
```bash
systemctl stop alteratord.service
```
## 4 Перезапустите его
```bash
systemctl start alteratord.service
```
## 5 Удалите из автозагрузки
```bash
systemctl disable alteratord.service
```
## 6 Верните обратно
```bash
systemctl enable --now alteratord.service
```
## 7 Что такое таймеры?
Запускает другие юниты по таймеру. Функционал похож на cron.
