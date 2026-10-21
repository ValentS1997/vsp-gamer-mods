# Valheim vsp-gamer — evidence-based deployment audit (2026-10-21)

> **SUPERSEDED FOR DEPLOYMENT CHOICES:** [Final user-approved policy](DEPLOYMENT_POLICY_2026-10-21.md) requires **40 shared**, permits **7 optional client**, and excludes **1 DigDug**. The preliminary candidates and approvals described below are archived for technical evidence only, not instructions to move files.


> **PRELIMINARY — DO NOT DEPLOY AS A LOCKFILE OR AUTOMATED COPY PLAN.**
> This file documents current vendor documentation + user-selected deployment policy; no checksums, installed package versions, dedicated server log or join/leave tests were provided. All version and runtime compatibility claims remain [Needs confirmation].

## Semantics and accounting

- `Only Client` means optional per-player add-on; missing it must not break the **core Server/Client pack**. This is a **modpack acceptance requirement**, not synonymous with vendor “client-side” tag.
- `Server / Client` means core gameplay/asset/sync policy deployed to both sides **when technically applicable**, sometimes solely to standardize multiplayer behavior. A server install is NOT always a vendor requirement.
- `Only Server` means no client plugin needed: **0 positively evidenced in the 48-entry inventory**.
- **48 original entries = 7 user-approved Only Client + 1 excluded DigDug + 15 common-gameplay candidates + 7 optional-server/common-policy candidates + 7 library/dependency entries + 11 further client add-on candidates**.
- The **29 shared/dependency candidates are not 29 mandatory-server plugins**. Server-only list remains empty. Preserve 7 user-approved optional entries unchanged; the 11 suggestions are **NOT approved**.
- Browser research was performed on 2026-10-21; sources may mention more recent releases, but installed binaries are not identified by filename alone.

## Only Client — USER APPROVED (7)

```text
Advize_PlantEasily.dll
BetterPickupNotifications.dll
BuildOrders.dll
CarturCompassAndClock.dll
ConfigurationManager.dll
FirstPersonMode.dll
GooderAutoShield.dll
```

## Excluded from all builds (1)

`DigDug.dll*` (intentional disable-by-rename, retained by user); Custom Raids remains retired.

## Shared gameplay — server and client candidate (15)

