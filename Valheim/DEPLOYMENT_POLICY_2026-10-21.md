# Valheim — deployment policy, user-approved (2026-10-21)

> **НОВЫЙ ВЫБОР (2026-10-22, установка ещё не подтверждена):** пользователь скачивает [Quads Companion](https://thunderstore.io/c/valheim/p/Quads_Lab/Quads_Companion/) v0.25.0 — `AICompanion.dll` (**Server / Client**), [Quads Bounty Board](https://thunderstore.io/c/valheim/p/Quads_Lab/Quads_Bounty_Board/) v1.4.4 — `BountyBoard.dll` (**Server / Client**), [Quads Party HUD](https://thunderstore.io/c/valheim/p/Quads_Lab/Quads_Party_HUD/) v1.12.0 — `PartyHud.dll` (**Only Client**, опционален). У Companion и Bounty Board установку на всех клиентах и хосте прямо требует автор, иначе сохранённые NPC / доски могут исчезнуть при загрузке зоны. Для Party HUD достаточно установить только тому, кому нужен интерфейс; расширенная телеметрия удалённых игроков требует их добровольного ShareMyStats. Точные DLL имена сверены с `thunderstore.toml` и `.csproj` в публичном GitHub Quads Lab.
> **АКТУАЛЬНАЯ ПЛАНОВАЯ КОМПЛЕКТАЦИЯ:** **44 S/C + 8 Only Client + 1 отключённый DigDug = 53 учтённые DLL, 52 активные**, при условии установки всех новых компонентов. Исторические значения 40/7 и 42/7 ниже сохраняются для аудита и уже не отражают выбранный состав. Dedicated server не используется; хост — локальный клиент пользователя. Конфиги новых Quads-модов (`com.quad.aicompanion.cfg`, `com.quad.aicompanion.more.cfg`, `com.quad.bountyboard.cfg`, `com.quad.partyhud.cfg`) будут созданы игрой при первом запуске; не считать их зафиксированными до получения с ПК.


> **ЗАМЕНА (2026-10-22):** `NoMapCartographyTable.dll` → `BlindCartographer.dll` (**NightKosh/BlindCartographer 1.0.3**). Полная замена 1:1; оба одновременно не устанавливать. Старый `com.dreich.nomapcartographytable.cfg` исключён из актуальных конфигов; новый [nightkosh.BlindCartographer.cfg](config/nightkosh.BlindCartographer.cfg) включает карту только на картографическом столе и метки по `Left Alt + Y`. **Текущий обязательный S/C-манифест:** 42 DLL (исторические 40 ниже, но в них читать замену NoMapCartographyTable → BlindCartographer, плюс 2 дополнения); Optional Only Client: 7; excluded DigDug: 1. Категория S/C сохранена по пользовательской политике «без новых опциональных модов», хотя Thunderstore классифицирует BlindCartographer как **client-side**; запуск в headless dedicated server не проверялся и технически для функции мода не нужен.


> **ТЕКУЩЕЕ ДОПОЛНЕНИЕ (2026-10-22):** 2 новых мода добавлены к исходному утверждённому набору из 40 общих: **FiresGhettoNetworking** (`VAGhettoNetworking.dll`, конфиг [com.Fire.FiresGhettoNetworkMod.cfg](config/com.Fire.FiresGhettoNetworkMod.cfg)) и **HipLantern** (`HipLantern.dll`, конфиг [shudnal.HipLantern.cfg](config/shudnal.HipLantern.cfg)). Оба относятся к **Server / Client** по политике комплектации. Текущий список: **42 общих + 7 Only Client + 1 DigDug исключён = 50**. Старое число 48 и перечень из 40 ниже — зафиксированный инвентарь **до этих двух дополнений**, а не ошибка подсчёта. Dedicated server всё ещё не запущен; его runtime-совместимость не подтверждена.


**Status: APPROVED deployment INTENT; NOT verified runtime compatibility or a version-locked release.**

This document supersedes provisional role splits in `DEPLOYMENT_AUDIT_2026-10-21.md` and the earlier suggested 24/24 grouping. User directive: **all modules from the observed 48-entry inventory are mandatory on both dedicated server and every participating client, except exactly the seven explicitly optional client mods below and the previously excluded DigDug**. No server-only mods are selected.

## Server / Client — REQUIRED (40)

These are **required by project modpack policy**, even for plugins that their authors permit to run only client-side or whose server-side effect may be null. The list is not proof that every binary loads on a headless dedicated server. Version, Linux/Mono compatibility, transitive dependencies, and runtime verification remain unresolved.

```text
AchievementEnabler.dll
AutomaticFuel.dll
AzuCraftyBoxes.dll
Basements.dll
BetterTames.dll
BiggerPickupRadius.dll
BossGate.dll
BuyableExtractors.dll
ConditionalConfigSync.dll
ConditionalConfigSync.Plugin.dll
Digitalroot.Valheim.ChainManager.dll
EpicLoot.dll
ExtraSlots.dll
ForsakenPowersPlusRemastered.dll
FrizzQOL.AreaRepair.dll
HoeRadius.dll
InstantlyDestroyBoatsAndCarts.dll
Jotunn.dll
LzD_StationsCustomRanges.dll
MonsterLabZ.dll
NewtonsoftJsonDetector.dll
Newtonsoft.Json.dll
NoFoodDegradation.dll
NoMapCartographyTable.dll
OdinCampsite.dll
OdinRealmFishingMod.dll
OreMines.dll
ProjectileTweaks.dll
QuickStackStore.dll
Quiver.dll
SmartRepair.dll
SolidHitboxes.dll
Spearfishing.dll
StakeTweaks.dll
StarLevelSystem.dll
TopMining.dll
VentureValheim.NoSeasonalRestrictions.dll
XPortal.dll
YamlDotNetDetector.dll
YamlDotNet.dll
```

## Only Client — OPTIONAL (7)

Install these only on individual player machines, at player discretion. The server and essential game mechanics must work without them.

```text
Advize_PlantEasily.dll
BetterPickupNotifications.dll
BuildOrders.dll
CarturCompassAndClock.dll
ConfigurationManager.dll
FirstPersonMode.dll
GooderAutoShield.dll
```

## Only Server — REQUIRED (0)

None selected.

## EXCLUDED — DO NOT DEPLOY (1)

```text
DigDug.dll*
```

The user's trailing `*` is an intentional disable-by-renaming technique. Preserve the renamed local file if wanted, but do **not** include it in either pack. Already retired Custom Raids also remains excluded (not counted among the 48 listed entries).

## Reconciliation and operational conditions

- Inventory source: handoff client `BepInEx/plugins` listing at **2026-10-21 21:11 local**, 48 filename entries. Arithmetic: **40 required both + 7 optional client + 1 excluded = 48**.
- `AutomaticFuel [General] / Mod ToggleKey = None`: approved user action, **local change not yet verified**. `PlantEasily F10` unchanged.
- **This is a normative distribution decision, not a statement that vendor docs mandate server installation.** Some 40 binaries are libraries, optional sync plugins, UI helpers, client-oriented gameplay tweaks, or possible patchers; determine exact working server package separately. If a DLL is confirmed client-only and fails server initialization, flag a deployment exception for approval rather than covertly deleting it from the common manifest.
- No game modifications performed. Do not copy or rename active DLLs yet. Collect exact GUIDs, installed mod versions, SHA-256 hashes, server/client BepInEx logs, and non-DLL assets (e.g., patchers and audio) before publishing a production deployment package. Test on disposable world backed up from production; accept only after client joins and gameplay checks succeed. 
- `DEPLOYMENT_AUDIT_2026-10-21.md` is the technical evidence and historical hypotheses; **this document is the binding user-defined modpack policy**.

## Additions 2026-10-22 — Server / Client (2 DLL)

- `VAGhettoNetworking.dll` — **FiresGhettoNetworking** v1.5.65: загружен пользовательский CFG, сетевое сжатие, автоподстройка; выделенная серверная симуляция включена в CFG, но пока нет отдельного dedicated server. Экспериментальные broad+selective ownership = true в присланном CFG, Selective имеет приоритет. Не объединять с другими сетевыми оптимизаторами без отдельного теста.
- `HipLantern.dll` — **HipLantern** v1.1.14: слот ExtraSlots, удвоенный визуальный размер, топливо 240 минут. **CFG восстановлен** из предыдущей загрузки с тремя правками согласно переписке; пользователь подтвердил изображение и свет в игре, но ещё не предоставил точный финальный файл после этих изменений.

Никакие другие DLL и конфиги исходной сборки этой записью не менялись.

## Additions 2026-10-22 — Quads Lab (3 DLL, local install pending)

### Required Server / Client — add 2

```text
AICompanion.dll    # Quads Companion 0.25.0
BountyBoard.dll    # Quads Bounty Board 1.4.4
```

### Optional Only Client — add 1

```text
PartyHud.dll       # Quads Party HUD 1.12.0
```

- Установить **AICompanion** и **BountyBoard** у обоих товарищей и на хосте; моды хранят свои сохранённые объекты в мире, и отсутствие мода опасно для таких объектов при загрузке областей.
- **PartyHud** можно ставить выборочно. Совместимость и отображение NPC из AICompanion заявлены автором.
- Только зависимость BepInExPack Valheim указана в актуальных пакетах; в сборке BepInEx уже имеется, дополнительных DLL по зависимостям этих трёх пакетов не добавлять без проверки.
- Не коммитить «типовые» CFG как будто они считаны с компьютера. После запуска собрать реальные версии DLL, конфиги и BepInEx-логи, проверить клавишу H (занята HipLantern) и совместимость с ExtraSlots, StarLevelSystem, EpicLoot, MonsterLabZ, Quads Build Orders.
- **Горячие клавиши:** Quads Companion по умолчанию использует `H` для приказов, а `H` уже используется HipLantern; у Quads Party HUD переключатель `F8`, но `F8` занят у ForsakenPowersPlusRemastered. Переназначать после генерации реальных пользовательских CFG. Не вводить произвольные якобы локальные настройки в Git.
- Татьяна: пока концепт желаемого NPC; имя/женская модель требуют проверки в игре.

