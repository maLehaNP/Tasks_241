#!/bin/bash
# 2) Проверье статус любого systemd юнита
systemctl status alteratord.service
# 3) Попробуйте остановить сервис
systemctl stop alteratord.service
# 4) Перезапустите его
systemctl start alteratord.service
# 5) Удалите из автозагрузки
systemctl disable alteratord.service
# 6) Верните обратно
systemctl enable --now alteratord.service
