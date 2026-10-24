# VSP Gamer — актуальный DLL-манифест Valheim (24.10.2026)

**ПОСЛЕДНЕЕ РЕШЕНИЕ 24.10.2026 — ТОЛЬКО СТРЕЛЫ И КОЛЧАН:** `ProjectileTweaks.dll` исключается из целевого состава: отдельные правки угла/траектории/зум/счётчик боеприпасов не нужны. `Quiver.dll` (Quads Quiver) **оставлен** для возврата стрел (земля 100%, противник 75%) и визуального колчана; восстановление болтов выключено. По документации автора Quads Quiver работает **client-only**: переносим его из обязательных S/C в опциональные клиентские (хосту стоит держать его установленным для единой вероятности возврата в P2P). **Последний план: 44 обязательных S/C + 11 необязательных Only Client = 55 выбранных DLL**, + отключённый DigDug = 56 учтённых. Удаление `ProjectileTweaks.dll` со всех ПК и `BountyBoard.dll` — по инструкции, пока **не подтверждено**. [Инструкция и rollback](ARCHERY_QUIVER_ONLY_2026-10-24.md).


**ПОСЛЕДНЕЕ РЕШЕНИЕ 24.10.2026 — упрощение SLS и отказ от Quads Bounty Board:** SLS использует ванильные рейды; Nemesis и объектное масштабирование отключены, звёзды, модификаторы обычных мобов и боссов сохранены. **`BountyBoard.dll` исключён из целевого списка на всех трёх ПК**, но удалять его только после демонтажа всех игровых досок и бэкапа контрактов/мира. Quads Companion / Party HUD остаются. **Исторический план до упрощения стрельбы: 46 обязательных S/C + 10 Only Client = 56 DLL; актуальный план: 44 S/C + 11 Only Client = 55 DLL, плюс отключённый DigDug = 56 учтённых.** MissingPieces отдельно в тестировании и сюда НЕ входит. [План миграции и настройки](SLS_VANILLA_RAIDS_AND_BOUNTY_RETIREMENT_2026-10-24.md).


**Статус:** согласованный целевой состав после отказа от BossGate; список DLL из README, а не повторная проверка диска. **44 общих (хост и оба друга) + 11 необязательных клиентских = 55 активных DLL по плану**; `DigDug.dll*` намеренно выключен (всего 56 учтённых). Реальное удаление DLL у трёх игроков ещё не проверено.

**ОБНОВЛЕНИЕ СТАТУСА 24.10.2026:** пользователь сообщил, что **PlanBuild и ModularLadders установлены** у него; получен [PlanBuild v0.20.0 CFG](config/marcopogo.PlanBuild.cfg). По одним сообщениям/CFG нельзя подтвердить версию фактической DLL, отсутствие ошибок загрузки и наличие у двух друзей. **MissingPieces 2.3.2 выбран отдельно для ТЕСТА**, пока не считается 48-й S/C DLL. **Cartur's Flooring, Sinka, BronzeAgeChest — только кандидаты.** [Подробности](BUILDING_MODS_TEST_2026-10-24.md). Историческая база до отказа от Bounty Board: **47 S/C + 10 C = 57 DLL**; после отказа **46 S/C + 10 C = 56 DLL**.

**ИСТОРИЧЕСКОЕ РАСПОРЯЖЕНИЕ (теперь сообщено об установке) — PlanBuild:** `PlanBuild.dll` **0.20.0** на P2P-хосте и обоих друзьях. BepInExPack и Jötunn уже входят в список; HookGenPatcher не требуется. Схемы домов сохраняются в `.blueprint` и могут включать предметы из сундуков, но воспроизведение предметов только через Direct Build (бесплатная постройка/риск дубликатов). **Сначала бэкап мира, тест на одном сундуке; позднее пользователь прислал CFG, см. ссылку выше.** [Подробная процедура](PLANBUILD_REBUILD_2026-10-24.md).

**ИСТОРИЧЕСКОЕ РАСПОРЯЖЕНИЕ (теперь сообщено об установке):** `ModularLadders.dll` v1.0.0 на P2P-хосте и у двух друзей. Автор требует присутствия у всех из-за дополнительных строительных объектов. BepInEx уже используется; Jötunn не требуется. Лестницы исчезнут при удалении DLL, поэтому не удалять без бэкапа мира. **CFG не создавать.** [Решение](MOD_DECISIONS_2026-10-24.md).

**УДАЛИТЬ при следующей локальной синхронизации:** `BossGate.dll` у хоста и обоих игроков. Конфиг удалён из активной папки Git и сохранён в [архиве](retired-configs/Igao.BossGate.cfg); не копировать его обратно в `BepInEx/config/`. **XPortal.dll остаётся.** Каменные порталы позволяют переносить руду/металлы без BossGate. EpicLoot-гейтинг добычи не изменён.

**ИСКЛЮЧЁН Quads Bounty Board (ранее):** `BountyBoard.dll` (прошлый №35) удалить/перенести в отключённые DLL **только после демонтажа игровых досок**, закрытия или сохранения групповых контрактов и резервной копии мира. [Архив бывшего CFG](retired-configs/com.quad.bountyboard.cfg); не копировать обратно в рабочий `BepInEx/config/`. `AICompanion.dll` и Party HUD оставить. В Git игровой мир не меняется.

**PlantEasily для друзей:** `Advize_PlantEasily.dll` уже входит в 10 Only Client. Не добавлять MassFarming одновременно: вместо этого установить [отдельный профиль](client-presets/friends/advize.PlantEasily.cfg) с `E` и радиусом 3 м; у хоста [основной CFG](config/advize.PlantEasily.cfg) без изменений.

## Server / Client — 44

