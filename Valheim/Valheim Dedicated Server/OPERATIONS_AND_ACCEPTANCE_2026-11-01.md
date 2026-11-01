# VSP Valheim Dedicated Server — эксплуатация, проверки и критерии приёмки

**Дата baseline:** 2026-11-01. **Назначение:** handoff для Support/Infrastructure, ежедневных операций и test-run. Все команды в разделе «Проверки» read-only; state-changing действия отделены от них. Текущую архитектуру см. [AS_BUILT_2026-11-01.md](AS_BUILT_2026-11-01.md).

## 1. Основные endpoint и пути

| Что | Значение |
|---|---|
| Игра из интернета | `valheim.vsp-corp.ru:2456` (Steam, UDP 2456–2457) |
| Игра внутри LAB/HOME | `10.97.1.20:2456` |
| SSH администрирование | `10.97.1.20:22`; ACL от `10.97.0.10` и LAB /24 |
| VM / гипервизор | VMID 9001, `valheim-server`, PVE `game-server-01` |
| Host data | `/srv/valheim` (отдельный ext4 disk, не root partition) |
| Compose | `/srv/valheim/compose/compose.yaml` |
| Live world | `/srv/valheim/config/worlds_local/Valheim` |
| Original world | `/srv/valheim/share/worlds_local/Valheim` (не редактировать) |
| Live BepInEx | `/srv/valheim/config/bepinex` |
| Staged BepInEx | `/srv/valheim/share/BepInExPack_Valheim/BepInEx` |
| Secret path (НЕ содержимое!) | `/srv/valheim/compose/secrets/server_pass` |
| Local Samba share | `\\10.97.1.20\valheim-share` → `/srv/valheim/share` |
| Remote CIFS | `//10.97.253.10/pve-net-smb` → `/mnt/pve-net-smb` |
| Local Valheim backups | `/srv/valheim/config/backups` |
| Migration rollback | `/srv/valheim/rollback/pre-migration-20261101-110140` |

## 2. Быстрая read-only диагностика

Запускать на Debian госте. Ниже нет изменения конфигурации, перезапуска или записи секретов:

```bash
sudo bash <<'EOF'
echo "== BOOT & DATA =="
uptime -s
findmnt /srv/valheim
df -h /srv/valheim

echo "== SERVICES =="
systemctl is-active docker || true
systemctl is-active smbd || true
systemctl is-enabled ufw || true
grep '^ENABLED=' /etc/ufw/ufw.conf || true
ufw status verbose

echo "== CIFS AUTOMOUNT =="
UNIT=$(systemd-escape -p --suffix=automount /mnt/pve-net-smb)
systemctl is-active "$UNIT" || true
timeout 15 ls /mnt/pve-net-smb || true
findmnt -t cifs /mnt/pve-net-smb || true

echo "== DOCKER =="
docker ps --format 'table {{.Names}}\t{{.Status}}\t{{.Ports}}'
cd /srv/valheim/compose
docker compose config -q
docker exec valheim-server supervisorctl status || true

echo "== PUBLISHED PORTS =="
docker port valheim-server || true

echo "== RECENT LOG ERRORS =="
docker logs --tail 250 valheim-server 2>&1 |
  grep -iE 'plugins to load|Chainloader startup complete|Opened Steam server|error|exception' |
  tail -60 || true

echo "== WORLD & BACKUPS =="
find /srv/valheim/config/worlds_local -maxdepth 2 -type f -name '*.fwl2' -printf '%P\n'
ls -lh /srv/valheim/config/backups | tail -10

echo "== COMPLETE =="
EOF
```

**Интерпретация:** `docker ps Up` — состояние контейнера, не гарантия загрузки игры; `supervisorctl` и startup logs показывают игровой процесс. `ufw status active` важнее одного `systemctl is-active ufw`: при первоначальной активации UFW вручную oneshot unit показывал `inactive (dead)` при активных правилах. После следующего reboot проверить обе стороны и фактический nft filter.

## 3. Reboot persistence acceptance

Последняя проверка после reboot была **до** установки UFW и до финальной миграции. Тогда подтвердились:
- ext4 `/dev/sdb` → `/srv/valheim`: PASS;
- `mnt-pve\x2dnet\x2dsmb.automount`: `generated`/`active`, при обращении CIFS успешно поднялся: PASS;
- Docker контейнер `Up`, `smbd active`: PASS.

