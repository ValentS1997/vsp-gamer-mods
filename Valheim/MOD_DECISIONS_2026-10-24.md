# Решения по новым модам Valheim — 24.10.2026

**Последнее решение пользователя (после исключения BossGate):** добавить **WoodMakeMods / ModularLadders** в обязательную сборку, а **M2Valheim / SkillsReworked** и **M2Valheim / TalentTree 2.3.5** отложить как интересные, **не включать в текущий состав**. **Никакие CFG создавать или изменять не требуется.** Это решение о составе, не подтверждение установки DLL.

| Мод | Источник | Статус |
|---|---|---|
| **ModularLadders 1.0.0** | https://thunderstore.io/c/valheim/p/WoodMakeMods/ModularLadders/ | **Выбран, обязательный Server / Client**, установить на P2P-хосте и двух клиентах при следующей синхронизации |
| **SkillsReworked** | https://thunderstore.io/c/valheim/p/M2Valheim/SkillsReworked/ | **Отложен / кандидат**, не скачивать и не считать DLL текущего состава |
| **TalentTree 2.3.5** | https://thunderstore.io/c/valheim/p/M2Valheim/TalentTree/v/2.3.5/ | **Отложен / кандидат**, не скачивать и не считать DLL текущего состава |

## ModularLadders — что известно из описания автора

- Thunderstore на дату просмотра показывает **1.0.0**. Пять вариантов вертикальных лестниц (wood, core wood, darkwood, ashwood, dvergr) по **2 м**; сегменты стыкуются, подъём выполняется одним взаимодействием.
- **Автор прямо требует установку у всех игроков в мире и на dedicated server**: это строительные объекты, которые должны быть известны всем клиентам. Для нашего P2P-хоста — обязательная DLL на всех трёх ПК, не Only Client.
- Имя DLL указано автором: **`ModularLadders.dll`**; ручная установка `BepInEx/plugins/ModularLadders/`. Зависимость от **BepInExPack**; **Jötunn не требуется**.
- При **удалении мода построенные модовые лестницы исчезнут из мира**. Поэтому сделать резервную копию мира до удаления или обновления. Совместимость с иными модами строительства и несущих конструкций автор ещё не проверял; тестировать с нашими Basements / BuildOrders / станциями.
- **Версия установленной DLL и её работоспособность в конкретной сборке не подтверждены**. Никакого CFG или скачанной DLL в Git не добавлено.

## Отложенные идеи

**SkillsReworked:** ролевая система уровней, атрибутов, Rebirth/Prestige, влияет на прокачку персонажа. Не включать без отдельного будущего решения.

**TalentTree v2.3.5:** дерево талантов для разных игровых стилей, **жёсткая зависимость от SkillsReworked**. Конкретная версия сохранена из ссылки пользователя; не заменять автоматически на latest. Не включать до отдельного решения.

## Счёт DLL после нового решения

**Было** после исключения BossGate: **45 обязательных S/C + 10 клиентских = 55 выбранных активных**.

**Стало** после выбора ModularLadders: **46 обязательных S/C + 10 клиентских = 56 выбранных активных**. Выключенный `DigDug.dll*` отдельно = **57 учтённых**. SkillsReworked и TalentTree не прибавлять.

Текущий [манифест DLL](MOD_MANIFEST_2026-10-24.md) и [каталог модов](README.md) должны отражать именно этот состав. Исторические данные инвентаризации 22.10 (54 DLL до последних решений) не являются новым подтверждением наличия ModularLadders.

**Последнее распоряжение:** без создания CFG и без вмешательства в файлы мира/персонажей/локального клиента. Только запись решений и обновление списков в публичном Git.

## Новые кандидаты на рассмотрение (24.10.2026)

