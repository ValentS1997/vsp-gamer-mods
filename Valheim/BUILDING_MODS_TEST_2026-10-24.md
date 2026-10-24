# Valheim — Building mods: test selection and saved candidates (2026-10-24)

> **LATEST GLOBAL COUNT (24.10.2026):** After retiring `ProjectileTweaks.dll` and reclassifying Quads Quiver as client-only, target now **44 S/C + 11 C = 55 chosen DLL**; the older 46+10=56 and 47+10=57 totals below are historical. [Archery decision](ARCHERY_QUIVER_ONLY_2026-10-24.md). MissingPieces still test-only and not included. No local installation implied.

> **CURRENT GLOBAL DLL COUNT UPDATE (24.10.2026):** With Quads Bounty Board retired after this earlier building-mod selection, core target is now **46 S/C + 10 client-only = 56 DLL**, not the **47+10=57** shown below in historical accounting sections. MissingPieces remains test-only (not promoted), Cartur's Flooring / Sinka / BronzeAgeChest still candidates. See [latest decision](SLS_VANILLA_RAIDS_AND_BOUNTY_RETIREMENT_2026-10-24.md). The rest of this test audit remains unchanged.

This file records the **latest explicit user decision** and overrides older pending-mod notes. Scope: Valheim 1.0.20, native Linux, 3 human players, P2P host. User-reported installation is **not** proof of runtime DLL metadata or installation on all three peers.

## Latest decision: MissingPieces test

- **[BentoG / MissingPieces](https://thunderstore.io/c/valheim/p/BentoG/MissingPieces/)** — **USER SELECTED FOR TESTING**, reference version **2.3.2** (previously researched, recheck before download).
- It has separate flat roof prefab IDs `roof_wood_2m`, `roof_darkwood_2m` and independent chest/drawer prefab `piece_chest_wooden_drawer`. Reported default crafting costs: roof wood 2 Wood; darkwood 2 Wood + 1 Tar; drawer 10 FineWood + 2 Iron + 1 Coal.
- **Not yet confirmed installed or successfully used.** Stage as a test-only addition; **do not silently mark it as part of the 57-DLL baseline** until the user approves promotion after tests. Intended shared S/C deployment on P2P host and both friends because it adds persistent construction prefab objects.
- Before test: backup world `.db` and `.fwl` plus characters; use a cloned world; check DLL dependencies, all-peer consistency, piece durability and roof rain cover, saves/reloads, drawer access, inventory persistence and PlanBuild blueprint capture/direct-build behavior.
- Removing a prefab mod from a world containing its pieces carries object/item loss risk.

## Save as candidates — not selected, no CFG or DLL changes

| Candidate | Link | Notes |
|---|---|---|
| Cartur's Flooring | https://thunderstore.io/c/valheim/p/Cartur/Carturs_Flooring/ | Existing floors act as rain-cover roofs; previous research version 1.1.4; client presence on all participating peers should be tested |
| Sinka | https://thunderstore.io/c/valheim/p/Ezomic/Sinka/ | Snapping and vertical stacking of containers; previous research version 1.3.1; when StackContainers enabled, all peers must install to avoid destruction through unsupported-piece calculations |
| BronzeAgeChest | https://thunderstore.io/c/valheim/p/probablykory/BronzeAgeChest/ | Separate `piece_chest_bronze`, 15 slots in prior research; configurable recipe, not a high-capacity chest; previous research version 1.0.8 |

**MissingPiecesFix** (https://thunderstore.io/c/valheim/p/lhoffl_MissingPiecesFix/MissingPiecesFix/) — historical fork/link from the user's earlier candidate selection. **Not selected for test and should not be installed alongside BentoG MissingPieces**; earlier research marked this fork deprecated.

## Existing selected mods — user-reported installation update

- **PlanBuild** — USER REPORTED INSTALLED on their Valheim setup (2026-10-24); attached configuration is `config/marcopogo.PlanBuild.cfg` with header `PlanBuild v0.20.0`. BepInEx runtime plugin version, error-free load, and both friends' installations are **UNVERIFIED**. Already counted among the baseline 47 S/C — no additional count.
- **ModularLadders** — USER REPORTED INSTALLED (2026-10-24); DLL version and full peer deployment **UNVERIFIED**. Already counted among the baseline 47 S/C — no additional count.
- **PlanBuild CFG options** from attachment: `Default build mode = Planned`, `Allow direct build = false` (admins exempt), `Allow terrain tools = false`, `Allow blueprint rune = true`, `Save directory = BepInEx/config/PlanBuild/blueprints`, `Blueprint Marketplace GUI toggle key = End`, `Toggle = Q`, `Mirror = H`.
- **Potential key collisions**: PlanBuild Mirror = `H` overlaps existing HipLantern toggle `H` and EpicLoot ability 2 `H`; test in-game, rebind deliberately if simultaneous handling occurs. `Q` may overlap vanilla auto-run; contextual behavior not tested.
- Copy of the CFG is a snapshot of the supplied configuration file, **not proof of successful plugin loading**. No CFG settings were altered for this documentation task.

## DLL accounting

- **Existing baseline unchanged:** 47 S/C + 10 Only Client = **57 selected active DLL**, plus disabled DigDug = 58 accounted.
- **1 separately selected test candidate:** MissingPieces; if and only if user later promotes it to the active mandatory bundle and it adds one DLL, then 48 S/C + 10 client = 58 selected active DLL.
- **3 saved pending candidates:** Cartur's Flooring, Sinka, BronzeAgeChest. None counted.
- No mod installation, world files, player data, or private saves are modified by this Git documentation update.