**Обязательный новый checkpoint после согласованной перезагрузки:** `findmnt /srv/valheim`, `systemctl is-enabled ufw`, `ufw status verbose`, `docker ps`, `docker exec ... supervisorctl status`, `timeout 15 ls /mnt/pve-net-smb`, `findmnt -t cifs`, доступность SSH/SMB, LAN и WAN подключения. Первый reboot не доказывает устойчивость CIFS при недоступном удалённом SMB-сервере; тест outage/recovery отдельно [Needs confirmation].

**Rollback при потере SSH из-за UFW:** через консоль Proxmox VM9001 `sudo ufw disable` (аварийная временная мера), после этого сравнить ACL с предыдущим состоянием, вернуть минимальные правила, восстановить UFW. Не отключать глобальный firewall как постоянное решение.

## 4. Backup: текущее состояние и проектируемая цель

**Что подтверждено:**
- встроенный `valheim-backup` supervisor process создавал ZIP в `/srv/valheim/config/backups/worlds-20261101-110204.zip`, архив включал `Valheim` и `VSP_DS_TEST`;
- в логе также были строки «Removing all but the newest 6 backups» и «Removing backups older than 3 days»; количество версий и фактический cron-конфиг при следующей загрузке нужно проверить;
- pre-migration tar лежит в `rollback/pre-migration-20261101-110140`;
- CIFS `/mnt/pve-net-smb` после reboot доступен по SMB 3.1.1, отдельный тест read/write/delete PASS.

**Что НЕ сделано:** нет подтверждённого автоматического off-host копирования ZIP/мира на CIFS, нет проверенного каталога назначения, нет теста распаковки/restore в отдельное тестовое окружение, нет проверенной политики retention на remote share.

**Предлагаемая схема (ещё НЕ применена):**
1. Зафиксировать каталог назначения на `pve-net-smb`, владельца, права, квоту и политику хранения.
2. Брать подтверждённо завершённые локальные ZIP (не копировать открытые `*.chunk` посреди сохранения), сверять checksum и размер на удалённой стороне.
3. Для automation: отдельный systemd timer/service, `RequiresMountsFor=/mnt/pve-net-smb` или явная проверка `findmnt -t cifs` перед записью, логирование и alert при ошибке.
4. Не удалять локальный архив, если удалённая копия не подтверждена; не использовать `rsync --delete` без dry-run и approval.
5. Restore drill выполнять в отдельном изолированном каталоге/мире, с остановленным игровым процессом при необходимости, без перезаписи live `Valheim`.
6. Критерий PASS: корректный полный архив на remote SMB, проверенный checksum, успешное восстановление тестовой копии и документированное RPO/RTO.

**Критичный риск:** единственный текущий data disk VM и локальные ZIP на нём — один failure domain. SMB mount сам по себе не является резервным копированием.

## 5. Игровые и модовые тесты

| Acceptance | Текущий статус | Способ довести до PASS |
|---|---|---|
| Steam server online | PASS | Лог `Opened Steam server` |
| Модлоадер | PASS: 39 loaded/1 skipped/0 failed | Установить identity пропущенного плагина по полному логу |
| Реальный вход клиента | PASS_OWNER_CONFIRMED | Повторить после будущего reboot |
| Задержки/FPS | PASS_OWNER_REPORTED (субъективно) | Если нужна SLA — замеры ping, tick, CPU, RAM, packet loss |
| Сохранение игрового мира | Создана и импортирована структурно согласованная копия | Проверить постройки, события, предметы, модовые объекты |
| Multiplayer 2–3 players | [Needs confirmation] | Тест 2–3 одновременных подключений |
| LAN регрессия после DNAT | PENDING | Тест из `10.97.0.0/24` → `10.97.1.20:2456` |
| Внешняя доступность | PASS_OWNER_CONFIRMED | Дополнительно журналировать время/исходный IP теста |
| WAN отрицательные security-тесты | PENDING | С внешней сети проверить, что TCP 22/445 и нерелевантные сервисы не доступны |
| Password/auth | Действует новый пароль, пользователь вошёл | Не логировать пароль; проверять только функционально |
| Autostart после текущих изменений | PENDING | Reboot verification после UFW и импорта |
| Off-host backup+restore | PENDING | Процедура выше |

## 6. Firewall: текущая модель доверия