- **[ChestSizeConfig](https://thunderstore.io/c/valheim/p/LuciDreams/ChestSizeConfig/)** — пользователь отметил как **потенциального кандидата**, **не выбран в сборку**; новый DLL не считать, CFG не создавать. Задача — вместительные недорогие сундуки из ранних ресурсов, но ещё нужно проверить сетевую совместимость с AzuCraftyBoxes / Quick Stack Store и сохранением инвентарей.
- **[PlanBuild 0.20.0](https://thunderstore.io/c/valheim/p/MathiasDecrock/PlanBuild/v/0.20.0/)** — **ВЫБРАН для установки**, категория Server/Client, по одному экземпляру на P2P-хосте и у двух друзей. Цель — сохранить план существующего дома перед перестройкой с множеством полных сундуков. Данные вещей сохраняются в .blueprint, но воспроизводятся только через Direct Build: возможны бесплатная постройка и дублирование вещей, это НЕ перенос с изъятием оригинала. Сначала сохранить мир и испытать сундук на копии. **Выбор, не подтверждение установки; CFG не создан.** [План безопасного использования](PLANBUILD_REBUILD_2026-10-24.md).


**Обновление состава после выбора PlanBuild:** 47 обязательных Server/Client + 10 Only Client = **57 выбранных DLL**, плюс один выключенный DigDug (58 учтённых). ChestSizeConfig остаётся кандидатом; SkillsReworked и TalentTree отложены. Предыдущие цифры 46+10 относятся к более раннему решению. [Манифест](MOD_MANIFEST_2026-10-24.md).


## Решение о строительных модах и новые сведения об установке — 24.10.2026 (ПОСЛЕДНЕЕ)

- [BentoG MissingPieces](https://thunderstore.io/c/valheim/p/BentoG/MissingPieces/) — **выбран для тестирования**, **не подтверждён установленным** и **не прибавлен** к базовому счёту 57 DLL.
- **Сохранить в кандидатах:** [Cartur's Flooring](https://thunderstore.io/c/valheim/p/Cartur/Carturs_Flooring/), [Sinka](https://thunderstore.io/c/valheim/p/Ezomic/Sinka/), [BronzeAgeChest](https://thunderstore.io/c/valheim/p/probablykory/BronzeAgeChest/). Прежний MissingPiecesFix — deprecated fork, не устанавливать одновременно с основным.
- **PlanBuild и ModularLadders:** пользователь сообщил об установке у себя. [PlanBuild CFG](config/marcopogo.PlanBuild.cfg) заголовок v0.20.0, по нему нельзя доказать версию загруженной DLL. У друзей версии и присутствие не проверены. PlanBuild Mirror=H может конфликтовать с HipLantern/EpicLoot.
- **Итоговый каталог:** 47 общих + 10 клиентских = 57 в составе; MissingPieces — отдельно в тесте, три других кандидата не считаются. [Полный реестр](BUILDING_MODS_TEST_2026-10-24.md).


## Коррекция рейда foresttrolls — 24.10.2026 (ПОСЛЕДНЕЕ)

По фактическому тесту пользователя SLS `foresttrolls` («Земля трясётся») атаковал одним троллем, требуется 3–5 за волну. В Git точечно изменены `SpawnGroupSize: 1→3`, `MaxSpawned: 2→5`. Параметры `SpawnInterval: 40`, `MaxSpawnTriggers: 5`, `Duration: 180` сохранены; другие рейды/баланс без изменений. **3 за полную волну, максимум 5 живых, а не гарантированный случайный диапазон 3–5.** Установка в игре и тест пока не подтверждены. [Решение и rollback](FORESTTROLLS_RAID_TUNING_2026-10-24.md).


## Повторный ребаланс всех рейдов StarLevelSystem — v3, 24.10.2026 (ПОСЛЕДНЕЕ)

По запросу пользователя после одного Troll в «Земля трясётся» выполнен **полный аудит 24 рейдов / 63 записей спавна**, 21 рейд скорректирован, 3 специальных оставлены. В 51 записи изменены 103 числовых поля размеров групп, одновременно живых и количества повторных попыток. Рейд `foresttrolls` уже ранее исправлен и оставлен `SpawnGroupSize=3, MaxSpawned=5, MaxSpawnTriggers=5`. Предыдущая единообразная схема ×0.25 заменена распределением по опасности мобов. Исходная версия YAML [архивирована](raid-backups/RaidSettings_before_wave_rebalance_2026-10-24.yaml). Все подробности, ограничения (это не рандомный диапазон), таблица и rollback — в [отчёте](RAID_WAVE_REBALANCE_2026-10-24_v3.md). Git-only; проверка работы на хосте и клиентах **[Pending]**.


## ПОСЛЕДНЕЕ: Vanilla raids, ordinary & boss modifiers retained; Quads Bounty Board retired (24.10.2026)

- User selects `UseVanillaRaidConfiguration=true` (the earlier 24-raid custom wave v3 is archived/historical, not deleted), `EnableNemesisSystem=false`, and turns off birds/fish/trees SLS scaling.
- **Keep** ordinary creature Major/Minor modifiers, starred mob distributions, extended starred boss HP `BossEnemyHealthMultiplier=0.75`, and boss modifier settings unchanged. Original balance, loot tables, NPC exception and night spawns are not overwritten.
- Standalone **Quads Bounty Board** `BountyBoard.dll` retired (uninstall on P2P host and both clients only after manually removing any constructed boards and backing up contract/world data); Quads Companion `AICompanion.dll` and Party HUD remain. CFG byte-identically archived at [retired-configs/com.quad.bountyboard.cfg](retired-configs/com.quad.bountyboard.cfg).
- New intended count **46 mandatory S/C + 10 optional C = 56 DLL**, DigDug still disabled; MissingPieces test remains outside core tally. This supersedes historic 47+10/57 active DLL declarations. 
- Git config and manifest updated, gameplay state not modified. [Exact six CFG changes, safety procedure, rollback](SLS_VANILLA_RAIDS_AND_BOUNTY_RETIREMENT_2026-10-24.md).


## ПОСЛЕДНЕЕ 24.10.2026 — только возвращаемые стрелы и косметический колчан

- User wants only chance to recover shot arrows and cosmetic quiver. Keep **Quads Quiver / Quiver.dll**, remove **ProjectileTweaks.dll** (tweaked aim/trajectory, zoom and ammo counter no longer wanted), archive the old config in [retired-configs/Searica.Valheim.ProjectileTweaks.cfg](retired-configs/Searica.Valheim.ProjectileTweaks.cfg) after a byte-for-byte comparison.
- New `com.quad.quiver.cfg`: `PickUpArrows=true`, `ChanceOnGround=1`, `ChanceOnCreature=0.75`, `Show=true`, `FireArrowsBurnUp=true`. Only actual config edit: **`IncludeBolts=true→false`**; original saved at `config-backups/com.quad.quiver_before_arrows_only_2026-10-24.cfg`.
- Official author says Quads Quiver is **client-only**, so move `Quiver.dll` from S/C mandatory to client-optional; host should keep it for consistent return percentages. New target **44 S/C + 11 client-only = 55 DLL**, plus inactive DigDug = 56 accounted. Quiver not required on friends who do not want it. If missing on host, clients use own recovery config. MissingPieces stays test-only outside totals.
- **Quads Bounty Board user reports “удаляю”** (in process, **NOT proof completed**). `BountyBoard.dll` is already out of selection from earlier step; do not subtract twice. Remind to dismantle boards, claim rewards and back up world/contract state before removing DLL at all peers.
- See [full design / deployment / rollback](ARCHERY_QUIVER_ONLY_2026-10-24.md). All Git-only, host/game still unverified.
