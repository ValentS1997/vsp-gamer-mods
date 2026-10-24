# VSP Gamer — Archery simplified to Quads Quiver (2026-10-24)

> **SUPERSEDED by [the final user-approved Quiver-only 75/75 profile](ARCHERY_FINAL_QUIVER_ONLY_2026-10-24.md) on 2026-10-24.** This document's `ChanceOnGround=1` and `IncludeBolts=false` were temporary intermediate choices; the FINAL values are `ChanceOnGround=0.75`, `ChanceOnCreature=0.75`, `IncludeBolts=true`. ProjectileTweaks stays excluded.

## Decision

User wants only (1) a chance to **recover fired arrows** and (2) a **visual quiver**. All other ProjectileTweaks gameplay changes are unnecessary. User also reported **"Quads Bounty Board удаляю"** — removal is **IN PROGRESS as reported**, not verified completed on all three PCs or in-world boards.

**Quads Quiver 0.2.4 alone meets both requested functions.** Quads Quiver has no dependency on ProjectileTweaks; official Thunderstore describes it as a **client-only** mod. The P2P host can set shared arrow recovery probabilities when their Quiver.dll is loaded; without host Quiver.dll each client uses its own config. Quiver visual is rendered on the user's own game/character only, not propagated to others.

## Active Quads Quiver settings

Git file: [`config/com.quad.quiver.cfg`](config/com.quad.quiver.cfg)

| Option | Value | Scope |
|---|---|---|
| `PickUpArrows` | `true` | Arrow recovery ON |
| `ChanceOnGround` | `1` | 100% for recoverable misses into ground/trees/walls |
| `ChanceOnCreature` | `0.75` | 75% when the creature actually dies and drops loot |
| `IncludeBolts` | **`false`** | Disable crossbow bolt recovery: only arrows |
| `FireArrowsBurnUp` | `true` | Keep fire-arrow consumption |
| `LogHits` | `false` | No debug logging |
| `Show` | `true` | Show cosmetic quiver |
| `Back/Side/Height/TiltSide/TiltBack` | preserved | Retain prior visual placement |

**Quiver CFG changed in exactly one setting**: `IncludeBolts=true→false`. Other Quiver values unchanged. Saved byte-identical original: [`config-backups/com.quad.quiver_before_arrows_only_2026-10-24.cfg`](config-backups/com.quad.quiver_before_arrows_only_2026-10-24.cfg).

## Retire ProjectileTweaks

- Remove `ProjectileTweaks.dll` **from the active `BepInEx/plugins/`** on the P2P host and both clients, after stopping games, preserving a backup of existing local files.
- Its former active `config/Searica.Valheim.ProjectileTweaks.cfg` has been archived byte-identically at [`retired-configs/Searica.Valheim.ProjectileTweaks.cfg`](retired-configs/Searica.Valheim.ProjectileTweaks.cfg). The Git active config copy was removed. This **does not remove anybody's installed mod**; only local players can deactivate it.
- ProjectileTweaks provided bow/crossbow/spear/staff/bomb projectile tuning (including nonvanilla launch angles and offsets), bow/crossbow zoom, ammo counter. Removing it also **restores vanilla trajectory, launch points and zoom behavior** — these are intentional changes, not regressions. Be aware that its client-only zoom key `Mouse1` and cancel-draw `E` will no longer be active.
- No associated persistent world building pieces in this change, and no other DLL dependencies on ProjectileTweaks were found in Quads Quiver's Thunderstore dependency declaration. Still back up world and character before mod removal as general precaution.

## Corrected client-only classification and counts

Quads Quiver explicitly states `Who needs it: Only the players who want it`. We move `Quiver.dll` from mandatory S/C to **optional client-only**. For the 3-player P2P game the **host should keep Quiver.dll** if shared return chances are desired; the other 2 friends can choose whether to install. No enforced peer requirement.

- Previous after Bounty Board retirement: **46 shared S/C + 10 client-only = 56 chosen DLL**.
- New planned: **44 shared S/C + 11 optional client-only = 55 chosen DLL**, plus disabled DigDug = **56 accounted**.
- Arithmetic: remove ProjectileTweaks.dll (−1) and move Quiver.dll from S/C to C (net 0). BountyBoard.dll had **already been excluded in the previous decision**; do not subtract again.
- MissingPieces remains separate **FOR TEST**, not promoted into selected baseline.

## Safe application / rollback

1. Stop Valheim on host + friends. Back up each `BepInEx/config` file about to be touched; take world `.db/.fwl` and character backups.
2. **P2P host**: move `ProjectileTweaks.dll` outside active `BepInEx/plugins` to a disabled archive outside that directory. Keep `Quiver.dll`. Compare local `com.quad.quiver.cfg` with Git; retain any private settings and set `IncludeBolts = false` (other keys retain previous values). Restart.
3. **Friends**: remove ProjectileTweaks.dll; Quiver.dll optional. If installed, their own quiver visual is visible to them and host's arrow settings apply.
4. Validate bow aim and arrows dropped on the ground; count recoverable arrows against target chances. Verify arrows stuck in creatures return only if creature is killed; confirm **bolts do not return** and quiver remains visible. Verify no errors in `BepInEx/LogOutput.log` and test Quads Companion interactions.
5. **Bounty Board separate removal, user reported IN PROGRESS**: before disabling `BountyBoard.dll` on all peers, dismantle placed custom boards and claim rewards with DLL still active; back up world + contract data. Do not assume completion without a later user confirmation.
6. Rollback if necessary: restore `ProjectileTweaks.dll` and archived config to their original locations on whichever peers used it, and restore Quiver CFG original file if bolt pickup is desired.

**Validation:** Git config and DLL manifest verified, actual loaded DLL versions/physical installation and in-game behavior **pending user test**.
