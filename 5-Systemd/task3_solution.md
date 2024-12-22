# Журнальчики

## 1 Посмотретите журналы sshd
```bash
...
-- Boot d2a1b1785b4548d0a5f47887e793fe8f --
ноя 14 16:45:05 alt-server systemd[1]: Starting OpenSSH server daemon...
ноя 14 16:45:05 alt-server systemd[1]: Started OpenSSH server daemon.
ноя 14 16:45:05 alt-server sshd[2354]: Server listening on 0.0.0.0 port 22.
ноя 14 16:45:05 alt-server sshd[2354]: Server listening on :: port 22.
ноя 14 16:49:19 alt-server sshd[2601]: UNKNOWN USER from 10.0.3.1 port 45078
ноя 14 16:49:19 alt-server sshd[2601]: Connection closed by UNKNOWN USER 10.0.3.1 port 45078 [preauth]
ноя 14 16:51:03 alt-server sshd[2354]: Received signal 15; terminating.
ноя 14 16:51:03 alt-server systemd[1]: Stopping OpenSSH server daemon...
ноя 14 16:51:03 alt-server systemd[1]: sshd.service: Deactivated successfully.
ноя 14 16:51:03 alt-server systemd[1]: Stopped OpenSSH server daemon.
-- Boot b49399cdc22d4352b33c56ddc29c75ba --
ноя 14 16:51:25 alt-server systemd[1]: Starting OpenSSH server daemon...
ноя 14 16:51:25 alt-server systemd[1]: Started OpenSSH server daemon.
ноя 14 16:51:25 alt-server sshd[2347]: Server listening on 0.0.0.0 port 22.
ноя 14 16:51:25 alt-server sshd[2347]: Server listening on :: port 22.
ноя 14 16:51:26 alt-server sshd[2347]: Received signal 15; terminating.
ноя 14 16:51:26 alt-server systemd[1]: Stopping OpenSSH server daemon...
ноя 14 16:51:26 alt-server systemd[1]: sshd.service: Deactivated successfully.
ноя 14 16:51:26 alt-server systemd[1]: Stopped OpenSSH server daemon.
ноя 14 16:51:26 alt-server systemd[1]: Starting OpenSSH server daemon...
ноя 14 16:51:26 alt-server systemd[1]: Started OpenSSH server daemon.
ноя 14 16:51:26 alt-server sshd[2359]: Server listening on 0.0.0.0 port 22.
```
## 2 Выведите журналы в реальном времени
```bash
journalctl -f
дек 22 23:50:12 S-vm-202 systemd[1]: Stopping User Runtime Directory /run/user/0...
дек 22 23:50:12 S-vm-202 systemd[1]: run-user-0.mount: Deactivated successfully.
дек 22 23:50:12 S-vm-202 systemd[1]: user-runtime-dir@0.service: Deactivated successfully.
дек 22 23:50:12 S-vm-202 systemd[1]: Stopped User Runtime Directory /run/user/0.
дек 22 23:50:12 S-vm-202 systemd[1]: Removed slice User Slice of UID 0.
дек 22 23:51:14 S-vm-202 ntpd[2335]: no reply from 37.228.93.242 received in time, next query 614s
дек 22 23:52:06 S-vm-202 ntpd[2335]: reply from 193.35.49.242: offset -0.009374 delay 0.048714, next query 305s
дек 22 23:52:36 S-vm-202 systemd[33382]: Created slice User Background Tasks Slice.
дек 22 23:52:36 S-vm-202 systemd[33382]: Starting Cleanup of User's Temporary Files and Directories...
дек 22 23:52:36 S-vm-202 systemd[33382]: Finished Cleanup of User's Temporary Files and Directories.

```
## 3 Выведите лог в реальном времени для службы sshd
```bash
journalctl -u sshd -f
дек 22 07:55:22 S-vm-202 sshd[29185]: Connection reset by 35.203.211.189 port 62822 [preauth]
дек 22 18:37:51 S-vm-202 sshd[31041]: Connection reset by 162.216.149.28 port 60872 [preauth]
дек 22 20:43:27 S-vm-202 sshd[31411]: pam_tcb(sshd:auth): Authentication failed for student from (uid=0)
дек 22 20:43:29 S-vm-202 sshd[31411]: Failed password for student from 31.29.217.113 port 51980 ssh2
дек 22 20:43:39 S-vm-202 sshd[31411]: pam_tcb(sshd:auth): Authentication passed for student from (uid=0)
дек 22 20:43:39 S-vm-202 sshd[31411]: Accepted password for student from 31.29.217.113 port 51980 ssh2
дек 22 20:43:39 S-vm-202 sshd[31411]: pam_tcb(sshd:session): Session opened for student by (uid=0)
дек 22 23:47:17 S-vm-202 sshd[33376]: pam_tcb(sshd:auth): Authentication passed for student from (uid=0)
дек 22 23:47:17 S-vm-202 sshd[33376]: Accepted password for student from 31.29.217.113 port 53412 ssh2
дек 22 23:47:17 S-vm-202 sshd[33376]: pam_tcb(sshd:session): Session opened for student by (uid=0)

```
## 4 Можно ли без команды journalctl прочитать логи systemd?
Файлы хранятся в бинарном формате, поэтому нормально их просмотреть с помощью cat или nano не получится.
## 5 Сколько будет 2-2?
0?
![](Milly.png)
