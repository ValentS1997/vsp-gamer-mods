# VSP Valheim Dedicated Server — инструкция администратора

**Дата:** 2026-11-01 · **Система:** Proxmox VM9001 / Debian 13 / Docker Compose / Valheim + BepInEx 5.  
**Статус:** тестовый забег идёт, подключение по WAN подтверждено, окончательная проверка резервирования и security ещё не завершена.

**Адрес:** `valheim.vsp-corp.ru:2456` (Steam, UDP 2456–2457). Из HOME/LAB: `10.97.1.20:2456`.

Основание: [AS_BUILT_2026-11-01.md](AS_BUILT_2026-11-01.md), [операционные проверки](OPERATIONS_AND_ACCEPTANCE_2026-11-01.md), [upstream Docker image](https://github.com/community-valheim-tools/valheim-server-docker). Приведённые параметры — наблюдавшееся состояние на 2026-11-01, а не гарантия текущего runtime при последующих изменениях.

## 1. Как устроен сервер

Игрок → OpenWrt → `10.97.1.20:2456–2457/udp` → Docker container `valheim-server` → игровой процесс + BepInEx.

| Компонент | Значение |
|---|---|
| Proxmox | VMID `9001`, PVE name `game-server-01` |
| Debian | Version 13 Trixie, hostname `valheim-server`, user `vspadmin` |
| Ресурсы | 4 vCPU, 12 GiB RAM |
| Storage | `/dev/sdb` ext4, mount `/srv/valheim`, отдельно от системного диска |
| Docker | Engine 29.9.2, Compose v5.6.1 (ранее подтверждено) |
| Image | `ghcr.io/community-valheim-tools/valheim-server:1.4.0` |
| Container / Compose service | `valheim-server` / `valheim` |
| Backend | Steam, `CROSSPLAY=false` |
| Рабочий мир | `Valheim` |
| Тестовый мир | `VSP_DS_TEST`, сохранён отдельно |
| BepInEx | 43 DLL импортированы; log: 40 plugins to load, 39 loaded, 1 skipped, 0 failed |

Docker-контейнер контролирует **supervisord**: процессы `valheim-updater` (игра и обновления), `valheim-server` (игра), `valheim-backup` (архивы). `docker ps Up` означает запущенный контейнер, но **не всегда готовность игры**. Для проверки используем `supervisorctl` и строки `Opened Steam server` в логах.

Все постоянные данные живут в bind mounts `/srv/valheim/config` и `/srv/valheim/server-data`. Контейнер можно пересоздать, **но нельзя удалять/перезаписывать файлы мира на хосте**.

## 2. Карта каталогов

| Каталог / файл | Для чего |
|---|---|
| `/srv/valheim/compose/compose.yaml` | Основной Docker Compose; параметры игры, порты, mounts |
| `/srv/valheim/compose/secrets/server_pass` | **Действующий пароль игры**, секрет; не хранить в Git |
| `/srv/valheim/compose/valheim.env` | Старый env после миграции, **не** актуальный источник пароля |
| `/srv/valheim/config/worlds_local/Valheim/` | **Live world**; chunk-based сохранения |
| `/srv/valheim/config/worlds_local/VSP_DS_TEST/` | Сохранённый тестовый мир |
| `/srv/valheim/config/bepinex/plugins/` | Серверные DLL и ресурсы модов |
| `/srv/valheim/config/bepinex/` | CFG, JSON, YAML и данные BepInEx/модов |
| `/srv/valheim/config/backups/` | Автоматические локальные ZIP резервные копии |
| `/srv/valheim/server-data/` | Постоянные данные установки игры/SteamCMD |
| `/srv/valheim/share/` | Staging и Samba share для импорта с ПК |
| `/srv/valheim/share/worlds_local/Valheim/` | Исходная импортированная копия (не live) |
| `/srv/valheim/share/BepInExPack_Valheim/BepInEx/` | Исходный клиентский BepInEx |
| `/srv/valheim/rollback/` | Pre-migration backup и другие rollback-файлы |
| `/mnt/pve-net-smb/` | Удалённая CIFS-шара; автоматическое off-host резервирование **ещё не создано** |

Samba: `\\10.97.1.20\valheim-share` → `/srv/valheim/share`. CIFS: `//10.97.253.10/pve-net-smb` → `/mnt/pve-net-smb`, automount после reboot и read/write/delete проверены.

## 3. Ежедневные операции

Все команды выполняются **по SSH внутри `valheim-server`**. Не путать остановку игрового контейнера и выключение VM.

### Проверка — только чтение

```bash
findmnt /srv/valheim
sudo docker ps --format 'table {{.Names}}\t{{.Status}}\t{{.Ports}}'
sudo docker exec valheim-server supervisorctl status
```

**STOP:** если `findmnt` не показывает отдельный data mount `/srv/valheim` — сперва устранить проблему storage; запуск с отсутствующим mount может записать данные на root-диск.

### Запуск (и создание контейнера, если нужно)

```bash
cd /srv/valheim/compose
sudo docker compose up -d
```

### Старт ранее остановленного контейнера

```bash
cd /srv/valheim/compose
sudo docker compose start valheim
```

### Корректная остановка

Предупредить игроков, дождаться выхода, затем:

```bash
cd /srv/valheim/compose
sudo docker compose stop -t 120 valheim
```

### Перезапуск

```bash
cd /srv/valheim/compose
sudo docker compose restart -t 120 valheim
```

**После редактирования `compose.yaml`:** выполняется `sudo docker compose up -d`, поскольку `restart` не обновляет определение контейнера.

### Логи и диагностика

```bash
sudo docker logs -f --tail 100 valheim-server
```

Выход `Ctrl+C` прекращает просмотр логов, не останавливает сервер.

```bash
sudo docker exec valheim-server supervisorctl status
sudo docker logs valheim-server 2>&1 |
  grep -iE 'plugins to load|Chainloader startup complete|Opened Steam server|exception|error' |
  tail -70
```

Последний результат: **39 loaded / 1 skipped / 0 failed**, Steam server открыт. Кто именно был `skipped` — [Needs confirmation].

**Не использовать для штатной остановки:** `docker kill`, `docker compose down -v` и `docker system prune -a`.

## 4. Как изменять настройки сервера

Главный файл `/srv/valheim/compose/compose.yaml`. Изменения — в согласованное окно, после backup.

```bash
cd /srv/valheim/compose
sudo cp -a compose.yaml "compose.yaml.bak-$(date +%Y%m%d-%H%M%S)"
sudo nano compose.yaml
sudo docker compose config -q
```

| Переменная | Эффект |
|---|---|
| `SERVER_NAME` | Имя в игре (при миграции — `VSP Valheim`) |
| `WORLD_NAME` | Какой каталог мира открыть (сейчас `Valheim`) |
| `SERVER_PUBLIC` | Отображать ли сервер в Steam browser |
| `SERVER_PORT` | Основной порт 2456; смена требует согласования Docker/OpenWrt |
| `CROSSPLAY` | При `false` Steam-only; `true` переключает backend и требует отдельного теста модов/сетей |
| `BEPINEX` | Включение BepInEx — оставлять включённым для этой сборки |
| `SERVER_PASS_FILE` | Путь внутри контейнера `/run/secrets/server_pass` |
| `UPDATE_CRON` / `UPDATE_IF_IDLE` | Периодичность и условия обновления игры |
| `RESTART_CRON` / `RESTART_IF_IDLE` | Периодичность штатных перезапусков |
| `BACKUPS_CRON` / `BACKUPS_MAX_AGE` | Частота и хранение локальных backups |

**`WORLD_NAME` — не команда переименования.** Не переключать мир без проверки файлов и резервных копий. Полный runtime Compose может содержать приватные данные — публиковать его в Git/чат без ревизии нельзя.

После корректного редактирования и выхода игроков:

```bash
cd /srv/valheim/compose
sudo docker compose up -d
sudo docker compose ps
sudo docker exec valheim-server supervisorctl status
```

**Rollback:** вернуть точный `compose.yaml.bak-...` в `compose.yaml`, проверить `docker compose config -q` и `up -d`. Не перезаписывать игровой мир при откате одного Compose.

## 5. Как менять конфиги модов

Рабочее дерево: `/srv/valheim/config/bepinex/`. Внутри есть CFG, YAML, JSON, директории `EpicLoot/`, `StarLevelSystem/`, `shudnal.ConditionalConfigSync/` и другие.

Найти нужные файлы:

```bash
sudo find /srv/valheim/config/bepinex -type f \
  \( -iname '*epicloot*' -o -iname '*starlevel*' \)
```

Порядок: **backup мира + конфига → игроки вышли → stop → edit → проверка синтаксиса → start → log + gameplay acceptance**. Hot reload не предполагается, пока он не подтверждён конкретным модом.

Пример: сначала заменить путь фактическим.

```bash
FILE="/srv/valheim/config/bepinex/example.cfg"
sudo cp -a -- "$FILE" "$FILE.bak-$(date +%Y%m%d-%H%M%S)"
sudo nano "$FILE"
```

После изменения конфигов обычно требуется restart игрового процесса. При ошибке восстановить старый файл и проверить версию мода.

## 6. Как добавлять и обновлять моды

Рабочие DLL: `/srv/valheim/config/bepinex/plugins/`. Ресурсы и конфиги могут лежать в соседних папках. **Нельзя целиком копировать Windows BepInExPack поверх Linux-серверной установки.**

1. Сверить совместимость Valheim/BepInEx/Jötunn и зависимости, решить server/client scope.
2. Скачать моды сначала в `/srv/valheim/share`, проверить файлы и версии.
3. Сделать backup мира, live DLL и конфигов, согласовать остановку.
4. Остановить `valheim`.
5. Скопировать конкретные DLL/ресурсы, сохраняя структуру папок.
6. Запустить контейнер и проверить BepInEx `failed/skipped`, Steam, подключение и объекты мира.
7. При регрессии — вернуть DLL/CFG из pre-change backup на **остановленной** игре.

Пример **не выполнять без подготовки реального файла**:

```bash
sudo install -m 0644 \
  /srv/valheim/share/NewMod.dll \
  /srv/valheim/config/bepinex/plugins/NewMod.dll
```

Плагины из `/config/bepinex/plugins` синхронизируются образом в рабочую BepInEx-директорию при запуске/обновлении. **43 DLL ≠ 39 plugins**: часть DLL — библиотеки, один plugin был skipped.

## 7. Как обновлять Valheim, BepInEx и образ

Образ поддерживает автоматические проверки Steam server и BepInExPack (upstream default — каждые 15 минут при простое). **Реальная настройка `UPDATE_CRON` на VM после миграции [Needs verification].**

Безопасно проверить значения без вывода пароля:

```bash
sudo docker exec valheim-server bash -c '
. /usr/local/etc/valheim/defaults
printf "UPDATE_CRON=%s\n" "$UPDATE_CRON"
printf "UPDATE_IF_IDLE=%s\n" "$UPDATE_IF_IDLE"
printf "RESTART_CRON=%s\n" "$RESTART_CRON"
printf "RESTART_IF_IDLE=%s\n" "$RESTART_IF_IDLE"
printf "BACKUPS_CRON=%s\n" "$BACKUPS_CRON"
'
```

**Ручной запрос update check** (перед ним backup и выход игроков):

```bash
sudo docker exec valheim-server \
  supervisorctl signal HUP valheim-updater
sudo docker logs -f --tail 100 valheim-server
```

Это запрашивает проверку, а не принудительно устанавливает любую версию; при `UPDATE_IF_IDLE=true` процесс может её отложить.

**Обновление самого Docker image — отдельная операция.** До неё сверить release notes, текущий тег/sha и сохранить backup мира и конфигураций. Затем в окне обслуживания:

```bash
cd /srv/valheim/compose
sudo docker compose pull valheim
sudo docker compose up -d valheim
```

Изменение тега `image:` требует отдельной правки Compose. После update нужна полная проверка игры, BepInEx и мира. Откат старого образа **не откатывает** мир, если новый сервер изменил формат сохранения.

## 8. Как изменить пароль сервера

Файл действующего пароля: `/srv/valheim/compose/secrets/server_pass`; это read-only bind mount внутри контейнера. Пароль не публиковать и не копировать в Git.

Выполнить **после согласования смены**; пароль вводится через tty, без эха:

```bash
sudo bash <<'EOF'
set -euo pipefail
FILE=/srv/valheim/compose/secrets/server_pass
test -f "$FILE"
read -r -s -p "New password: " P1 </dev/tty; echo
read -r -s -p "Confirm: " P2 </dev/tty; echo
if [ "$P1" != "$P2" ] || [ "$(printf %s "$P1" | wc -c)" -lt 5 ]; then
  echo "Password mismatch or too short"
  exit 1
fi
umask 077
TMP=$(mktemp /srv/valheim/compose/secrets/.server_pass.XXXXXX)
trap 'rm -f "$TMP"' EXIT
printf '%s\n' "$P1" > "$TMP"
chmod 600 "$TMP"
mv -f "$TMP" "$FILE"
unset P1 P2
echo "Password file updated; recreate container after players exit."
EOF
```

Чтобы новый inode файла попал в bind mount, после выхода игроков:

```bash
cd /srv/valheim/compose
sudo docker compose up -d --force-recreate valheim
```

Проверить подключение с новым паролем. Старый пароль не должен оставаться в открытых конфигурациях/логе.

## 9. Как делать backup

Локальные ZIP создаёт `valheim-backup` в `/srv/valheim/config/backups/`. В логах наблюдался `worlds-20261101-110204.zip` с `Valheim` и `VSP_DS_TEST`.

**Принудительно создать локальную резервную копию:**

```bash
sudo docker exec valheim-server \
  supervisorctl restart valheim-backup
sudo ls -lh /srv/valheim/config/backups/ | tail -15
```

При сохранении мира во время архивирования новый chunk-формат может дать предупреждение; готовый ZIP не равен протестированному восстановлению.

Перед крупным обновлением: дополнительно делать **offline snapshot после правильной остановки игрового процесса** (мир, конфиги, DLL, Compose, inventory версий).

**P0, ещё не сделано:** автоматический off-host backup на `/mnt/pve-net-smb` с проверкой checksum/retention и тестом restore. Локальные ZIP и мир — один failure domain (`/dev/sdb`). CIFS mount сам не является резервным копированием.

**Restore:** не распаковывать архив поверх запущенного `worlds_local/Valheim`. Сначала остановка, проверка архива, отдельный каталог восстановления, затем изолированный игровой тест. Полного restore drill пока нет.

## 10. Как перезагружать VM

Для планового reboot без игроков:

```bash
cd /srv/valheim/compose
sudo docker compose stop -t 120 valheim
sudo reboot
```

**Важное ограничение:** `docker compose stop` может сохранить состояние «остановлен» после reboot. Для **теста автозапуска** VM такую предварительную остановку не использовать без отдельно подготовленного тест-плана и проверки restart policy. После перезагрузки при необходимости запустить `docker compose up -d` вручную.

Проверить после загрузки:

```bash
findmnt /srv/valheim
sudo ufw status verbose
sudo docker ps
sudo docker exec valheim-server supervisorctl status
timeout 15 ls /mnt/pve-net-smb
findmnt -t cifs /mnt/pve-net-smb
```

После reboot ранее подтвердились data disk, CIFS automount и Docker **до** установки UFW/миграции модов. Полная проверка нынешнего состояния — PENDING.

## 11. Защита сети

OpenWrt `firewall.prowrt_valheim_wan` разрешает WAN DNAT **только UDP 2456–2457** → `10.97.1.20`. DNS `valheim.vsp-corp.ru` → CNAME `edge.vsp-corp.ru` → `92.255.183.46`. Владелец подтвердил внешнее игровое подключение.

UFW Debian: `deny incoming`, `allow outgoing`; SSH TCP 22 — `10.97.0.10` и LAB /24; Samba TCP 445 — HOME/LAB. Docker DNAT/forwarding **обходит обычные UFW INPUT**, поэтому не считать `ufw status` полной проверкой доступности Docker.

**PENDING:** отрицательные тесты WAN SSH/SMB/других портов и LAN regression после DNAT. Известный debt: широкое правило HOME→LAB all-IPv4 и LAB /24 разрешение к удалённому SMB 445; менять только отдельным сетевым change request.

## 12. Шпаргалка

Все `docker compose ...` выполнять из `/srv/valheim/compose`.

| Действие | Команда |
|---|---|
| Запуск | `sudo docker compose up -d` |
| Старт существующего контейнера | `sudo docker compose start valheim` |
| Остановка | `sudo docker compose stop -t 120 valheim` |
| Перезапуск | `sudo docker compose restart -t 120 valheim` |
| Статус | `sudo docker ps` |
| Состояние игры | `sudo docker exec valheim-server supervisorctl status` |
| Логи | `sudo docker logs -f --tail 100 valheim-server` |
| Локальный backup | `sudo docker exec valheim-server supervisorctl restart valheim-backup` |
| Проверка Compose | `sudo docker compose config -q` |
| Data disk | `findmnt /srv/valheim` |
| UFW | `sudo ufw status verbose` |
| CIFS | `findmnt -t cifs /mnt/pve-net-smb` |

**Правило изменений:** read-only preflight → backup → окно обслуживания → одно контролируемое изменение → проверка логов и игрового клиента → rollback, если проверка не прошла.

## 13. Статус и приоритеты

**PASS:** сервер и моды работают, 39 plugins loaded / 1 skipped / 0 failed, владелец подключился, по наблюдению нет заметных просадок; CIFS automount пережил reboot.  
**PENDING:** off-host backup/restore, WAN negative security tests, проверка автозапуска после установки UFW и переноса мира, причина `1 skipped`, полный многопользовательский/модовый игровой тест.

Ни пароли, ни credentials, ни игровые миры, ни ZIP/tar архивы не должны попадать в публичный GitHub.
