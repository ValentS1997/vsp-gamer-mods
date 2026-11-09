# Архитектура сервера Valheim: от железа до входа игрока

**Архитектурный разбор для выступления: физическая сеть, виртуализация, контейнер и игровой мир**  
**Основа:** технический снимок 2026-11-08 · **Аудитория:** Infrastructure Support L2 / Linux / Technical Operations / Junior DevOps  
**Формат:** путь игрока через все слои системы; схемы и таблицы сохранены.

> **С чего начать рассказ.** Игрок видит один адрес Valheim. За ним стоят два физических Proxmox-хоста: PVE-NET держит сеть и OpenWrt, PVE-LAB запускает Debian VM с игровым контейнером. Пакет проходит два DNAT, а мир и конфигурация лежат на отдельном ext4-диске. Дальше пройдём этот путь по слоям — от кабеля до состояния мира.

**Как читать статусы:** **PASS** — подтверждённый вывод или тест владельца; **DESIGN** — принятое решение без подтверждённого внедрения; **PENDING** — ещё не проверено; **[Needs confirmation]** — точное значение неизвестно. Эти метки показывают, где заканчиваются факты архитектурного снимка.

## 1. Архитектура одним взглядом: физические узлы, зоны и приложение

Начну с простой карты. Слева игрок, справа игровой мир. Между ними две физические машины с разными обязанностями. Если слушатель запомнит эту схему, остальная история сложится сама.

```mermaid
flowchart TB
    INTERNET([Игроки из интернета]) --> FQDN["valheim.vsp-corp.ru:2456<br/>CNAME → edge.vsp-corp.ru"]
    FQDN --> PUBLIC["WAN 92.255.183.46<br/>UDP 2456–2457"]
    subgraph EDGE["PVE-NET · отдельный физический Firebat N100 · 8 GiB RAM"]
        PVE_NET["Proxmox pve-net<br/>MGMT 10.97.254.2 / vmbr10"]
        OW["OpenWrt VM9100<br/>wan0 / lab0 · fw4 + nftables"]
        PVE_NET --- OW
        OW -->|"DNAT WAN → LAB"| NIC3["nic3 → vmbr3 / LAB uplink"]
    end
    PUBLIC --> OW
    subgraph LAB_HOST["PVE-LAB · отдельный физический Ryzen 5 1600 · 32 GiB RAM"]
        LAB["Proxmox pve-lab<br/>vmbr0 10.97.1.2 / nic1"]
        VM["VM9001 · Debian 13<br/>4 vCPU / 12 GiB<br/>eth0 10.97.1.20"]
        CON["Docker Compose / iptables-nft<br/>10.97.1.20:2456–2457 → 172.18.0.2"]
        GAME["valheim-server · Steam / BepInEx<br/>world = Valheim"]
        DISK[("/dev/sdb → /srv/valheim<br/>ext4 / persistent data")]
        LAB --> VM --> CON --> GAME
        DISK --- VM
    end
    NIC3 -->|"Физическая LAB-линия"| LAB
    HOME["Игровой ПК · HOME<br/>10.97.0.0/24"] -->|"Маршрутизация HOME → LAB"| OW
    VM -.->|"SMB 3.1.1"| SMB["PVE-NET SMB / SERVICES<br/>10.97.253.10:445"]
```

**Почему две машины?** PVE-NET работает постоянно: он держит маршрутизацию, правила между зонами и управление сетью. PVE-LAB включается под игровые и лабораторные задачи. Если выключить LAB, Valheim пропадёт, но домашняя сеть по архитектуре должна продолжить работать. Отдельный полный тест «LAB выключен, все остальные контуры проверены» пока не зафиксирован.

| Физическая машина | Реальная роль | Последняя подтверждённая конфигурация |
|---|---|---|
| **PVE-NET** | Основной сетевой гипервизор | Firebat Intel N100, 8 GiB RAM, 4 × Intel I226-V; Proxmox VE 9.2.x; `pve-net`, MGMT `10.97.254.2/24` |
| **PVE-LAB** | Вычислительный хост игровых/лабораторных VM | ASRock B450M-HDV R4.0, AMD Ryzen 5 1600 6C/12T, 32 GiB RAM, 2 × Realtek GbE; `pve-lab`, `10.97.1.2/24` |
| **VM9100** | OpenWrt v2.0 на PVE-NET | `wan0`, `lab0`, `fw4/nftables`; рабочий WAN `92.255.183.46/23` |
| **VM9001** | Debian 13 game-server на PVE-LAB | 4 vCPU, 12 GiB; `10.97.1.20/24`, gateway `10.97.1.1`; Docker + Valheim |

