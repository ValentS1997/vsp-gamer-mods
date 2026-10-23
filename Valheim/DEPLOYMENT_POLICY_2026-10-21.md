# Valheim — deployment policy, user-approved (2026-10-21)

> **АКТУАЛЬНО НА 24.10.2026 — MODULARLADDERS ДОБАВЛЕН ПО РЕШЕНИЮ ПОЛЬЗОВАТЕЛЯ:** [ModularLadders v1.0.0](https://thunderstore.io/c/valheim/p/WoodMakeMods/ModularLadders/) — новая обязательная **Server / Client** DLL `ModularLadders.dll`: установить на **P2P-хосте и обоих клиентах**, т.к. мод добавляет строительные детали (сегменты лестниц). Требуется BepInExPack; Jötunn не требуется отдельно. **Текущий план: 46 S/C + 10 C = 56 активных DLL**, плюс отключённый `DigDug.dll*` = 57 учтённых. **Выполнение установки не подтверждено; никаких CFG для ModularLadders не создано.** [SkillsReworked](https://thunderstore.io/c/valheim/p/M2Valheim/SkillsReworked/) и [TalentTree v2.3.5](https://thunderstore.io/c/valheim/p/M2Valheim/TalentTree/v/2.3.5/) **отложены**, не входят в список и не получают конфиги. [Решение](MOD_DECISIONS_2026-10-24.md), [актуальный манифест](MOD_MANIFEST_2026-10-24.md). Следующая запись о 45+10 — история после исключения BossGate, до добавления ModularLadders.


> **АКТУАЛЬНО НА 24.10.2026 — BOSSGATE ИСКЛЮЧЁН:** по решению пользователя после добычи Molten Cores в Ashlands для каменного портала `BossGate.dll` **удаляется у P2P-хоста и двух друзей**; `PortalItemsRequireBossKill=true` больше не нужен, `XPortal.dll` остаётся. Бывший [активный CFG](retired-configs/Igao.BossGate.cfg) архивирован, из `Valheim/config/` убран; **локальная установка пока не менялась**. **АКТУАЛЬНЫЙ целевой состав: 45 обязательных S/C + 10 необязательных C = 55 DLL (+1 отключённый DigDug = 56 учтённых)**. [Точный манифест 55 DLL](MOD_MANIFEST_2026-10-24.md); прежние перечни с `BossGate.dll` ниже — **датированная история**, не инструкция к установке. `Advize_PlantEasily.dll` входит в те же 10 клиентских, не считать вторично: у хоста [полный CFG](config/advize.PlantEasily.cfg), для друзей [минимальный сбор E](client-presets/friends/advize.PlantEasily.cfg) без массовой посадки/сетки. [Подробности](FRIENDS_HARVEST_AND_BOSSGATE_RETIREMENT_2026-10-24.md).


> **АКТУАЛЬНО НА 23.10.2026 — НОВЫЙ ПЛАН:** Пользователь выбрал [DoorDirector 0.3.0](https://thunderstore.io/c/valheim/p/TomTomDK/DoorDirector/) (автозакрытие ворот) и [ChilloutForcedPVP 1.1.0](https://thunderstore.io/c/valheim/p/ChilloutMods/ChilloutForcedPVP/) (принудительный PvP для всех игроков). Оба отнесены к **Server / Client**, необходимы на **P2P-хосте и обоих друзьях**, отдельного dedicated server нет. **46 обязательных S/C + 10 необязательных C = 56 выбранных активных DLL (+1 исключённый DigDug = 57 учтённых)**. Последний фактически проверенный на диске комплект от 22.10 — **44 S/C + 10 C = 54 DLL**; обе новые DLL пока не подтверждены локально. [Ранее подготовленный DoorDirector CFG](config/com.tomtom.doordirector.cfg) остаётся; **ChilloutForcedPVP CFG не создавался**: пользователь обещал прислать свой файл позже (автор указывает отсутствие настроек). До установки ChilloutForcedPVP сверить BepInExPack **≥5.4.2351** и Jötunn **≥2.30.2** (мод тестировался с Valheim 1.0.20). Точная сборка DLL и мультиплеерный запуск не проверены. Более ранние цифры ниже датированы и сохранены как история решений.

> **ИСТОРИЧЕСКИЙ ВЫБОР 2026-10-22 (updated):** ExtraSlotsCustomSlots **CANCELED**, existing ExtraSlots retained. [WorkbenchesPlus 1.0.16](https://thunderstore.io/c/valheim/p/Morda/WorkbenchesPlus/) selected as new optional **Only Client** crafting UI (DLL `WorkbenchesPlus.dll`, CFG generated as `com.morda.workbenchesplus.cfg`). [Venture Logout Tweaks 1.0.0](https://thunderstore.io/c/valheim/p/VentureValheim/Venture_Logout_Tweaks/) remains already-selected Only Client replacing rejected KeepCharacterEffects; **do not count twice**. **Current plan: 44 required S/C + 10 optional C = 54 selected active DLLs; +1 intentionally disabled DigDug = 55 accounted.** Runtime inventories/compatibility not verified. The two previously researched UI alternatives Workstation Search and CraftingSearch are **not selected**. WorkbenchesPlus extras (dismantle/build-range/auto-repair) can alter gameplay; no CFG or world changes approved. Historical notes below retain earlier 44+9 states for audit.

## Only Client-манифест (10 модов; 22.10.2026 проверены локальные DLL)

```text
Advize_PlantEasily.dll
BetterPickupNotifications.dll
BuildOrders.dll
CarturCompassAndClock.dll
ConfigurationManager.dll
FirstPersonMode.dll
GooderAutoShield.dll
PartyHud.dll
WorkbenchesPlus.dll              # Morda WorkbenchesPlus 1.0.16; NEW
VentureValheim.LogoutTweaks.dll # venture logout tweaks; present in verified snapshot
```

- **ChilloutForcedPVP (выбран 23.10.2026):** [1.1.0](https://thunderstore.io/c/valheim/p/ChilloutMods/ChilloutForcedPVP/), новый обязательный `S/C` мод (+1 DLL сверх DoorDirector). Включает PvP всех игроков и запрещает отключать его переключателем; не меняет урон, штраф смерти, PvE и рейды. По заявлению автора, совместимая ветка **1.1.x** обязательна на серверной стороне и каждом клиенте — для нашего P2P это хост и оба друга. Требуется **BepInExPack 5.4.2351+** и **Jotunn 2.30.2+**; ранее учтённый Jotunn не добавлять вторично в манифест. Имя `ChilloutForcedPVP.dll` предварительное, подтвердить при скачивании. **Конфиг не предоставлен и не создаётся** — пользователь принесёт файл позже; upstream README заявляет отсутствие настраиваемых параметров. Не путать с SolidHitboxes, включающим дружественный урон между NPC. Тест multiplayer/runtime не пройден.
- **DoorDirector (добавлен 23.10.2026):** один новый `S/C` мод `DoorDirector.dll`. Требует одинаковую версию у всех трёх игроков, включая хоста, хотя dedicated server не используется. Автозакрытие после 5 с по умолчанию, нет автодверей по приближению. Дополнительный конфиг в Git — [com.tomtom.doordirector.cfg](config/com.tomtom.doordirector.cfg); `Prefab Debug Hotkey=None` сохраняет `F7` для Build Orders. `Shift+G` для отдельной построенной двери, `Shift+T` для её задержки; команда `doordirector_prefab` для имени префаба. Протестировать на обычных воротах, модовых воротах и при открытии Quads Companion; установка пока не подтверждена.
- **WorkbenchesPlus:** автор заявляет client-side, Valheim 1.0, BepInExPack 5.4.2350+. Генерируемый при запуске CFG: `BepInEx/config/com.morda.workbenchesplus.cfg` (не был получен с ПК). Встроенные dismantle, изменение радиуса станции (`Shift+E`) и auto-repair — потенциальные gameplay changes, а не только UI; перед использованием проверить совместимость с `LzD_StationsCustomRanges`, Quads Build Orders и сохранением мира. Не включать новые функции автоматически в Git.
- **Venture Logout Tweaks:** автор подтверждает client-only и отсутствие CFG; версии DLL, загрузку плагина и восстановление эффектов в нашей сборке проверить логом и тестом.

> **ПРЕДЫДУЩЕЕ РЕШЕНИЕ (историческая запись, до WorkbenchesPlus, 2026-10-22):** KeepCharacterEffects **исключён из выбранного состава** из-за недоступности загрузки; вместо него выбран [Venture Logout Tweaks v1.0.0](https://thunderstore.io/c/valheim/p/VentureValheim/Venture_Logout_Tweaks/), **Only Client**, без CFG. Старое решение перемещено в [«Нашли лучшее решение»](%D0%9D%D0%B0%D1%88%D0%BB%D0%B8%20%D0%BB%D1%83%D1%87%D1%88%D0%B5%D0%B5%20%D1%80%D0%B5%D1%88%D0%B5%D0%BD%D0%B8%D0%B5/KeepCharacterEffects.md). Замена 1:1; **44 S/C + 9 Only Client**, план 53 активные DLL, без подтверждения установки. Зафиксирован интерес к ExtraSlotsCustomSlots (до 8 пользовательских слотов), но это **пока кандидат, не считать установленным и не прибавлять к DLL**. Список допустимых предметов обязательный, пустой список не разрешает всё; подробности в [концепте](UNIVERSAL_SLOTS_AND_CRAFTING_UI_2026-10-22.md).

> **ПРОВЕРКА И ИСПРАВЛЕНИЯ (22.10.2026):** [отчёт о сверке CFG](CONFIG_RECONCILIATION_2026-10-22.md). Дружественный огонь NPC включён в SolidHitboxes (`EnableFriendlyFire=true`, `FriendlyFireDamageModifier=1`); кнопки Quads Companion переназначены `L/K`, Party HUD — `F4` (F11 занята импортом планов Build Orders). Три JSON EpicLoot в Git побайтово синхронизированы с загруженным ZIP; прогрессию и редкий дроп пользователя не отменяли. **Все правки сделаны в Git; для реального игрового хоста требуется локальное применение трёх CFG.** Классификация DLL остаётся **44 S/C + 9 Only Client** (план).

> **ПОСЛЕДНИЙ ПОДТВЕРЖДЁННЫЙ CONFIG-СНИМОК (2026-10-22):** [Аудит присланного ZIP](LOCAL_SNAPSHOT_AUDIT_2026-10-22.md). Все четыре локальных Quads CFG получены и сохранены в Git побайтово, остальные согласованные изменения в настройках Achievements, SLS, AutomaticFuel, PlantEasily, Quiver, Build Orders и QuickStack также синхронизированы. Это не подтверждает факт установки всех DLL у друзей. В локальном BlindCartographer.cfg записана версия v1.0.2, версия DLL не проверена. В архиве не обнаружен CFG KeepCharacterEffects. **Текущий выбранный план 44 S/C + 9 Only Client**, но точный установленный состав пока нельзя считать проверенным.

> **УСТАРЕЛАЯ ЗАПИСЬ (отклонено позднее 22.10): KEEP CHARACTER EFFECTS:** [KeepCharacterEffects](https://www.nexusmods.com/valheim/mods/4410) от Virkatta, Nexus version **1**, дата публикации 12.10.2026. Автор заявляет полную работоспособность на **Only Client**: сохранение оставшегося времени Rested, Wet, Mead/Potions и Guardian Powers между выходом/входом; серверу и другим игрокам мод не обязателен. **Имя DLL/Plugin GUID не подтверждены:** Nexus не публикует их в доступном описании; не придумывать. Автор не тестировал совместимость с другими модами, включая нашу связку ForsakenPowersPlusRemastered. Установить и проверить позже, перед этим копия персонажа. 
> **ИСТОРИЧЕСКИЙ ВЫБРАННЫЙ СОСТАВ (до WorkbenchesPlus):** **44 Server/Client + 9 Only Client + 1 исключённый DigDug = 54 учтённых записи, 53 ожидаемых активных DLL**. Цифры 42/7, 44/8 и исторические списки ниже отражают предыдущие этапы. Из 9 клиентских 8 были уже выбраны; KeepCharacterEffects девятый, пока только запланирован.

> **ИСТОРИЯ ВЫБОРА (2026-10-22; после неё получены CFG, см. выше):** пользователь скачивает [Quads Companion](https://thunderstore.io/c/valheim/p/Quads_Lab/Quads_Companion/) v0.25.0 — `AICompanion.dll` (**Server / Client**), [Quads Bounty Board](https://thunderstore.io/c/valheim/p/Quads_Lab/Quads_Bounty_Board/) v1.4.4 — `BountyBoard.dll` (**Server / Client**), [Quads Party HUD](https://thunderstore.io/c/valheim/p/Quads_Lab/Quads_Party_HUD/) v1.12.0 — `PartyHud.dll` (**Only Client**, опционален). У Companion и Bounty Board установку на всех клиентах и хосте прямо требует автор, иначе сохранённые NPC / доски могут исчезнуть при загрузке зоны. Для Party HUD достаточно установить только тому, кому нужен интерфейс; расширенная телеметрия удалённых игроков требует их добровольного ShareMyStats. Точные DLL имена сверены с `thunderstore.toml` и `.csproj` в публичном GitHub Quads Lab.
> **ПРЕДЫДУЩАЯ ПЛАНОВАЯ КОМПЛЕКТАЦИЯ (до KeepCharacterEffects):** **44 S/C + 8 Only Client + 1 отключённый DigDug = 53 учтённые DLL, 52 активные**, при условии установки всех новых компонентов. Исторические значения 40/7 и 42/7 ниже сохраняются для аудита и уже не отражают выбранный состав. Dedicated server не используется; хост — локальный клиент пользователя. Эти четыре конфига Quads позднее были получены в архиве 22.10 и записаны в Git побайтово; см. актуальный аудит в начале документа.


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

## Historical initial Only Client — OPTIONAL (7; superseded by 10 above)

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


## Архив решения — KeepCharacterEffects (Only Client; исключён после выбора Venture Logout Tweaks)

- [KeepCharacterEffects](https://www.nexusmods.com/valheim/mods/4410) — Virkatta, Nexus version 1 (12.10.2026), сохраняет оставшуюся продолжительность временных эффектов персонажа при выходе/входе.
- **Только клиент**, не нужно на сервер и обоим друзьям в рамках нашей политики (каждый может установить отдельно по желанию).
- **DLL-файл и BepInEx GUID ещё не верифицированы.** После скачивания сверить название реального DLL, возможный CFG и лог BepInEx; не записывать вымышленные имена.
- В авторском описании прямо указано отсутствие проверок совместимости. Прежде всего испытать сохранение и восстановление эффекта силы Отрёкшихся с уже установленным ForsakenPowersPlusRemastered, а также медовухи, отдыха и эффектов от EpicLoot при перезаходе.
- **SolidHitboxes** уже включён в прежний S/C-манифест и README. В реальном Git CFG `org.bepinex.plugins.solid-hitboxes.cfg` указана версия **1.0.8**, `EnableFriendlyFire=false`, `FriendlyFireDamageModifier=1`, `LockConfig=true`; повторно DLL не добавлять и численность из-за него не менять.