**OpenWrt edge:**
- только `firewall.prowrt_valheim_wan` перенаправляет WAN UDP 2456–2457 на `10.97.1.20`;
- DNS `valheim.vsp-corp.ru` → `edge.vsp-corp.ru` → `92.255.183.46`;
- `nat_reflection=false`; из LAN использовать внутренний адрес, если split DNS/hairpin не настроен;
- SSH и SMB **не включались** в WAN DNAT; отрицательные тесты ещё нужны;
- `firewall.prowrt_home_to_lab_initial` разрешает **весь IPv4-трафик HOME/LAB** — открытый security debt; не ужесточать без инвентаризации потребителей;
- отдельный SMB доступ LAB → 10.97.253.10:445 разрешён источникам LAB /24 вместо одной VM; это шире минимально необходимого.

**Debian host UFW:** `deny incoming`, `allow outgoing`; SSH `10.97.0.10/32` плюс `10.97.1.0/24`; SMB `10.97.0.0/24` плюс `10.97.1.0/24`. Не публиковать firewall/SSH на внешнем интерфейсе.

**Docker:** backend iptables-nft; в `FORWARD` сначала `DOCKER-USER`, пустая цепочка на дату аудита; DNAT `10.97.1.20:2456–2457/udp` → `172.18.0.2`. UFW INPUT не защищает опубликованные порты Docker так же, как host services. Сейчас межзональная защита игрового трафика делегирована OpenWrt; дополнительных `DOCKER-USER` правил не добавляли. Вручную не редактировать Docker-managed nft table.

## 7. Сопровождение и правила изменений

- **Не устанавливать/обновлять моды прямо в работающем live мире** без preflight: снимок текущих DLL/CFG, версия игры, идентификатор пакета, backup мира, список конфликтов, окно обслуживания, rollback.
- **Не копировать целиком Windows BepInExPack** поверх server install. Только `config/bepinex/plugins`, `config/bepinex/config` и необходимые ресурсы; это соответствует схеме текущего образа. Текущая конфигурация уже скопирована.
- **Не путать плановый манифест с фактическим импортом**. Проверить клиентские/серверные различия, DLC/mod-specific prefabs и пропущенный плагин.
- **Секреты не хранить в Git**: `valheim.env`, `compose/secrets/server_pass`, `/etc/samba/credentials/pve-net-smb`, локальные или GitHub secrets, авторизационные токены. Не выводить `docker compose config` или `cat secrets` в публичный лог.
- Миграцию или rollback выполнять с остановленным Valheim process и отдельной ручной проверкой мира; сам факт наличия tar не подтверждает возможность восстановления.
- **Security acceptance отдельно от connectivity acceptance**. Рабочее подключение снаружи не доказывает закрытие SSH/SMB.

## 8. Приоритеты текущего test-run

1. **P0** — зафиксировать/автоматизировать внешний backup на CIFS и протестировать restore.
2. **P0** — выполнить WAN negative security tests TCP 22/445 и LAN regression.
3. **P1** — повторно проверить reboot persistence после UFW/текущего Compose.
4. **P1** — выяснить 1 skipped BepInEx plugin, проверить функциональность CGM, объекты мира и несколько одновременных игроков.
5. **P2** — security change request по чрезмерно широкому `Allow-HOME-to-LAB-Initial` и SMB LAB /24; поэтапно, с rollback.
6. **P2** — отдельное решение о метриках, мониторинге, retention и штатных обновлениях.

## 9. Точки отката и управление инцидентами

| Уровень | Ссылка |
|---|---|
| Мир/моды/Compose до миграции | `/srv/valheim/rollback/pre-migration-20261101-110140/pre-migration.tar.gz` |
| Тестовый мир | `/srv/valheim/config/worlds_local/VSP_DS_TEST` |
| Неизменённый исходный мир | `/srv/valheim/share/worlds_local/Valheim` |
| OpenWrt WAN pre-change backup | `/root/firewall-before-valheim-wan-20261101-175257` (на OpenWrt) |
| OpenWrt SMB pre-change backup | `/root/firewall-before-lab-smb-20261101-160924` (на OpenWrt) |
| Host UFW pre-change backup | `/root/ufw-pre-stage5-<timestamp>` [точная запись не передана] |

**Вердикт снимка:** test-run уже доступен из LAN и WAN; эксплуатация продолжается. Security и disaster-recovery acceptance **не** закрыты.
