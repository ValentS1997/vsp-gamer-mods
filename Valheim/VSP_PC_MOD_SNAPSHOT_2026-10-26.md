# vsp-pc — актуальный снимок сборки Valheim от 26.10.2026

Источник: предоставленный владельцем `ls -laR BepInEx/` и архив `BepInEx/config/`. Это **фиксация фактического состояния vsp-pc**, не новая политика обязательной установки друзьям. Снимок локальный: текущая загрузка всех DLL в игровом процессе отдельно не проверялась.

Всего **62 файлов плагинов**: **53 имени с окончанием `.dll`** и **9 файлов с буквальным `*` после `.dll`**, то есть они не загружаются как обычные BepInEx-плагины. `*` здесь часть имени файла на диске в этом снимке, а не условная метка манифеста. Никакие физические файлы DLL в Git не добавлялись.

| Каталог | Файлов |
|---|---:|
| `000-Libraries/` | 8 |
| `002-CGM/` | 4 |
| `003-Admin/` | 3 |
| `003-Building/` | 6 |
| `004-Gameplay/` | 15 |
| `005-QOL/` | 8 |
| `006-Automatization/` | 4 |
| `007-Object/` | 4 |
| `999-Client/` | 10 |
| **Итого** | **62** |

## Фактические имена файлов по каталогам

### `000-Libraries/`

- `ConditionalConfigSync.dll`
- `ConditionalConfigSync.Plugin.dll`
- `Jotunn.dll`
- `NewtonsoftJsonDetector.dll`
- `Newtonsoft.Json.dll`
- `VAGhettoNetworking.dll`
- `YamlDotNetDetector.dll`
- `YamlDotNet.dll`

### `002-CGM/`

- `AICompanion.dll`
- `EpicLoot.dll`
- `MonsterLabZ.dll`
- `StarLevelSystem.dll`

### `003-Admin/`

- `ServerDevcommands.dll*`
- `UpgradeWorld.dll*`
- `WorldEditCommands.dll*`

### `003-Building/`

- `BuildOrders.dll*`
- `ComfyGizmo.dll*`
- `DigDug.dll*`
- `PlanBuild.dll*`
- `Sinka.dll*`
- `SmartBuild.dll*`

### `004-Gameplay/`

- `AchievementEnabler.dll`
- `BetterTames.dll`
- `BlindCartographer.dll`
- `BuyableExtractors.dll`
- `ChilloutForcedPVP.dll`
- `Digitalroot.Valheim.ChainManager.dll`
- `ExtraSlots.dll`
- `ForsakenPowersPlusRemastered.dll`
- `LzD_StationsCustomRanges.dll`
- `OdinRealmFishingMod.dll`
- `OreMines.dll`
- `Quiver.dll`
- `SolidHitboxes.dll`
- `Spearfishing.dll`
- `StakeTweaks.dll`

### `005-QOL/`

- `BiggerPickupRadius.dll`
- `DoorDirector.dll`
- `FrizzQOL.AreaRepair.dll`
- `InstantlyDestroyBoatsAndCarts.dll`
- `NoFoodDegradation.dll`
- `SmartRepair.dll`
- `TopMining.dll`
- `XPortal.dll`

### `006-Automatization/`

- `Advize_PlantEverything.dll`
- `AutomaticFuel.dll`
- `AzuCraftyBoxes.dll`
- `QuickStackStore.dll`

### `007-Object/`

- `Basements.dll`
- `HipLantern.dll`
- `ModularLadders.dll`
- `OdinCampsite.dll`

### `999-Client/`

- `Advize_PlantEasily.dll`
- `BetterPickupNotifications.dll`
- `CarturCompassAndClock.dll`
- `ConfigurationManager.dll`
- `FirstPersonMode.dll`
- `GooderAutoShield.dll`
- `PartyHud.dll`
- `VentureValheim.LogoutTweaks.dll`
- `VentureValheim.NoSeasonalRestrictions.dll`
- `WorkbenchesPlus.dll`

## Ручные настройки в этом снимке

- StarLevelSystem: `EnableNemesisSystem = true`, `UseVanillaRaidConfiguration = false`, `EnableNemesisRemoteSpawning = false`.
- StarLevelSystem: `EnemyHealthMultiplier = 2`, `BossEnemyHealthMultiplier = 1`, `BossEnemyDamageMultiplier = 0.1`.
- StarLevelSystem: `MaxLevel = 3`, `MaxBossLevel = 3`, `ShowQuickConfigureButton = true`.
- `LevelSettings.yaml`: `EnableConditionalCreatureLevelupChance = true` — условное повышение уровней включено, оно не обязательно ограничено тремя уровнями.
- `RaidSettings.yaml`: `GlobalRaidIntervalScalar = 2`, `GlobalRaidChanceScalar = 0.5`, `RaidCreatureDensity = 2`.
- DoorDirector: `Only Affect Configured Prefabs = true`; общая задержка и задержка персональной двери — по 15 секунд. `Enabled = true` и `Allow Owned Door Controls = true`.
- Баланс Nemesis и SLS-рейдов владелец намеренно будет корректировать в ходе игры.

## Чертежи и данные, которые нельзя смешивать с базовыми конфигами

В архиве имеются `PlanBuild/blueprints/Админ_Сарай.blueprint` и `PlanBuild/blueprints/Админ_База_на_лугах.blueprint`. Хранение чертежей и игровых данных рекомендуется вести отдельно от обязательного дистрибутива конфигов. В состав этого текстового снимка они не включены.

В `StarLevelSystem/SavedData/` находятся записи рейдов и Nemesis; в `EpicLoot/BountySaves/` — состояние охоты; присутствуют персональные `QuickStackStore_player_*.dat`, `DHack.BountyBoard.*.txt`, `BuildOrders/*.txt`. Эти файлы **не следует автоматически включать** в общий комплект для друзей или заменять при обновлении.

Конфиги снятых модов (`CarturFlooring`, `BountyBoard`, `HoeRadius`, `ProjectileTweaks`) могут оставаться на диске; это не доказательство загрузки их DLL. Не восстанавливать исключённые моды только на основании наличия старого CFG.

## Сверка с Git

Основной CFG StarLevelSystem и DoorDirector обновлены по снимку. Из YAML перенесены проверенные переключатели уровней и плотности рейдов; дополнительные пользовательские изменения отдельных файлов могут требовать отдельной синхронизации. Этот файл — **снимок, а не подтверждение полного копирования всего ZIP в Git**.

Исторический [манифест 24.10.2026](MOD_MANIFEST_2026-10-24.md) сохранён без переписывания исходных тестов и классификации.
