# Ключики

## 1 Что такое ssh ключи и зачем они нужны?
Это пара открытого и закрытого ключей для алгоритмов цифровой подписи. Представляют собой строку символов определенного формата. Нужны для шифрования данных для передачи по каналу подключения ssh, а также для проверки личности подключаемой машины.
## 2 Как их создать?
С помощью команды ssh-keygen. Также можно с помощью параметра -t указать тип алгоритма цифр. подписи (напр., ed_25519).
## 3 Создайте пару публичный/приватный ключ ed_25519, где они хранятся?
```bash
ssh-keygen -t ed25519
Generating public/private ed25519 key pair.
Enter file in which to save the key (/home/ssh-user0/.ssh/id_ed25519): /home/ssh-user0/.ssh/id_ed25519
Enter passphrase (empty for no passphrase):
Enter same passphrase again:
Your identification has been saved in /home/ssh-user0/.ssh/id_ed25519.
Your public key has been saved in /home/ssh-user0/.ssh/id_ed25519.pub.
The key fingerprint is:
SHA256:VgcNBAPcNFTCvA4TsipQA/is5r7pjg02u6gyGEs1RRQ ssh-user0@fresh7partly
The key's randomart image is:
+--[ED25519 256]--+
|o.  oEoBB+=o     |
|. o ..o ++ ..    |
| + ..o . .. .    |
|. oo. o .. .     |
|.....  +S        |
|+o.    ..        |
|**               |
|O++              |
|XX+              |
+----[SHA256]-----+
```
Они хранятся по пути, который вы указывате.
## 4 Скопируйте публичный ключ на ваш сервер, в каком файле он будет храниться?
```bash
ssh-copy-id maleha
/usr/bin/ssh-copy-id: INFO: Source of key(s) to be installed: "/home/maleha/.ssh/id_ed25519.pub"
/usr/bin/ssh-copy-id: INFO: attempting to log in with the new key(s), to filter out any that are already installed
/usr/bin/ssh-copy-id: INFO: 1 key(s) remain to be installed -- if you are prompted now it is to install the new keys
maleha@192.168.0.184's password:

Number of key(s) added: 1

Now try logging into the machine, with:   "ssh 'maleha'"
and check to make sure that only the key(s) you wanted were added.
```
В /home/maleha/.ssh/authorized_keys, т. к. я указывал, что хочу заходить за maleha. А так в общем ключи будут храниться в /home/[user]/.ssh/authorized_keys, где вместо [user] пользователь под которым разрешено входить.
## 5 Попробуйте подключиться к серверу, у вас запросили пароль?
```bash
ssh maleha
Last login: Wed Jan 15 21:33:49 2025 from 192.168.0.153
[maleha@host-184 ~]$

```
Нет.
## 6 Запретите подключение с паролем для всех пользователей, оставьте только с помощью ключа.
До запрета (подключался от ssh-user0, его публичный ключ не отправлял):
```bash
ssh maleha@192.168.0.184
maleha@192.168.0.184's password:
Last login: Wed Jan 15 22:08:30 2025 from 192.168.0.153
```
В файле /etc/openssh/sshd_config должны быть указаны параметры:
```bash
PubkeyAuthentication yes
PasswordAuthentication no
```
После для ssh-user0 незя:
```bash
ssh maleha@192.168.0.184
ssh: maleha@192.168.0.184: Permission denied (publickey).
```
Для maleha (у меня если что основная учетка одинаково называется и на этой машине и на сервере):
```bash
ssh maleha
Last login: Wed Jan 15 22:15:05 2025 from 192.168.0.153
[maleha@host-184 ~]$

```
