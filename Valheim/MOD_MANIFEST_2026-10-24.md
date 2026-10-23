# VSP Gamer — актуальный DLL-манифест Valheim (24.10.2026)

**Статус:** согласованный целевой состав после отказа от BossGate; список DLL из README, а не повторная проверка диска. **46 общих (хост и оба друга) + 10 необязательных клиентских = 56 активных DLL по плану**; `DigDug.dll*` намеренно выключен (всего 57 учтённых). Реальное удаление DLL у трёх игроков ещё не проверено.

**ДОБАВИТЬ при следующей локальной синхронизации:** `ModularLadders.dll` v1.0.0 на P2P-хосте и у двух друзей. Автор требует присутствия у всех из-за дополнительных строительных объектов. BepInEx уже используется; Jötunn не требуется. Лестницы исчезнут при удалении DLL, поэтому не удалять без бэкапа мира. **CFG не создавать.** [Решение](MOD_DECISIONS_2026-10-24.md).

**УДАЛИТЬ при следующей локальной синхронизации:** `BossGate.dll` у хоста и обоих игроков. Конфиг удалён из активной папки Git и сохранён в [архиве](retired-configs/Igao.BossGate.cfg); не копировать его обратно в `BepInEx/config/`. **XPortal.dll остаётся.** Каменные порталы позволяют переносить руду/металлы без BossGate. EpicLoot-гейтинг добычи не изменён.

**PlantEasily для друзей:** `Advize_PlantEasily.dll` уже входит в 10 Only Client. Не добавлять MassFarming одновременно: вместо этого установить [отдельный профиль](client-presets/friends/advize.PlantEasily.cfg) с `E` и радиусом 3 м; у хоста [основной CFG](config/advize.PlantEasily.cfg) без изменений.

## Server / Client — 46

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
| 32 | ProjectileTweaks | `ProjectileTweaks.dll` |
| 33 | Quick Stack Store | `QuickStackStore.dll` |
| 34 | Quads Bounty Board | `BountyBoard.dll` |
| 35 | Quads Companion | `AICompanion.dll` |
| 36 | Quads Quiver | `Quiver.dll` |
| 37 | SmartRepair | `SmartRepair.dll` |
| 38 | SolidHitboxes | `SolidHitboxes.dll` |
| 39 | Spearfishing | `Spearfishing.dll` |
| 40 | Stake Tweaks | `StakeTweaks.dll` |
| 41 | StarLevelSystem | `StarLevelSystem.dll` |
| 42 | TopMining | `TopMining.dll` |
| 43 | No Seasonal Restrictions | `VentureValheim.NoSeasonalRestrictions.dll` |
| 44 | XPortal | `XPortal.dll` |
| 45 | YamlDotNet — detector | `YamlDotNetDetector.dll` |
| 46 | YamlDotNet | `YamlDotNet.dll` |

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

## Отложено — не входит в число DLL

- [SkillsReworked](https://thunderstore.io/c/valheim/p/M2Valheim/SkillsReworked/) — отложен.
- [TalentTree v2.3.5](https://thunderstore.io/c/valheim/p/M2Valheim/TalentTree/v/2.3.5/) — отложен; зависит от SkillsReworked.

## Исключены и архивированы

- `BossGate.dll` — **удалён из текущего плана 24.10.2026**. Никакой BossGate-only объект/предмет в мир не добавлялся; сохранять мир и героев всё равно обязательно перед изменением установленных модов.
- `DigDug.dll*` — по-прежнему намеренно выключен.
- `MassFarming.dll` — **не выбирать для друзей**, т.к. их единственная требуемая функция уже есть в PlantEasily; одновременная установка конфликтует.

Исторические контрольные снимки DLL до изменений не переписывать. [Каталог функций и ссылок](README.md); [политика распространения](DEPLOYMENT_POLICY_2026-10-21.md).
