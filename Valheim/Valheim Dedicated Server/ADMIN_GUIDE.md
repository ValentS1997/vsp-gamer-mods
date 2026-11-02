# Valheim: руководство администратора

**Адрес сервера для игроков:** `valheim.vsp-corp.ru:2456`. Из сетей HOME/LAB можно подключаться по адресу `10.97.1.20:2456`.

Это руководство помогает проверить сервер, безопасно его остановить, изменить настройки, обновить моды и сохранить мир. Все команды выполняются **по SSH на виртуальной машине `valheim-server`**, а не на компьютере игрока или хосте Proxmox.

Описанное состояние зафиксировано **1 ноября 2026 года**. После этой даты настройки могли измениться, поэтому перед работой проверяйте сервер. Подробная история развёртывания и проверок: [фактическая конфигурация](AS_BUILT_2026-11-01.md) и [операционные проверки](OPERATIONS_AND_ACCEPTANCE_2026-11-01.md).

## Перед любой работой

Запомните три правила:

1. **Сначала проверьте диск:** `findmnt /srv/valheim` должен показывать отдельный подключённый раздел. Если его нет, не запускайте контейнер: данные могут записаться на системный диск.
2. **Перед изменениями сохраните мир и настройки.** Предупредите игроков и дождитесь, пока они выйдут.
3. **Не удаляйте и не перезаписывайте рабочий мир.** Контейнер Docker можно пересоздать; файлы мира хранятся отдельно на хосте.

Обычный порядок работы: проверить состояние → сделать резервную копию → дождаться выхода игроков → внести одно изменение → проверить логи и вход в игру → при проблеме откатить изменение.

## 1. Как устроен сервер

Игрок подключается через OpenWrt к `10.97.1.20` по UDP-портам `2456–2457`. На виртуальной машине игра работает в Docker-контейнере `valheim-server` вместе с BepInEx и модами.

| Компонент | Состояние на 1 ноября 2026 года |
|---|---|
| Proxmox | VMID `9001`, имя `game-server-01` |
| Виртуальная машина | Debian 13 Trixie, hostname `valheim-server`, пользователь `vspadmin`; 4 vCPU, 12 GiB RAM |
| Диск с данными | `/dev/sdb`, ext4, подключён в `/srv/valheim` отдельно от системного диска |
| Docker | Engine 29.9.2, Compose v5.6.1 — версии подтверждались ранее |
| Образ | `ghcr.io/community-valheim-tools/valheim-server:1.4.0` |
| Compose-сервис / контейнер | `valheim` / `valheim-server` |
| Игровой режим | Steam, `CROSSPLAY=false` |
| Мир | Рабочий `Valheim`; тестовый `VSP_DS_TEST` хранится отдельно |
| BepInEx | Импортировано 43 DLL; при последней проверке: 39 плагинов загружено, 1 пропущен, ошибок загрузки нет |

Внутри контейнера `supervisord` управляет тремя процессами: `valheim-server` запускает игру, `valheim-updater` проверяет обновления, `valheim-backup` создаёт архивы.

Статус `Up` у Docker означает, что **контейнер** запущен. Игра при этом может ещё загружаться. Для проверки готовности смотрите состояние процессов и строку `Opened Steam server` в логах.

Постоянные данные находятся в `/srv/valheim/config` и `/srv/valheim/server-data`. Пересоздание контейнера не должно удалять эти каталоги.

## 2. Где лежат файлы

| Путь | Что там находится |
|---|---|
| `/srv/valheim/compose/compose.yaml` | Основные настройки контейнера, игры, портов и подключённых каталогов |
| `/srv/valheim/compose/secrets/server_pass` | **Действующий пароль игры** |
| `/srv/valheim/compose/valheim.env` | Старый файл после миграции; пароль из него больше не берётся |
| `/srv/valheim/config/worlds_local/Valheim/` | **Рабочий игровой мир** |
| `/srv/valheim/config/worlds_local/VSP_DS_TEST/` | Отдельно сохранённый тестовый мир |
| `/srv/valheim/config/bepinex/plugins/` | Серверные DLL и ресурсы модов |
| `/srv/valheim/config/bepinex/` | Конфиги и данные BepInEx и модов |
| `/srv/valheim/config/backups/` | Локальные автоматические ZIP-копии |
| `/srv/valheim/server-data/` | Постоянные файлы игры и SteamCMD |
| `/srv/valheim/share/` | Папка для передачи файлов с ПК; Samba-адрес `\\10.97.1.20\valheim-share` |
| `/srv/valheim/share/worlds_local/Valheim/` | Исходная импортированная копия мира, **не рабочий мир** |
| `/srv/valheim/share/BepInExPack_Valheim/BepInEx/` | Исходный клиентский BepInExPack |
| `/srv/valheim/rollback/` | Копия до миграции и другие файлы для отката |
| `/mnt/pve-net-smb/` | Удалённая CIFS-папка `//10.97.253.10/pve-net-smb` |