| DLL | Evidence / policy decision | Source | Confidence in claim |
|---|---|---|---|
| `Basements.dll` | Shared new building content; server config sync (same package when sync wanted) | [vendor/readme](https://thunderstore.io/c/valheim/p/OdinPlus/Basements/) | medium |
| `BetterTames.dll` | All players recommended: nearest player simulates tames; server for ServerSync | [vendor/readme](https://thunderstore.io/c/valheim/p/xtavim/BetterTames/) | high |
| `BossGate.dll` | Server and every client explicitly required, client enforcement; KickClientsWithoutMod=true in snapshot | [vendor/readme](https://thunderstore.io/c/valheim/p/Igao/BossGate/) | high |
| `BuyableExtractors.dll` | Identical version on server and every client explicitly required | [vendor/readme](https://thunderstore.io/c/valheim/p/Rollstuhltreter/BuyableExtractors/) | high |
| `EpicLoot.dll` | Publisher explicitly specifies clients and dedicated server | [vendor/readme](https://thunderstore.io/c/valheim/p/RandyKnapp/EpicLoot/) | high |
| `ForsakenPowersPlusRemastered.dll` | Power behavior should be consistent; site marks both sides; no explicit mandatory-multiplayer sentence found | [vendor/readme](https://thunderstore.io/c/valheim/p/turbero/ForsakenPowersPlusRemastered/) | medium |
| `FrizzQOL.AreaRepair.dll` | Publisher explicitly specifies dedicated server and every client | [vendor/readme](https://thunderstore.io/c/valheim/p/FrizzQOL/Area_Repair/) | high |
| `MonsterLabZ.dll` | Adds synced creature prefabs; original package now deprecated, variant/version verification required | [vendor/readme](https://thunderstore.io/c/valheim/p/MonsterLabZ/MonsterLabZ/) | medium |
| `OdinCampsite.dll` | Adds shared custom pieces/items; ServerSync, package version must be verified | [vendor/readme](https://thunderstore.io/c/valheim/p/OdinPlus/OdinCampsite/) | medium |
| `OdinRealmFishingMod.dll` | Adds rods/traps/nets/recipes; Jotunn required; copy package assets such as ropesnap.wav, not just DLL | [vendor/readme](https://thunderstore.io/c/valheim/p/Odinrealm/OdinRealmFishing/) | medium |
| `OreMines.dll` | Adds persistent world locations; ServerSync; world backup essential | [vendor/readme](https://thunderstore.io/c/valheim/p/blacks7ar/OreMines/) | medium |
| `SolidHitboxes.dll` | Publisher says to install on dedicated server; AI collision and server-synced optional friendly fire | [vendor/readme](https://thunderstore.io/c/valheim/p/Korppis/SolidHitboxes/) | high |
| `StakeTweaks.dll` | Publisher specifies server and each client interacting with modified pieces; consistent config | [vendor/readme](https://thunderstore.io/c/valheim/p/TOOLKINGS/Stake_Tweaks/) | high |
| `StarLevelSystem.dll` | World creature levels, raids and loot; Jotunn and YAML dependencies; exact installed build unknown | [vendor/readme](https://thunderstore.io/c/valheim/p/MidnightMods/StarLevelSystem/) | medium |
| `XPortal.dll` | Shared portal behavior and Jotunn dependency; prior handoff classifies both; exact release/server check pending | [vendor/readme](https://thunderstore.io/c/valheim/p/SpikeHimself/XPortal/) | medium |

## Shared common-policy — server technically optional or still uncertain (7)

| DLL | Evidence / policy decision | Source | Confidence in claim |
|---|---|---|---|
| `AutomaticFuel.dll` | Publisher permits client-only; server+client if centrally pushing/refusing client configs is intended | [vendor/readme](https://thunderstore.io/c/valheim/p/TastyChickenLegs/AutomaticFuel/) | high |
| `AzuCraftyBoxes.dll` | Client works without dedicated-server module; server optional for ServerSync; include both only for common policy | [vendor/readme](https://thunderstore.io/c/valheim/p/Azumatt/AzuCraftyBoxes/) | high |
| `ExtraSlots.dll` | Can work client-only; if common slot rules/progression desired deploy both + ConditionalConfigSync | [vendor/readme](https://github.com/shudnal/ExtraSlots) | high |
| `LzD_StationsCustomRanges.dll` | Range changes expected on each participating client; source does not explicitly require dedicated server | [vendor/readme](https://thunderstore.io/c/valheim/p/LzD/LzD_Stations_Custom_Ranges/) | low |
| `ProjectileTweaks.dll` | Author confirms purely client-side works; server optional to enforce common configs | [vendor/readme](https://github.com/searica/ProjectileTweaks) | high |
| `Quiver.dll` | Author: only players who want it; host can supply authoritative arrow recovery config; optional both policy | [vendor/readme](https://thunderstore.io/c/valheim/p/Quads_Lab/Quads_Quiver/) | high |
| `Spearfishing.dll` | Author: server not required except config sync; shared policy if needed | [vendor/readme](https://thunderstore.io/c/valheim/p/Korppis/Spearfishing/) | high |

## Libraries — installation follows consuming plugins (both sides only when needed) (7)

| DLL | Evidence / policy decision | Source | Confidence in claim |
|---|---|---|---|
| `ConditionalConfigSync.dll` | Runtime+public API, must accompany ConditionalConfigSync.Plugin.dll where dependent mods run | [vendor/readme](https://www.nexusmods.com/valheim/mods/3451) | high |
| `ConditionalConfigSync.Plugin.dll` | BepInEx bootstrap; keep paired with ConditionalConfigSync.dll | [vendor/readme](https://www.nexusmods.com/valheim/mods/3451) | high |
| `Jotunn.dll` | Library: install on every machine running a dependent mod; not standalone gameplay plugin | [vendor/readme](https://valheim-modding.github.io/Jotunn/guides/installation.html) | high |
| `NewtonsoftJsonDetector.dll` | Dependency helper, follow Json.NET-consuming plugins; exact version/source mapping unknown | [vendor/readme](https://thunderstore.io/c/valheim/p/RandyKnapp/EpicLoot/) | low |
| `Newtonsoft.Json.dll` | JSON library consumed by e.g. EpicLoot; copy matching dependency package, not arbitrary DLL | [vendor/readme](https://thunderstore.io/c/valheim/p/RandyKnapp/EpicLoot/) | medium |
| `YamlDotNetDetector.dll` | Dependency helper, follow YAML-consuming plugins; exact version/source mapping unknown | [vendor/readme](https://thunderstore.io/c/valheim/p/MidnightMods/StarLevelSystem/) | low |
| `YamlDotNet.dll` | YAML library: dependency of StarLevelSystem per author; verify package version | [vendor/readme](https://thunderstore.io/c/valheim/p/MidnightMods/StarLevelSystem/) | medium |

## Further client-only/optional candidates — NOT APPROVED (11)

| DLL | Evidence / policy decision | Source | Confidence in claim |
|---|---|---|---|
| `AchievementEnabler.dll` | Achievement gate is player-facing; note package can also include BepInEx/patchers/ preloader, absent from 48-DLL inventory | [vendor/readme](https://thunderstore.io/c/valheim/p/MidnightMods/AchievementEnabler/) | medium |
| `BiggerPickupRadius.dll` | Local pickup-radius tweak; multiplayer server requirement not established; very old upstream release | [vendor/readme](https://thunderstore.io/c/valheim/p/mtnewton/BiggerPickupRadius/) | low |
| `Digitalroot.Valheim.ChainManager.dll` | Craftable chain, Jotunn dependency, documented crossplay with clients/server without mod; decide whether recipe is required modpack content | [vendor/readme](https://thunderstore.io/c/valheim/p/Digitalroot/Chain_Manager/) | high |
| `HoeRadius.dll` | User interface/building operation; install side is hypothesis, no matching explicit vendor server rule verified | [vendor/readme](https://github.com/aedenthorn/ValheimMods) | low |
| `InstantlyDestroyBoatsAndCarts.dll` | Client-side activation of hammer destroy; world-change behavior and server permissions require multiplayer test | [vendor/readme](https://thunderstore.io/c/valheim/p/Goldenrevolver/Instantly_Destroy_Boats_And_Carts/) | low |
| `NoFoodDegradation.dll` | Changes food stat degradation; likely player-side, server-authority not proved by author documentation | [vendor/readme](https://thunderstore.io/c/valheim/p/Dreich/NoFoodDegradation/) | low |
| `NoMapCartographyTable.dll` | Cartography access in No-Map world; explicit server requirements not documented | [vendor/readme](https://thunderstore.io/c/valheim/p/Dreich/NoMapCartographyTable/) | low |
| `QuickStackStore.dll` | Author: designed as client-side; server optional for settings sync; caveat MultiUserChest interactions | [vendor/readme](https://www.nexusmods.com/valheim/mods/2094?tab=posts) | high |
| `SmartRepair.dll` | Author explicitly states client-only; server not needed | [vendor/readme](https://thunderstore.io/c/valheim/p/LJIndustries/SmartRepair/) | high |
| `TopMining.dll` | Author explicitly states client-only; mining world effects should be tested multiplayer | [vendor/readme](https://thunderstore.io/c/valheim/p/NexusTransfer/TopMining/) | high |
| `VentureValheim.NoSeasonalRestrictions.dll` | Author explicitly states client-only; server not needed | [vendor/readme](https://thunderstore.io/c/valheim/p/VentureValheim/No_Seasonal_Restrictions/) | high |

## Open blockers / acceptance checks

1. Collect **actual plugin and patcher inventory, BepInEx versions, package versions, and SHAs** from client and dedicated server. Verify plugin GUID/hard dependencies; check `BepInEx/patchers`, not just `*.dll` in plugins. `AchievementEnabler` may require a preloader in patchers.
2. Confirm whether the user wants the **11 proposed extra client mods** to become optional, part of an enforced common client baseline, or retired. Do not silently expand approved Only Client list.
3. For seven *common-policy* candidates, confirm if dedicated-server configuration enforcement is wanted; verify exact version behavior. Do not equate convenient server syncing with mandatory installation.
4. Verify all 15 gameplay candidates and their dependencies, especially MonsterLabZ (original package deprecated/forks exist), EpicLoot and SLS, against installed release and dedicated server logs. `OdinRealmFishingMod` relies on packaged non-DLL assets; deploying only DLL is insufficient.
5. Stand up disposable test world with backed-up original saves. Verify boot, connection with an *approved Only Client-free* client, boss/portal gating, SLS/MonsterLabZ spawns, EpicLoot drop, inventory slots, tames ownership, and portal sync. Revert by restoring a complete backed-up plugin/config snapshot and world copy; do not remove world-content mods on the live world to test.
6. Freeze manifests only after successful join tests and exact version/hash documentation. This file is an **audit**, not the final `SERVER_PLUGINS.txt` or `CLIENT_PLUGINS.txt`.

## Additional recorded decisions

- `AutomaticFuel [General] / Mod ToggleKey = None` is **user-decided, not verified applied**. PlantEasily retains `F10`.
- Do not undo `DigDug.dll*` rename. It is excluded from all builds.
- No active files, configurations, worlds, dependencies, or binaries were changed during this audit.
