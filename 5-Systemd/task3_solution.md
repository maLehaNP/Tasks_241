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

## 3 Выведите лог в реальном времени для службы sshd

## 4 Можно ли без комады journalctl прочитать логи systemd?

## 5 Сколько будет 2-2?
0?
