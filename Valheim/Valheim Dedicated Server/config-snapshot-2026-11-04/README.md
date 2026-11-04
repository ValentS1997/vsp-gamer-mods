# Dedicated Server — exported BepInEx configuration snapshot

Snapshot date: **2026-11-04 16:26** (timestamp shown on `vsp-pc` for exported `~/Загрузки/Valheim Server` listing). Source: owner-uploaded ZIP of `config/` and text inventory of `plugins/`. **Source is an exported local directory, not a live read of the running guest**.

## Inventory
- Source ZIP: 140 members (including folder entries), configuration root and plugin data.
- Plugin inventory in supplied `ls -laR`: **43 DLL** across six categories. These are files on disk; their runtime loading is **not verified** by this snapshot.
- This directory contains **seven exact source CFG files** from the archive, independently scoped for the Dedicated Server. It is **not a full mirror of 140 ZIP entries**.
- Other CFG/JSON/YAML files from the archive have been inspected or inventoried, but **not committed as original files**. Do not confuse this partial safe import with a completed backup or full configuration synchronization.

## Server values extracted from supplied archive

| File | Verified value |
|---|---|
| `MidnightsFX.StarLevelSystem.cfg` | `MaxLevel=3`, boss HP `1.5`, damage `0.5`, Nemesis `true`, vanilla raids `false` |
| `randyknapp.mods.epicloot.cfg` | balance `legendary`, global drop `0.3`, item drop ratio `0.4`, bounty limit `true` |
| `com.Fire.FiresGhettoNetworkMod.cfg` | compression `true`, `ZDO Send Rate=_100`, auto-tune `true`, RPC router `true`, real-time world clock `true` |
| `com.quad.aicompanion.cfg` | `MaxCompanions=1`, `WhileAway=Mild` |
| `com.quad.aicompanion.more.cfg` | `FightRange=5`, `ShowDecisions=false`, respawn `30` |
| `advize.PlantEasily.cfg` | `ModActive=true`, `EnableModKey=KeypadPeriod`, bulk harvest `true`, radius `3` |
| `com.tomtom.doordirector.cfg` | enabled `true`, default delay `15`, only configured prefabs `true` |
| `TastyChickenLegs.AutomaticFuel.cfg` | mod toggle `F10`, enabled `true` |
| `nightkosh.BlindCartographer.cfg` | enabled `true`, hotkey text `false` |

## Source plugin inventory (no binaries committed)

### 000-Libraries (8)
- `ConditionalConfigSync.dll`
- `ConditionalConfigSync.Plugin.dll`
- `Jotunn.dll`
- `NewtonsoftJsonDetector.dll`
- `Newtonsoft.Json.dll`
- `VAGhettoNetworking.dll`
- `YamlDotNetDetector.dll`
- `YamlDotNet.dll`

### 002-CGM (4)
- `AICompanion.dll`
- `EpicLoot.dll`
- `MonsterLabZ.dll`
- `StarLevelSystem.dll`

### 004-Gameplay (15)
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

### 005-QOL (8)
- `BiggerPickupRadius.dll`
- `DoorDirector.dll`
- `FrizzQOL.AreaRepair.dll`
- `InstantlyDestroyBoatsAndCarts.dll`
- `NoFoodDegradation.dll`
- `SmartRepair.dll`
- `TopMining.dll`
- `XPortal.dll`

### 006-Automatization (4)
- `Advize_PlantEverything.dll`
- `AutomaticFuel.dll`
- `AzuCraftyBoxes.dll`
- `QuickStackStore.dll`

### 007-Object (4)
- `Basements.dll`
- `HipLantern.dll`
- `ModularLadders.dll`
- `OdinCampsite.dll`

Total: **43 DLL**. Also present: `004-Gameplay/ropesnap.wav` and a `Translations/` tree. Plugin versions and actual BepInEx load count require live logs.

## Exclusion/security policy

Do not publish: `EpicLoot/BountySaves/` (player bounty state), `EpicLoot/configstate.json` (runtime state), `StarLevelSystem/SavedData/` (world/raid/Nemesis state), local permissions/binds without review, or `StarLevelSystem/NemesisSettings.yaml` from a live world (may contain dynamically added bosses). Never commit passwords, credentials, private worlds, or backups.

The original uploaded ZIP is **not committed**. It contains excluded state; do not upload it wholesale. The canonical client `Valheim/config/` is separate and must not be overwritten by this server export.

## Next checkpoint

Complete security-reviewed import of remaining config and static JSON/YAML assets, then verify server runtime against this exported snapshot. No changes to deployed VM, Docker, game world, or server files were performed in this Git update.
