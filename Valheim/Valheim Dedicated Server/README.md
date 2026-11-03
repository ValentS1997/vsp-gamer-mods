# VSP Gamer — Valheim Dedicated Server

**Статус на 2026-11-01:** сервер **развёрнут, моды загружены, тестовый забег идёт**. Внутреннее и публичное подключение к Valheim подтверждено владельцем. Финальная приёмка security, автономного backup/restore и повторной проверки после reboot **не закрыта**.

> **Адрес игроков:** **valheim.vsp-corp.ru:2456** (Steam backend, UDP 2456–2457).  
> **Важно:** это рабочий тестовый сервер, не полностью принятый production сервис.

## Документы — канонические источники

| Файл | Что содержит |
|---|---|
| [PVE_LAB_POWER_CYCLE_2026-11-04.md](PVE_LAB_POWER_CYCLE_2026-11-04.md) | **Порядок включения PVE-LAB → разблокировки → VM 9001 → Docker → безопасного выключения**, проверенный вывод `qm list/start` от 04.11 |
| [ADMIN_GUIDE.md](ADMIN_GUIDE.md) | **Инструкция администратора:** запуск/остановка, пути, настройки, моды, обновления, пароль, backup и reboot |
| [AS_BUILT_2026-11-01.md](AS_BUILT_2026-11-01.md) | История создания: Proxmox VM, Debian 13, storage, Docker, конфигурация Valheim, BepInEx, импорт мира и 43 DLL, Samba/CIFS, сетевые инциденты, UFW, WAN DNAT/DNS, подтверждённые тесты и rollback |
| [OPERATIONS_AND_ACCEPTANCE_2026-11-01.md](OPERATIONS_AND_ACCEPTANCE_2026-11-01.md) | Read-only диагностика, reboot и game acceptance, backup/restore plan, firewall security, обслуживание и приоритеты рисков |
| [HANDOFF.yaml](HANDOFF.yaml) | Машиночитаемый snapshot v2 для продолжения работы в новых ChatGPT-чатах и передачи в смежные проекты |

Клиентская сборка и плановые моды ведутся отдельно: [Valheim/MOD_MANIFEST_2026-10-24.md](../MOD_MANIFEST_2026-10-24.md). Не считать плановый Git manifest точным перечнем runtime DLL на dedicated server.

## Схема окружения

| Компонент | Состояние на последнем checkpoint |
|---|---|
| Платформа | Proxmox VMID **9001**, PVE **game-server-01** |
| Гость | **Debian 13** / **valheim-server**, 4 vCPU, 12 GiB RAM |
| LAB IPv4 | **10.97.1.20/24**, gateway **10.97.1.1** |
| Данные | **/dev/sdb**, ext4 → **/srv/valheim**, persistent после reboot |
| Docker | Engine 29.9.2 / Compose v5.6.1; image **ghcr.io/community-valheim-tools/valheim-server:1.4.0** |
| Game | Steam backend; world name в Compose **Valheim**; тестовый мир **VSP_DS_TEST** сохранён |
| BepInEx | **43 DLL** скопированы; логи **40 plugins to load / 39 loaded / 1 skipped / 0 failed** |
| Public DNS | **valheim.vsp-corp.ru** CNAME → **edge.vsp-corp.ru** → **92.255.183.46** |
| OpenWrt | `firewall.prowrt_valheim_wan`: только **WAN UDP 2456–2457** → **10.97.1.20** |
| Host firewall | UFW active; deny incoming; SSH HOME admin + LAB; Samba HOME/LAB |
| Обмен файлами | `\\10.97.1.20\valheim-share` → `/srv/valheim/share` |
| Remote CIFS | `//10.97.253.10/pve-net-smb` → `/mnt/pve-net-smb`, automount после reboot **PASS** |
| Backup | Встроенные локальные ZIP создаются; off-host копирование и restore drill **PENDING** |

## Вехи создания

1. Получена и подготовлена Debian VM на отдельном persistent data disk; установлен Docker из официального репозитория, затем Valheim Dedicated Server в Compose.
2. Запущен тестовый vanilla мир `VSP_DS_TEST`, сервер сохранил мир; BepInEx в image проверен.
3. Настроен локальный Samba share для импорта данных с игрового ПК.
4. Настроен удалённый CIFS `pve-net-smb`; исправлены две независимые проблемы: OpenWrt TCP 445 ACL и credentials-файл. После reboot automount и R/W/delete подтвердились.
5. В `share` загружены мир `Valheim` (новый chunk-формат) и пакет BepInEx с 43 DLL/130 config files.
6. Контейнер остановлен, подготовлен rollback, мир/моды/конфиги скопированы в live volume, секрет вынесен в password file, Compose переключён на `Valheim`.
7. Новый модовый сервер стартовал; лог BepInEx `39 loaded, 1 skipped, 0 failed`, Steam открыт, владелец успешно подключился, заметных просадок в ходе теста нет.
8. Настроен Debian UFW и подтверждены цепочки Docker iptables-nft/`DOCKER-USER`.
9. OpenWrt Stage003 выполнил WAN UDP DNAT, DNS и тест внешнего подключения: **PASS_OWNER_CONFIRMED**.

## Контроль качества и незакрытые задачи

**Уже подтверждено:** состояние ext4 после reboot, CIFS 3.1.1 automount, SMB create/read/delete, Docker service после ранней перезагрузки, копирование 43 DLL и мира, Chainloader без failed, LAN-подключение до WAN-изменения, публичный endpoint, тест игрового клиента.

**Нужно завершить:** off-host backup на `pve-net-smb` + restore drill; WAN negative tests TCP 22/445; LAN regression после DNAT; reboot UFW/нового Compose; identity `1 skipped`; проверку нескольких игроков и сохранности модовых объектов.

**Известный security debt:** `Allow-HOME-to-LAB-Initial` разрешает всё IPv4 HOME → LAB /24; SMB OpenWrt ACL разрешает весь LAB /24 вместо единственного game-server /32. Изменять эти правила только отдельным change request, с учётом действующих потребителей.

## Правила хранения и эксплуатации

- В публичный Git **не копировать** пароли Valheim, Samba/CIFS credentials, ключи, игровые миры, полные zip/tar backups и конфигурации с секретами.
- Файл `/srv/valheim/compose/secrets/server_pass` — секрет, а не документируемое значение. Исторический `valheim.env` не должен использоваться как текущий пароль.
- Не удалять `/srv/valheim/share`, `/srv/valheim/config/worlds_local/VSP_DS_TEST`, rollback и оригиналы до отдельной проверки recovery.
- Не считать `docker ps Up` доказательством успешной загрузки игрового процесса; см. `supervisorctl` и BepInEx/Steam logs.
- При новых изменениях: preflight → backup → scoped mutation → validation → rollback point → acceptance.

**Следующий checkpoint:** автоматизированный внешний backup + restore проверка без перерыва тестового забега, затем закрытие WAN security и reboot acceptance.

**Отдельные темы:** VSP Sleep [в отдельной папке](../Разработка%20модов/VSP-Sleep/README.md). Игровой клиент и его графические/клиентские моды не являются частью инфраструктурного deployment.