| № | Мод | DLL |
|---:|---|---|
| 1 | AchievementEnabler | `AchievementEnabler.dll` |
| 2 | AutomaticFuel | `AutomaticFuel.dll` |
| 3 | AzuCraftyBoxes | `AzuCraftyBoxes.dll` |
| 4 | Basements | `Basements.dll` |
| 5 | BetterTames | `BetterTames.dll` |
| 6 | BiggerPickupRadius | `BiggerPickupRadius.dll` |
| 7 | BuyableExtractors | `BuyableExtractors.dll` |
| 8 | ConditionalConfigSync | `ConditionalConfigSync.dll` |
| 9 | ConditionalConfigSync.Plugin | `ConditionalConfigSync.Plugin.dll` |
| 10 | Chain Manager | `Digitalroot.Valheim.ChainManager.dll` |
| 11 | ChilloutForcedPVP | `ChilloutForcedPVP.dll` |
| 12 | DoorDirector | `DoorDirector.dll` |
| 13 | EpicLoot | `EpicLoot.dll` |
| 14 | ExtraSlots | `ExtraSlots.dll` |
| 15 | FiresGhettoNetworking | `VAGhettoNetworking.dll` |
| 16 | ForsakenPowersPlusRemastered | `ForsakenPowersPlusRemastered.dll` |
| 17 | Area Repair | `FrizzQOL.AreaRepair.dll` |
| 18 | HoeRadius | `HoeRadius.dll` |
| 19 | HipLantern | `HipLantern.dll` |
| 20 | Instantly Destroy Boats And Carts | `InstantlyDestroyBoatsAndCarts.dll` |
| 21 | Jötunn / Valheim Library | `Jotunn.dll` |
| 22 | Stations Custom Ranges | `LzD_StationsCustomRanges.dll` |
| 23 | ModularLadders | `ModularLadders.dll` |
| 24 | MonsterLabZ | `MonsterLabZ.dll` |
| 25 | JsonDotNET — detector | `NewtonsoftJsonDetector.dll` |
| 26 | JsonDotNET / Newtonsoft.Json | `Newtonsoft.Json.dll` |
| 27 | NoFoodDegradation | `NoFoodDegradation.dll` |
| 28 | BlindCartographer | `BlindCartographer.dll` |
| 29 | OdinCampsite | `OdinCampsite.dll` |
| 30 | OdinRealmFishing | `OdinRealmFishingMod.dll` |
| 31 | OreMines | `OreMines.dll` |
| 32 | PlanBuild | `PlanBuild.dll` |
| 33 | Quick Stack Store | `QuickStackStore.dll` |
| 34 | Quads Companion | `AICompanion.dll` |
| 35 | SmartRepair | `SmartRepair.dll` |
| 36 | SolidHitboxes | `SolidHitboxes.dll` |
| 37 | Spearfishing | `Spearfishing.dll` |
| 38 | Stake Tweaks | `StakeTweaks.dll` |
| 39 | StarLevelSystem | `StarLevelSystem.dll` |
| 40 | TopMining | `TopMining.dll` |
| 41 | No Seasonal Restrictions | `VentureValheim.NoSeasonalRestrictions.dll` |
| 42 | XPortal | `XPortal.dll` |
| 43 | YamlDotNet — detector | `YamlDotNetDetector.dll` |
| 44 | YamlDotNet | `YamlDotNet.dll` |

## Only Client — 11 (по выбору игроков)

| № | Мод | DLL |
|---:|---|---|
| 1 | PlantEasily | `Advize_PlantEasily.dll` |
| 2 | BetterPickupNotifications | `BetterPickupNotifications.dll` |
| 3 | Quads Build Orders | `BuildOrders.dll` |
| 4 | Cartur's Compass and Clock | `CarturCompassAndClock.dll` |
| 5 | ConfigurationManager | `ConfigurationManager.dll` |
| 6 | FirstPersonMode | `FirstPersonMode.dll` |
| 7 | Quads Party HUD | `PartyHud.dll` |
| 8 | Venture Logout Tweaks | `VentureValheim.LogoutTweaks.dll` |
| 9 | WorkbenchesPlus | `WorkbenchesPlus.dll` |
| 10 | GooderAutoShield | `GooderAutoShield.dll` |
| 11 | Quads Quiver | `Quiver.dll` |

## Отложено — не входит в число DLL

- [SkillsReworked](https://thunderstore.io/c/valheim/p/M2Valheim/SkillsReworked/) — отложен.
- [TalentTree v2.3.5](https://thunderstore.io/c/valheim/p/M2Valheim/TalentTree/v/2.3.5/) — отложен; зависит от SkillsReworked.

## Исключены и архивированы

- `ProjectileTweaks.dll` — исключён 24.10.2026: больше не меняем скорость/прицеливание/зум/счётчик боеприпасов, функции возврата стрел и колчана остаются в `Quiver.dll`. CFG [архивирован](retired-configs/Searica.Valheim.ProjectileTweaks.cfg). Удаление локальной DLL у игроков ещё не проверено.
- `BountyBoard.dll` — исключён из списка ранее 24.10.2026, пользователь приступил к удалению; фактическое удаление на всех ПК и сохранность поставленных досок не подтверждены.

- `BossGate.dll` — **удалён из текущего плана 24.10.2026**. Никакой BossGate-only объект/предмет в мир не добавлялся; сохранять мир и героев всё равно обязательно перед изменением установленных модов.
- `DigDug.dll*` — по-прежнему намеренно выключен.
- `MassFarming.dll` — **не выбирать для друзей**, т.к. их единственная требуемая функция уже есть в PlantEasily; одновременная установка конфликтует.

Исторические контрольные снимки DLL до изменений не переписывать. [Каталог функций и ссылок](README.md); [политика распространения](DEPLOYMENT_POLICY_2026-10-21.md).
