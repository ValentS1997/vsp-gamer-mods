# VSP Gamer — актуальный DLL-манифест Valheim (24.10.2026)

**Статус:** согласованный целевой состав после отказа от BossGate; список DLL из README, а не повторная проверка диска. **45 общих (хост и оба друга) + 10 необязательных клиентских = 55 активных DLL по плану**; `DigDug.dll*` намеренно выключен (всего 56 учтённых). Реальное удаление DLL у трёх игроков ещё не проверено.

**УДАЛИТЬ при следующей локальной синхронизации:** `BossGate.dll` у хоста и обоих игроков. Конфиг удалён из активной папки Git и сохранён в [архиве](retired-configs/Igao.BossGate.cfg); не копировать его обратно в `BepInEx/config/`. **XPortal.dll остаётся.** Каменные порталы позволяют переносить руду/металлы без BossGate. EpicLoot-гейтинг добычи не изменён.

**PlantEasily для друзей:** `Advize_PlantEasily.dll` уже входит в 10 Only Client. Не добавлять MassFarming одновременно: вместо этого установить [отдельный профиль](client-presets/friends/advize.PlantEasily.cfg) с `E` и радиусом 3 м; у хоста [основной CFG](config/advize.PlantEasily.cfg) без изменений.

## Server / Client — 45

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
| 23 | MonsterLabZ | `MonsterLabZ.dll` |
| 24 | JsonDotNET — detector | `NewtonsoftJsonDetector.dll` |
| 25 | JsonDotNET / Newtonsoft.Json | `Newtonsoft.Json.dll` |
| 26 | NoFoodDegradation | `NoFoodDegradation.dll` |
| 27 | BlindCartographer | `BlindCartographer.dll` |
| 28 | OdinCampsite | `OdinCampsite.dll` |
| 29 | OdinRealmFishing | `OdinRealmFishingMod.dll` |
| 30 | OreMines | `OreMines.dll` |
| 31 | ProjectileTweaks | `ProjectileTweaks.dll` |
| 32 | Quick Stack Store | `QuickStackStore.dll` |
| 33 | Quads Bounty Board | `BountyBoard.dll` |
| 34 | Quads Companion | `AICompanion.dll` |
| 35 | Quads Quiver | `Quiver.dll` |
| 36 | SmartRepair | `SmartRepair.dll` |
| 37 | SolidHitboxes | `SolidHitboxes.dll` |
| 38 | Spearfishing | `Spearfishing.dll` |
| 39 | Stake Tweaks | `StakeTweaks.dll` |
| 40 | StarLevelSystem | `StarLevelSystem.dll` |
| 41 | TopMining | `TopMining.dll` |
| 42 | No Seasonal Restrictions | `VentureValheim.NoSeasonalRestrictions.dll` |
| 43 | XPortal | `XPortal.dll` |
| 44 | YamlDotNet — detector | `YamlDotNetDetector.dll` |
| 45 | YamlDotNet | `YamlDotNet.dll` |

## Only Client — 10 (по выбору игроков)

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

## Исключены и архивированы

- `BossGate.dll` — **удалён из текущего плана 24.10.2026**. Никакой BossGate-only объект/предмет в мир не добавлялся; сохранять мир и героев всё равно обязательно перед изменением установленных модов.
- `DigDug.dll*` — по-прежнему намеренно выключен.
- `MassFarming.dll` — **не выбирать для друзей**, т.к. их единственная требуемая функция уже есть в PlantEasily; одновременная установка конфликтует.

Исторические контрольные снимки DLL до изменений не переписывать. [Каталог функций и ссылок](README.md); [политика распространения](DEPLOYMENT_POLICY_2026-10-21.md).
