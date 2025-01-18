# Cети
## 1 Выведите список интерфейсов, какими способами можно это сделать?
С помощью `ifconfig', 'ls /sys/class/net`, а также 'ip link' или 'ip a'.
```bash
[maleha@host-184 ~]$ ifconfig
enp4s0    Link encap:Ethernet  HWaddr C8:60:00:A2:78:C8
          inet addr:192.168.0.184  Bcast:192.168.0.255  Mask:255.255.255.0
          inet6 addr: fe80::ca60:ff:fea2:78c8/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:8694 errors:0 dropped:0 overruns:0 frame:0
          TX packets:7305 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:1145041 (1.0 MiB)  TX bytes:1855958 (1.7 MiB)

lo        Link encap:Local Loopback
          inet addr:127.0.0.1  Mask:255.0.0.0
          inet6 addr: ::1/128 Scope:Host
          UP LOOPBACK RUNNING  MTU:65536  Metric:1
          RX packets:38 errors:0 dropped:0 overruns:0 frame:0
          TX packets:38 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:6263 (6.1 KiB)  TX bytes:6263 (6.1 KiB)
```
```bash
[maleha@host-184 ~]$ ls /sys/class/net
enp4s0  lo
```
```bash
[maleha@host-184 ~]$ ip link
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN mode DEFAULT group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
2: enp4s0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP mode DEFAULT group default qlen 1000
    link/ether c8:60:00:a2:78:c8 brd ff:ff:ff:ff:ff:ff
```

## 2 Попробуйте изменить ip адрес
Не дает изменить адрес основного интерфеса:
```bash
[maleha@host-184 ~]$ nmcli connection
NAME           UUID                                  TYPE      DEVICE
System enp4s0  2103f9de-6dd6-564d-2fc8-7caf444dad76  ethernet  enp4s0
lo             1d6e7696-fe0c-4ffe-bd58-95e4e2bb7f33  loopback  lo
[maleha@host-184 ~]$ sudo nmcli con mod "System enp4s0" ipv4.addresses 192.168.0.183/24
Ошибка: не удалось изменить подключение «System enp4s0»: failed to update connection: settings plugin does not support modifying connections
```
Поэтому не буду рисковать и изменю адрес loopback'а (был 127.0.0.1/8):
```bash
[maleha@host-184 ~]$ sudo nmcli con mod "lo" ipv4.addresses 127.0.0.2/8
[maleha@host-184 ~]$ ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.2/8 brd 127.255.255.255 scope host lo
       valid_lft forever preferred_lft forever
    inet 127.0.0.1/8 brd 127.255.255.255 scope host secondary lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host
       valid_lft forever preferred_lft forever
```

## 3 Попробуте добавить несколько ip адресов на сетевую карту
Добавил два оканчивающиеся на 185 и 186:
```bash
[maleha@host-184 ~]$ sudo ip addr add 192.168.0.185/255.255.255.0 dev enp4s0
[maleha@host-184 ~]$ sudo ip addr add 192.168.0.186/255.255.255.0 dev enp4s0
[maleha@host-184 ~]$ ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host
       valid_lft forever preferred_lft forever
2: enp4s0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    link/ether c8:60:00:a2:78:c8 brd ff:ff:ff:ff:ff:ff
    inet 192.168.0.184/24 brd 192.168.0.255 scope global dynamic noprefixroute enp4s0
       valid_lft 29928sec preferred_lft 29928sec
    inet 192.168.0.185/24 scope global secondary enp4s0
       valid_lft forever preferred_lft forever
    inet 192.168.0.186/24 scope global secondary enp4s0
       valid_lft forever preferred_lft forever
    inet6 fe80::ca60:ff:fea2:78c8/64 scope link
       valid_lft forever preferred_lft forever
```

## 4 Выведите список маршрутов
```bash
[maleha@host-184 ~]$ ip r
default via 192.168.0.1 dev enp4s0
default via 192.168.0.1 dev enp4s0 proto dhcp src 192.168.0.184 metric 100
192.168.0.0/24 dev enp4s0 proto kernel scope link src 192.168.0.184 metric 100
[maleha@host-184 ~]$ route -n
Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
0.0.0.0         192.168.0.1     0.0.0.0         UG    0      0        0 enp4s0
0.0.0.0         192.168.0.1     0.0.0.0         UG    100    0        0 enp4s0
192.168.0.0     0.0.0.0         255.255.255.0   U     100    0        0 enp4s0
```

