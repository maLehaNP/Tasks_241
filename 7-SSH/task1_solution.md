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
Нужно раскомментить PermitRootLogin
```bash
# Authentication:

#LoginGraceTime 2m
PermitRootLogin without-password
#StrictModes yes
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
Нужно раскомментить MaxAuthTries
```bash
# Authentication:

#LoginGraceTime 2m
PermitRootLogin without-password
#StrictModes yes
MaxAuthTries 6
```
После:
```bash
```
## 8 Создайте пользователя ssh-user и попробуйте им подключиться к серверу

## 9 Ограничте ему возможность подключения к серверу

## 10 Как вы это сделали?

## 11 Что хранится в файле known_hosts?