Для CIFS-папки проверены подключение после перезагрузки и операции чтения, записи и удаления. **Автоматическое резервное копирование в неё ещё не настроено.** Само наличие подключённой сетевой папки не создаёт копию мира.

## 3. Проверка, запуск и остановка

### Проверить состояние

Эти команды ничего не меняют:

```bash
findmnt /srv/valheim
sudo docker ps --format 'table {{.Names}}\t{{.Status}}\t{{.Ports}}'
sudo docker exec valheim-server supervisorctl status
```

**Если `findmnt` не показывает отдельный диск в `/srv/valheim`, остановитесь и сначала разберитесь с подключением диска.**

### Запустить сервер

Все команды `docker compose` ниже выполняйте из рабочего каталога:

```bash
cd /srv/valheim/compose
```

Запуск с созданием контейнера, если он отсутствует:

```bash
sudo docker compose up -d
```

Если контейнер уже существует и был просто остановлен:

```bash
sudo docker compose start valheim
```

### Остановить или перезапустить

Предупредите игроков и дождитесь их выхода. Затем выберите нужную команду:

```bash
# Корректная остановка
sudo docker compose stop -t 120 valheim

# Корректный перезапуск
sudo docker compose restart -t 120 valheim
```

После изменения `compose.yaml` используйте `sudo docker compose up -d`: команда `restart` не применяет новое определение контейнера.

Для штатной остановки **не используйте** `docker kill`, `docker compose down -v` и `docker system prune -a`.

### Посмотреть логи

```bash
sudo docker logs -f --tail 100 valheim-server
```

`Ctrl+C` прекращает просмотр логов, но не останавливает сервер. Чтобы быстро найти сообщения о модах, запуске Steam и ошибках:

```bash
sudo docker exec valheim-server supervisorctl status
sudo docker logs valheim-server 2>&1 |
  grep -iE 'plugins to load|Chainloader startup complete|Opened Steam server|exception|error' |
  tail -70
```

При последней проверке BepInEx сообщил `39 loaded / 1 skipped / 0 failed`; Steam-сервер открылся. Какой именно плагин был пропущен, ещё предстоит выяснить.

## 4. Изменение основных настроек

Главный файл — `/srv/valheim/compose/compose.yaml`. Меняйте его в согласованное окно после резервного копирования.

```bash
cd /srv/valheim/compose
sudo cp -a compose.yaml "compose.yaml.bak-$(date +%Y%m%d-%H%M%S)"
sudo nano compose.yaml
sudo docker compose config -q
```

Последняя команда проверяет синтаксис Compose. Если она сообщает об ошибке, исправьте её **до запуска**.

| Параметр | Назначение |
|---|---|
| `SERVER_NAME` | Название в игре; при миграции было `VSP Valheim` |
| `WORLD_NAME` | Каталог мира; сейчас `Valheim` |
| `SERVER_PUBLIC` | Показывать ли сервер в списке Steam |
| `SERVER_PORT` | Основной порт `2456`; при смене придётся согласовать Docker и OpenWrt |
| `CROSSPLAY` | При `false` используется Steam; смена режима требует проверки сети и модов |
| `BEPINEX` | Включает BepInEx; для этой сборки оставьте включённым |
| `SERVER_PASS_FILE` | Путь к паролю внутри контейнера: `/run/secrets/server_pass` |
| `UPDATE_CRON`, `UPDATE_IF_IDLE` | Расписание и условия обновлений игры |
| `RESTART_CRON`, `RESTART_IF_IDLE` | Расписание и условия плановых перезапусков |
| `BACKUPS_CRON`, `BACKUPS_MAX_AGE` | Частота и срок хранения локальных копий |

**`WORLD_NAME` переключает мир, а не переименовывает его.** Перед переключением проверьте файлы нужного мира и резервные копии.

Когда игроки вышли, примените настройки и проверьте состояние:

```bash
sudo docker compose up -d
sudo docker compose ps
sudo docker exec valheim-server supervisorctl status
```

Если результат плохой, верните сохранённый `compose.yaml.bak-...` в `compose.yaml`, повторите `sudo docker compose config -q` и `sudo docker compose up -d`. При откате одного Compose-файла **не заменяйте игровой мир**.

Полный вывод Compose может содержать закрытые данные. Проверяйте его перед публикацией в Git или чате.

## 5. Изменение конфигов модов

Настройки модов находятся в `/srv/valheim/config/bepinex/`. Там встречаются CFG, JSON, YAML и каталоги отдельных модов, включая `EpicLoot/`, `StarLevelSystem/` и `shudnal.ConditionalConfigSync/`.

