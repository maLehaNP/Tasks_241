# Настриваем

## 1 Какой по умолчанию используется порт для поключения?
Порт 22.
## 2 Можно ли его изменить? если да то как?
Да. Нужно в конфиге /etc/openssh/sshd_config раскомментить строку
```bash
#Port 22
```
и заменить порт 22 на нужный.
## 3 Какая служба отвечает за обработку запросов на подключения по ssh?
sshd.service
## 4 Какой файл конфигурации отвечает за его настройку?
/etc/openssh/sshd_config (/etc/ssh/sshd_config)
## 5 Попробуйте подключиться по ssh к предоставленному вам серверу
```bash
ssh -p 202 student@95.31.204.147
student@95.31.204.147's password:
Last login: Mon Dec 23 19:04:58 2024 from 95.104.137.136

```
## 6 Отредактируйте файл настроек на сервере так, чтобы была возможность подключиться к серверу используя пользователя root
Нужно раскомментить PermitRootLogin (а также PermitEmptyPasswords и изменить его на "yes").
```bash
# Authentication:

#LoginGraceTime 2m
PermitRootLogin without-password
#StrictModes yes
```
```bash
# To disable tunneled clear text passwords, change to no here!
PasswordAuthentication yes
PermitEmptyPasswords yes
```
## 7 Измените колличество ошибок ввода пароля перед сборосом соединения, покажите эти измененения
До:
```bash
ssh -p 202 student@95.31.204.147
student@95.31.204.147's password:
ssh: Permission denied, please try again.
student@95.31.204.147's password:
ssh: Permission denied, please try again.
student@95.31.204.147's password:
ssh: student@95.31.204.147: Permission denied (publickey,password).
```
Нужно раскомментить и изменить MaxAuthTries
```bash
# Authentication:

#LoginGraceTime 2m
PermitRootLogin without-password
#StrictModes yes
MaxAuthTries 1
```
А также перезапустить sshd
```bash
sudo systemctl restart sshd
```
После:
```bash
ssh -p 202 student@95.31.204.147
student@95.31.204.147's password:
ssh: Received disconnect from 95.31.204.147 port 202:2: Too many authentication failures
Disconnected from 95.31.204.147 port 202
```
## 8 Создайте пользователя ssh-user и попробуйте им подключиться к серверу
```bash
sudo adduser ssh-user
id ssh-user
uid=505(ssh-user) gid=506(ssh-user) группы=506(ssh-user)
sudo passwd ssh-user
```
```bash
ssh -p 202 ssh-user@95.31.204.147
ssh-user@95.31.204.147's password: 
[ssh-user@S-vm-202 ~]$

```
## 9 Ограничте ему возможность подключения к серверу
Не будет давать подключиться, хоть я и ввожу пароль правильно.
```bash
ssh -p 202 ssh-user@95.31.204.147
ssh-user@95.31.204.147's password:
ssh: Permission denied, please try again.
ssh-user@95.31.204.147's password:
ssh: Permission denied, please try again.
ssh-user@95.31.204.147's password:
ssh: ssh-user@95.31.204.147: Permission denied (publickey,password).
```
## 10 Как вы это сделали?
Добавил правило DenyUsers для пользователя ssh-user, которое отказывает подключения к нему.
```bash
# Authentication:

#LoginGraceTime 2m
PermitRootLogin without-password
#StrictModes yes
#MaxAuthTries 6
#MaxSessions 10
DenyUsers ssh-user
```
## 11 Что хранится в файле known_hosts?
Сохраненные сопоставления серверов и их открытых ключей. Это позволяет сервису ssh сопоставить открытый ключ, которая отсылает машина, к которой подлючаемся, с ключом этой машины в файле. Ключи вписываются в файл при первом подключении или вручную.