Точки источников: [PVE-LAB Stage001](https://github.com/ValentS1997/pve-lab-vsp/blob/main/stages/001.Stage-Baseline/BASELINE-EVIDENCE-2026-10-28.md), [PVE-LAB Stage002](https://github.com/ValentS1997/pve-lab-vsp/blob/main/stages/002.Stage-PVE-Core/PVE-CORE-EVIDENCE-2026-10-29.md), [PrOWRT PVE-NET rename/port mapping](https://github.com/ValentS1997/PrOWRT/blob/main/docs/STAGE002-PVE-NET-RENAME-ACCEPTANCE-2026-10-29.md).

## 2. PVE-NET: четыре порта, PCI passthrough, VM bridge и сетевые зоны

На сетевой машине важно не количество портов само по себе, а то, кому принадлежит каждый путь. Один порт смотрит к провайдеру, два ведут домой, ещё один — в лабораторный хост.

```mermaid
flowchart LR
    ISP["Провайдер / Public WAN"] --> N0["nic0 · Intel I226-V"]
    AP["Archer AP / Wi-Fi"] --> N1["nic1 · Intel I226-V"]
    SW["Проводной HOME switch"] --> N2["nic2 · Intel I226-V"]
    LABPHY["Кабель к PVE-LAB"] --> N3["nic3 · Intel I226-V"]
    N0 -->|"PCI passthrough hostpci0"| W["OpenWrt VM9100 wan0"]
    N1 --> B1["PVE vmbr1"] --> H1["OpenWrt homeap0"]
    N2 --> B2["PVE vmbr2"] --> H2["OpenWrt homesw0"]
    N3 --> B3["PVE vmbr3"] --> L0["OpenWrt lab0"]
    H1 --> BR["OpenWrt HOME bridge<br/>10.97.0.0/24"]
    H2 --> BR
    M["PVE vmbr10<br/>MGMT 10.97.254.2"] <-->|"OpenWrt mgmt0 / 10.97.254.1"| MG["Management zone"]
```

**Что делает каждый слой.** Linux bridge соединяет интерфейсы внутри одного L2-сегмента, как виртуальный коммутатор. OpenWrt маршрутизирует между подсетями и применяет правила `fw4`. Публичный WAN-порт отдан виртуальной машине OpenWrt через PCI passthrough, поэтому нельзя автоматически приписывать WAN-адрес самому Proxmox. Для управления PVE-NET есть отдельные MGMT и USB OOB пути.

**Сегменты/подсети** (не называть их все «VLAN» без вывода `ip -d link`/802.1Q):

| Зона | Подсеть | Назначение | Примечание |
|---|---|---|---|
| HOME | `10.97.0.0/24` | Игровой ПК, проводные/Wi-Fi устройства | Archer и switch разделены физически, HOME — общий L2-сегмент |
| LAB | `10.97.1.0/24` | PVE-LAB и VM9001 | OpenWrt gateway `10.97.1.1` |
| SERVICES | `10.97.253.0/24` | Внутренние службы, SMB | CIFS target `10.97.253.10` |
| MGMT | `10.97.254.0/24` | Управление Proxmox/OpenWrt | `pve-net 10.97.254.2`, OpenWrt `10.97.254.1` |
| Admin VPN | `10.97.252.0/24` | План/сегмент admin VPN | Текущая operational acceptance VPN [Needs confirmation] |
| DMZ | `10.97.30.0/24` | Сегмент отдельных публичных сервисов | Не используется в текущем игровом маршруте |
| Physical OOB | `10.97.255.0/30` | Прямой USB-Ethernet PC → PVE-NET | `10.97.255.2` ↔ `10.97.255.1`, не routed gateway |

Здесь у меня есть снимок конфигурации PVE-NET от 29 октября: `net0/vmbr10/mgmt0`, `net1/vmbr1/homeap0`, `net2/vmbr2/homesw0`, `net3/vmbr3/lab0`, `hostpci0/wan0`. На PVE-LAB зафиксирован `vmbr0=10.97.1.2/24` на `nic1`. А вот точную строку `net0` у VM9001 ещё нужно получить: **[Needs confirmation]**, команда на PVE-LAB — `qm config 9001`.

## 3. Полный путь игрового UDP-пакета: две NAT-трансляции

Теперь проследим один пакет так, как будто мы идём рядом с ним. Игрок набирает имя сервера, DNS находит публичный адрес, а дальше адрес назначения меняется два раза.

```mermaid
flowchart TB
    A["Игрок: valheim.vsp-corp.ru:2456"] --> B["DNS: CNAME edge.vsp-corp.ru<br/>A 92.255.183.46"]
    B --> C["Internet packet<br/>dst=92.255.183.46:2456/udp"]
    C --> D["OpenWrt wan0 · fw4 PREROUTING<br/>DNAT → 10.97.1.20:2456"]
    D --> E["Routing + firewall forward<br/>wan → lab / lab0"]
    E --> F["PVE-LAB vmbr0 → Debian VM eth0<br/>dst=10.97.1.20:2456"]
    F --> G["Docker iptables-nft PREROUTING<br/>DNAT → 172.18.0.2:2456"]
    G --> H["FORWARD: DOCKER-USER → DOCKER-FORWARD<br/>bridge br-cf8e7a919bbe"]
    H --> I["Контейнер Valheim<br/>172.18.0.2:2456/udp"]
    I --> J["Ответ через conntrack reverse NAT<br/>публичный endpoint остаётся 92.255.183.46"]
```

| Хоп | Адрес назначения до | Адрес назначения после | Где выполняется | Что проверено |
|---|---|---|---|---|
| Public DNS | `valheim.vsp-corp.ru` | `92.255.183.46` | DNS CNAME/A | Public resolver `1.1.1.1` PASS 2026-11-01 |
| Edge DNAT | `92.255.183.46:2456/udp` | `10.97.1.20:2456/udp` | OpenWrt `fw4` / `nft` | UCI, runtime nft, DNAT counters 0→2 packets/593 bytes |
| LAB routing | `10.97.1.20` | адрес не меняется | OpenWrt `lab0` → PVE-LAB | Внешнее подключение подтвердило end-to-end путь |
| Docker DNAT | `10.97.1.20:2456/udp` | `172.18.0.2:2456/udp` | Debian `iptables-nft` | NAT rule для 2456/2457 отображён |
| Application | `172.18.0.2:2456` | Valheim process | Внутри контейнера | Успешная игровая сессия 2026-11-01 |
| Обратный путь | Ответ контейнера | Reply к внешнему клиенту | Conntrack/NAT | Подтверждено функционально, отдельный packet trace не проводили |

Для UDP 2457 путь такой же. Важно не перепутать объявленный контейнером порт и опубликованный на хосте: 2458 есть в `EXPOSE` образа, но через Docker на Debian он **не публиковался**. TCP 80/9001 тоже оставались только `EXPOSE`, без host binding.

**Как приходит ответ.** У UDP нет TCP three-way handshake, но conntrack запоминает поток и выполняет обратное преобразование NAT. Счётчик `nft` показывает, что пакеты прошли правило; он ещё не доказывает, что человек вошёл в игру. Поэтому 1 ноября я проверил именно внешний игровой вход. Отдельную трассировку ответного пакета не проводили.

## 4. Межзональные политики и три точки фильтрации

Здесь легко сказать «у меня есть firewall» и пропустить главное. Фильтрация происходит на разных участках пути, и правило на Debian не обязательно управляет трафиком, который Docker уже отправил в контейнер.

```mermaid
flowchart LR
    WAN["WAN / Internet"] --> E["OpenWrt fw4<br/>DNAT only UDP 2456–2457"]
    E --> L["LAB · 10.97.1.20"]
    HOME["HOME · 10.97.0.0/24"] --> ACL["HOME→LAB ACL<br/>широкий IPv4 allow"] --> L
    L --> U["Debian UFW INPUT<br/>SSH + SMB source rules"]
    L --> DN["Docker NAT/FORWARD<br/>DOCKER-USER пустая"] --> APP["Valheim container"]
    U --> SSH["SSH TCP 22"]
    U --> SMB["Samba TCP 445"]
```

**На внешней границе** OpenWrt направляет только UDP 2456–2457 из `wan` в `lab`: правило `firewall.prowrt_valheim_wan` / `Valheim-WAN-UDP`, `nat_reflection=false`. WAN имел публичный `92.255.183.46/23`, gateway `92.255.183.254`; CGNAT на интерфейсе не обнаружен. Из HOME игру разумнее проверять напрямую по `10.97.1.20:2456`: отражение NAT выключено.

**На самой Debian VM** UFW `0.36.2-9` был `active`, с `deny incoming / allow outgoing / deny routed` и low logging. SSH TCP 22 разрешён от `10.97.0.10` и `10.97.1.0/24`; SMB TCP 445 — от HOME `/24` и LAB `/24`. Это правила для самого хоста; опубликованные Docker порты проходят через другой путь.

**На пути к контейнеру** Docker использует `iptables v1.8.11 (nf_tables)`: FORWARD проходит через `DOCKER-USER`, затем `DOCKER-FORWARD`. `DOCKER-USER` была пустой. Опубликованный Docker порт идёт через DNAT/FORWARD, а не через обычную UFW INPUT policy для самого хоста. Поэтому наличие UFW нельзя выдавать за доказательство фильтрации контейнера; Docker-managed nftables rules вручную не правят.

**Граница политики.** `firewall.prowrt_home_to_lab_initial` разрешает весь IPv4 HOME→LAB; LAB→SERVICES TCP445 разрешён для `10.97.1.0/24`. Это фактические границы доступа на снимке, а не утверждение, что разрешён только трафик одной VM.

## 5. VM9001: Debian, виртуальные диски, Docker и управление доступом

Когда пакет добрался до LAB, он попадает в обычную Debian VM. Её удобно представлять как три части: система, данные мира и способ запустить контейнер.

```mermaid
flowchart TB
    H["PVE-LAB host · 10.97.1.2 / Proxmox"] --> VM["VM9001 / game-server-01<br/>Debian 13 · 4 vCPU · 12 GiB"]
    VM --> ETH["eth0 · 10.97.1.20/24<br/>default gw 10.97.1.1"]
    VM --> ROOT["/dev/sda1 · ~20 GB<br/>OS + Docker Engine"]
    VM --> DATA["/dev/sdb · ~20 GB · ext4<br/>mount /srv/valheim"]
    DATA --> CMP["compose/compose.yaml<br/>root:root 0640"]
    DATA --> CONF["config/ → /config<br/>мир, BepInEx, backups"]
    DATA --> GAME["server-data/ → /opt/valheim<br/>game installation"]
    DATA --> SHARE["share/ → Samba staging"]
    DATA --> ROLL["rollback/ → migration snapshot"]
```

**Что внутри VM.** Debian 13 Trixie, пользователь `vspadmin`; зафиксированы Docker Engine 29.9.2, Compose v5.6.1 и образ `ghcr.io/community-valheim-tools/valheim-server:1.4.0`. ОС и данные мира логически лежат на разных виртуальных дисках. Физический backend на PVE-LAB ещё **[Needs confirmation]**: второй `/dev/sdb` внутри VM сам по себе не означает второй независимый диск.

Данные мира смонтированы из `/dev/sdb` в `/srv/valheim` как ext4 `rw`. Каталог Compose принадлежит `root:root`: `/srv/valheim/compose` имеет `drwxr-x---`, `compose.yaml` — `-rw-r-----`. Секрет пароля передаётся контейнеру как файл только для чтения.

| Роль | Путь или параметр |
|---|---|
| Основной Compose | `/srv/valheim/compose/compose.yaml` |
| Password secret | `/srv/valheim/compose/secrets/server_pass` → `/run/secrets/server_pass` (`ro`) |
| Game world | `/srv/valheim/config/worlds_local/Valheim/` |
| BepInEx plugins | `/srv/valheim/config/bepinex/plugins/` |
| Config/JSON/YAML | `/srv/valheim/config/bepinex/` |
| Local ZIP backups | `/srv/valheim/config/backups/` |
| Docker persisted binaries | `/srv/valheim/server-data/` |
| Local staging | `/srv/valheim/share/` |

Полного security-reviewed Compose в Git нет. Из runtime подтверждены `SERVER_NAME=VSP Valheim`, `WORLD_NAME=Valheim`, `CROSSPLAY=false`, `BEPINEX=true`, `SERVER_PASS_FILE=/run/secrets/server_pass` и публикация двух UDP-портов. `SERVER_PUBLIC`, restart policy, `UPDATE_CRON` и фактический image digest пока **[Needs confirmation]**.

## 6. Как контейнер открывает игровой мир

Контейнер — не один процесс. Supervisor запускает вспомогательные службы, SteamCMD готовит игру, BepInEx загружает моды, а игровой процесс открывает мир и сетевой endpoint.

```mermaid
flowchart TB
    DOCKER["Docker Compose запускает контейнер"] --> BOOT["Bootstrap / supervisord"]
    BOOT --> CRON["crond + syslogd"]
    BOOT --> BACKUP["valheim-backup<br/>создаёт ZIP мира"]
    BOOT --> UP["valheim-updater"]
    UP --> STEAM["SteamCMD app 896660<br/>download / verify Valheim"]
    STEAM --> MOD["BepInEx updater<br/>Thunderstore metadata/API"]
    MOD --> RUN["supervisorctl start valheim-server"]
    RUN --> CHAIN["BepInEx Chainloader<br/>plugins loaded"]
    CHAIN --> WORLD["Открытие мира Valheim"]
    WORLD --> PORT["Steam server opened<br/>игровой клиент подключился"]
```

Внутри контейнера работают `valheim-server`, `valheim-updater`, `valheim-backup`, `crond`, `syslogd` и `valheim-bootstrap` под supervisor. BepInEx загружает плагины перед открытием мира. В исходном наборе было 43 DLL; это число файлов, включая библиотеки, а не число загруженных плагинов.


## 7. Моды, игровой мир и путь игровой сессии

После сетевой и системной части наконец появляется то, ради чего всё затевалось: игрок входит в мир, сервер обрабатывает действия через моды и сохраняет состояние.

```mermaid
sequenceDiagram
    participant Player as Игровой клиент
    participant Edge as OpenWrt / NAT
    participant Host as Debian / Docker NAT
    participant Server as Valheim Steam server
    participant Mods as BepInEx plugins
    participant World as World storage
    Player->>Edge: DNS resolved; UDP на 92.255.183.46:2456
    Edge->>Host: DNAT → 10.97.1.20:2456
    Host->>Server: DNAT → 172.18.0.2:2456
    Server-->>Player: Steam/game protocol; запрос пароля
    Player->>Server: Аутентификация / игровые действия
    Server->>Mods: Игровые events и hooks
    Mods-->>Server: Модовая логика и данные
    Server->>World: Запись chunk-based сохранения
    World-->>Server: Состояние мира
    Server-->>Player: Синхронизация игрового состояния
```

**Где живёт мир.** Путь — `/srv/valheim/config/worlds_local/Valheim/`; формат Valheim 1.0 chunk-based использует `_main.<revision>.db2`, `_main.<revision>.fwl2`, `_main.<revision>.chunks`, `_main.<revision>.ok` и `*.chunk`. Номер в имени — ревизия сохранения, не версия игры.

**Что с модами.** В наборе есть Jötunn, Epic Loot, Star Level System, MonsterLabZ, AICompanion, AutomaticFuel, AzuCraftyBoxes, XPortal и другие. На сервере используются DLL и CFG в каталоге BepInEx. Набор разделён на библиотеки, контент, gameplay, QoL, automation и object-моды.

## 8. Samba staging и CIFS mount: два разных назначения SMB

Для обмена файлами здесь два направления SMB. Одно доставляет подготовленные файлы с ПК на сервер. Другое связывает сервер с сетевым хранилищем. Путать эти роли опасно, особенно когда речь о живом мире.

```mermaid
flowchart LR
    PC["VSP-PC<br/>сборка модов / исходный мир"] -->|"SMB upload TCP445"| S["Debian smbd<br/>/srv/valheim/share"]
    S -->|"Ручной контролируемый импорт"| LIVE["/srv/valheim/config<br/>активный мир / BepInEx"]
    VM["VM9001 CIFS client"] -->|"SMB 3.1.1 TCP445"| NET["10.97.253.10<br/>pve-net-smb"]
    VM --> MOUNT["/mnt/pve-net-smb<br/>x-systemd.automount"]
    MOUNT --- NET
    LIVE -.->|"Внешний backup: ещё не внедрён"| MOUNT
```

**Первое направление — файлы с ПК на VM.** `smbd` отдаёт `/srv/valheim/share` через `\\10.97.1.20\valheim-share`: пользователь `vspadmin`, `force user=vspadmin`, `read only=no`, masks 0600/0700, `follow symlinks=no`. Это площадка для загрузки и проверки файлов, а не место для прямого редактирования активного мира с ПК.

**Второе направление — VM к сетевой службе.** `//10.97.253.10/pve-net-smb` монтируется в `/mnt/pve-net-smb`; credentials лежат в `/etc/samba/credentials/pve-net-smb` с `0600 root-only`. В fstab используются `_netdev,nofail,x-systemd.automount`, `uid=1000,gid=1000`, file_mode 0600 / dir_mode 0700, `WORKGROUP`. Согласован SMB 3.1.1; read/write/delete и automount после reboot — **PASS**.


## 9. Где хранятся данные и резервные копии

Последняя часть архитектуры — путь данных. Игровой мир и локальные ZIP находятся на одном гостевом диске. Сетевой CIFS путь есть, но автоматическая off-host копия на этом снимке ещё не реализована.

```mermaid
flowchart TB
    WORLD["Live world + config<br/>/srv/valheim/config/worlds_local"] --> LOCAL["valheim-backup<br/>ZIP /srv/valheim/config/backups"]
    LOCAL -.->|"PENDING: проверенная off-host copy"| REMOTE["CIFS /mnt/pve-net-smb"]
    DISK["Общий guest data disk /dev/sdb"] --- WORLD
    DISK --- LOCAL
```

**Текущее размещение.** `valheim-backup` создаёт локальные ZIP в `/srv/valheim/config/backups/`. CIFS смонтирован в `/mnt/pve-net-smb`, но автоматическое копирование ZIP на другой хост ещё не внедрено.

**Граница отказа.** Мир и локальный ZIP лежат на одном гостевом диске и поэтому разделяют логический failure domain. Отдельный виртуальный data disk не доказывает независимость физического хранилища. Сетевая копия показана на схеме как планируемый путь.

## 10. Источники архитектурного снимка

Здесь можно сверить физическую схему, сетевые решения и конфигурацию Valheim.

- [PVE-LAB Stage001 — физический baseline, диски, сеть](https://github.com/ValentS1997/pve-lab-vsp/blob/main/stages/001.Stage-Baseline/BASELINE-EVIDENCE-2026-10-28.md).
- [PVE-LAB Stage002 — SSH, PVE RBAC, UEFI recovery](https://github.com/ValentS1997/pve-lab-vsp/blob/main/stages/002.Stage-PVE-Core/PVE-CORE-EVIDENCE-2026-10-29.md).
- [PVE-LAB Stage003 — storage role design (не runtime implementation)](https://github.com/ValentS1997/pve-lab-vsp/blob/main/stages/003.Stage-Storage-Backup/STORAGE-LAYOUT-DESIGN.md).
- [PrOWRT — PVE-NET rename and VM9100 NIC mappings](https://github.com/ValentS1997/PrOWRT/blob/main/docs/STAGE002-PVE-NET-RENAME-ACCEPTANCE-2026-10-29.md).
- [PrOWRT — network architecture decisions](https://github.com/ValentS1997/PrOWRT/blob/main/ARCHITECTURE-DECISIONS.md).
- [Valheim — as-built creation/migration](https://github.com/ValentS1997/vsp-gamer-mods/blob/main/Valheim/Valheim%20Dedicated%20Server/AS_BUILT_2026-11-01.md).
- [Valheim — operations and acceptance](https://github.com/ValentS1997/vsp-gamer-mods/blob/main/Valheim/Valheim%20Dedicated%20Server/OPERATIONS_AND_ACCEPTANCE_2026-11-01.md).
- [Valheim — administrator guide](https://github.com/ValentS1997/vsp-gamer-mods/blob/main/Valheim/Valheim%20Dedicated%20Server/ADMIN_GUIDE.md).
- [Upstream Docker image — update, backup, Supervisor, BepInEx](https://github.com/community-valheim-tools/valheim-server-docker).