Например, найти файлы Epic Loot и Star Level System можно так:

```bash
sudo find /srv/valheim/config/bepinex -type f \
  \( -iname '*epicloot*' -o -iname '*starlevel*' \)
```

Порядок изменения: сохраните мир и конкретный конфиг → дождитесь выхода игроков → остановите сервер → измените файл и проверьте его формат → запустите сервер → посмотрите логи и проверьте мод в игре. Не рассчитывайте на применение настроек «на лету», пока это не подтверждено для конкретного мода.

Перед правкой файла сделайте его отдельную копию. **Замените путь в примере на фактический:**

```bash
FILE="/srv/valheim/config/bepinex/example.cfg"
sudo cp -a -- "$FILE" "$FILE.bak-$(date +%Y%m%d-%H%M%S)"
sudo nano "$FILE"
```

Если возникла ошибка, на остановленном сервере верните прежний файл и проверьте совместимость версии мода.

## 6. Добавление и обновление модов

Рабочие DLL находятся в `/srv/valheim/config/bepinex/plugins/`; ресурсы и настройки могут лежать рядом. **Не копируйте целиком клиентский Windows BepInExPack поверх серверной установки Linux.**

1. Проверьте совместимость мода с Valheim, BepInEx, Jötunn и другими зависимостями. Уточните, нужен ли мод только серверу или также клиентам.
2. Сначала загрузите файлы в `/srv/valheim/share/`, проверьте версии и содержимое.
3. Сохраните копии мира, рабочих DLL и конфигов. Согласуйте время остановки.
4. Дождитесь выхода игроков и остановите `valheim`.
5. Перенесите только нужные DLL и ресурсы, сохраняя структуру папок.
6. Запустите сервер. Проверьте ошибки и пропуски BepInEx, открытие Steam-сервера, вход игрока и объекты мира.
7. При проблеме остановите игру и верните прежние DLL и конфиги.

Пример копирования **после проверки фактического файла**:

```bash
sudo install -m 0644 \
  /srv/valheim/share/NewMod.dll \
  /srv/valheim/config/bepinex/plugins/NewMod.dll
```

Образ синхронизирует плагины из `/config/bepinex/plugins` в рабочую папку BepInEx при запуске или обновлении. Число DLL не обязано совпадать с числом загруженных плагинов: некоторые DLL — библиотеки.

## 7. Обновление игры, BepInEx и Docker-образа

Образ поддерживает автоматические проверки обновлений игры и BepInExPack. В исходном образе проверка по умолчанию выполняется каждые 15 минут при простое; **фактическое значение `UPDATE_CRON` на этой VM после миграции ещё не подтверждено**. Проверить настройки без вывода пароля можно так:

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

Чтобы вручную **запросить проверку обновлений**, сначала сохраните копию и дождитесь выхода игроков:

```bash
sudo docker exec valheim-server \
  supervisorctl signal HUP valheim-updater
sudo docker logs -f --tail 100 valheim-server
```

Команда запрашивает проверку, а не принудительную установку любой новой версии. Если `UPDATE_IF_IDLE=true`, процесс может отложить обновление.

Обновление самого Docker-образа — отдельная операция. Сначала изучите заметки к выпуску, запишите текущий тег или SHA и сохраните мир с конфигурацией. В окно обслуживания выполните:

```bash
cd /srv/valheim/compose
sudo docker compose pull valheim
sudo docker compose up -d valheim
```

Если меняется тег `image:`, его нужно отдельно поправить в Compose. После обновления проверьте запуск игры, BepInEx, подключение и мир. Возврат старого образа **не откатит мир**, если новый сервер уже изменил формат сохранения.

## 8. Смена пароля

Действующий пароль лежит в `/srv/valheim/compose/secrets/server_pass`. Не публикуйте его в Git, чате или логах. Смена пароля требует согласования и проверки входа после изменения.

Следующая команда запрашивает новый пароль дважды без отображения ввода, проверяет совпадение и минимальную длину, затем заменяет файл:

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

После выхода игроков **пересоздайте** контейнер, чтобы он заново подключил заменённый файл пароля:

```bash
cd /srv/valheim/compose
sudo docker compose up -d --force-recreate valheim
```

Проверьте подключение с новым паролем. Убедитесь, что старый пароль не остался в открытых конфигурациях и логах.

## 9. Резервные копии и восстановление

Процесс `valheim-backup` создаёт локальные ZIP в `/srv/valheim/config/backups/`. В логах ранее наблюдался архив с мирами `Valheim` и `VSP_DS_TEST`.

Запросить новую локальную копию и посмотреть список архивов:

```bash
sudo docker exec valheim-server \
  supervisorctl restart valheim-backup
sudo ls -lh /srv/valheim/config/backups/ | tail -15
```

Во время записи мира архивирование нового chunk-формата может выдать предупреждение. **Наличие ZIP не доказывает, что из него получится восстановить сервер.** Перед крупным обновлением дополнительно сделайте копию на остановленной игре: сохраните мир, конфиги, DLL, Compose и сведения о версиях.

**Главная незавершённая задача:** настроить автоматическое копирование за пределы игрового диска, в `/mnt/pve-net-smb`, с проверкой контрольных сумм, сроков хранения и пробным восстановлением. Сейчас локальные ZIP и мир находятся на одном диске `/dev/sdb`; при его отказе можно потерять и оригинал, и копии.

При восстановлении **не распаковывайте архив поверх запущенного** `worlds_local/Valheim`. Остановите сервер, проверьте архив, распакуйте его в отдельный каталог и сначала проведите изолированный игровой тест. Полное пробное восстановление пока не проводилось.

## 10. Перезагрузка виртуальной машины

Для плановой перезагрузки дождитесь выхода игроков:

```bash
cd /srv/valheim/compose
sudo docker compose stop -t 120 valheim
sudo reboot
```

После загрузки проверьте диск, сеть, Docker, игру и CIFS-папку:

```bash
findmnt /srv/valheim
sudo ufw status verbose
sudo docker ps
sudo docker exec valheim-server supervisorctl status
timeout 15 ls /mnt/pve-net-smb
findmnt -t cifs /mnt/pve-net-smb
```

Предварительная остановка через Compose может сохранить состояние «остановлен» после перезагрузки. Если контейнер не поднялся, запустите его вручную через `sudo docker compose up -d`. Для отдельного теста автозапуска не выполняйте предварительную остановку без подготовленного плана и проверки restart policy.

Ранее после перезагрузки проверялись диск с данными, CIFS automount и Docker, но это было **до** установки UFW и переноса модов. Полная проверка нынешнего состояния ещё ожидается.

## 11. Сеть и доступ

OpenWrt перенаправляет из интернета **только UDP `2456–2457`** на `10.97.1.20`. DNS-имя `valheim.vsp-corp.ru` указывает через `edge.vsp-corp.ru` на `92.255.183.46`. Подключение игрока из внешней сети подтверждено.

На Debian UFW по умолчанию запрещает входящие соединения и разрешает исходящие. SSH (`TCP 22`) разрешён с `10.97.0.10` и сети LAB `/24`; Samba (`TCP 445`) — из HOME/LAB. При этом Docker DNAT и forwarding могут обходить обычные правила UFW INPUT, поэтому вывод `ufw status` **не является полной проверкой сетевой доступности контейнера**.

Ещё нужны отрицательные проверки доступа из интернета к SSH, SMB и прочим портам, а также повторная проверка LAN после DNAT. Известные широкие правила HOME→LAB all-IPv4 и доступа LAB `/24` к удалённому SMB `445` следует менять только отдельным сетевым изменением.

## 12. Короткая шпаргалка

Для всех команд `docker compose` сначала выполните `cd /srv/valheim/compose`.

| Действие | Команда |
|---|---|
| Проверить диск | `findmnt /srv/valheim` |
| Запустить или создать контейнер | `sudo docker compose up -d` |
| Запустить остановленный контейнер | `sudo docker compose start valheim` |
| Остановить после выхода игроков | `sudo docker compose stop -t 120 valheim` |
| Перезапустить после выхода игроков | `sudo docker compose restart -t 120 valheim` |
| Посмотреть контейнер | `sudo docker ps` |
| Проверить процессы игры | `sudo docker exec valheim-server supervisorctl status` |
| Смотреть логи | `sudo docker logs -f --tail 100 valheim-server` |
| Запросить локальную копию | `sudo docker exec valheim-server supervisorctl restart valheim-backup` |
| Проверить Compose | `sudo docker compose config -q` |
| Проверить UFW | `sudo ufw status verbose` |
| Проверить CIFS | `findmnt -t cifs /mnt/pve-net-smb` |

## 13. Что уже проверено и что осталось сделать

**Проверено на 1 ноября 2026 года:** сервер доступен из внешней сети; владелец подключился; BepInEx загрузил 39 плагинов без ошибок, один пропустил; заметных просадок в наблюдавшемся тесте не было; CIFS automount пережил перезагрузку.

**Осталось проверить:** копирование за пределы игрового диска и восстановление; недоступность служебных портов из интернета; автозапуск после нынешних изменений; причину пропуска плагина; полноценную игру с несколькими игроками и модами.

Пароли, учётные данные, файлы миров и ZIP/tar-архивы **не должны попадать в публичный GitHub**.