## 5 Выведите arp таблицу
```bash
[maleha@host-184 ~]$ arp -a
_gateway (192.168.0.1) at 5c:62:8b:db:72:06 [ether] on enp4s0
? (192.168.0.153) at 54:35:30:62:25:01 [ether] on enp4s0
```

## 6 Что такое ip адрес?
Это адрес, определяемый протоколом IP (Internetwork Protocol). Он состоит из 4 байтов, записываемых обычно в десятичной системе счисления и разделяемых точкой. Они нужны, т. к. аппаратные адреса в большинстве случаев могут быть уникальны только в рамках одный среды. Локальная сеть имеет тоже свой собственный адрес, поэтому при обращении к к-л устройству его ip адрес будет разделен на 2 части: слева сколько-то битов отводится под адрес сети, остальные - под адрес абонента в этой сети.

## 7 Для чего нужны маршруты?
Для отправки пакетов данных получателю за пределами локальной сети отправителя. Для этого данные отправляются спец. абоненту (маршрутизатору), который подключен к нескольким сетям и обязуется пересылать пакеты между ними по определенным правилам. Вот и получается, что чтобы данные дошли до получателя, им придется пролететь по иногда довольно длинному маршруту.

## 8 Что за протокол arp?
ARP (англ. Address Resolution Protocol — протокол определения адреса) — протокол в компьютерных сетях, предназначенный для определения MAC-адреса другого компьютера по известному IP-адресу. Известен своими ARP-таблицами, которые отражают соответствия IP- и MAC-адресов.

## 9 Что такое dhcp?
DHCP (Dynamic Host Configuration Protocol)  — протокол прикладного уровня модели TCP/IP, служит для назначения IP-адреса клиенту. IP-адрес можно назначать вручную каждому клиенту, то есть компьютеру в локальной сети. Но в больших сетях это очень трудозатратно, к тому же, чем больше локальная сеть, тем выше возрастает вероятность ошибки при настройке. Поэтому для автоматизации назначения IP был создан протокол DHCP.

## 10 Что такое dns?
Система доменных имен (DNS) представляет собой распределенную систему хранения и обработки информации о доменных зонах. Она необходима, в первую очередь, для соотнесения IP-адресов устройств в сети и более удобных для человеческого восприятия символьных имен. Состоит из распределенной базы имен, чья структура напоминает логическое дерево.

## 11 Как называется один из протоколов синхронизации времени?
Протокол сетевого времени (NTP) — это протокол, который помогает синхронизировать время устройств в сети. Внешним источником точного времени, к которому делается запрос, является NTP-сервер синхронизации времени.

## 12 Что такое широковещательный запрос, зачем он нужен?
Если идентификатор получателя (MAC-адреес его Ethernet-карты) неизвестен, используется аппаратный широковещательный адрес, который позволяет обратиться сразу ко всем устройствам в данной сети. Сетевая карта, получив широковещательный фрейм или фрейм, MAC-адрес получателя в котором совпадает с её MAC-адресом, обязана отправить его на обработку системе.

## 13 Какой адресс является широковещательным?
FF:FF:FF:FF:FF:FF

## 14 Какие ещё параметры можно задать сетевой карте?
Помимо одного или нескольких IP-адресов (IPv4, IPv6), можно еще назначить ей её MAC-адрес, повозившись можно даже изменить зашитый в сам интерфейс MAC-адрес.

## 15 Что такое маска подсети? зачем она нужна?
Сетевая маска, напр. 255.255.255.0, это набор битов определенного формата, с помощью которого можно указать какая часть IP-адреса отводится под адрес сети. Это нужно, чтобы отправитель пакета мог наложить маску на IP-адрес получателя и таким образом понять, находится ли получатель в одной локальной сети с отправителем, что в свою очередь упрощает задачу отправки, т. к. MAC-адрес получателя должен быть известен.
