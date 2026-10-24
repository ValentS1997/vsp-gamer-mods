# Valheim VSP Gamer — SLS lean profile and Bounty Board retirement (24.10.2026)

**Status:** USER-APPROVED configuration direction, Git baseline updated only; NOT confirmed copied into the host's Valheim folders, NOT yet playtested. This supersedes earlier proposals to disable ordinary creature modifiers. The world, player saves, plugin binaries, and installed local config files were not touched.

## Explicit user decisions

1. **Vanilla Valheim raids:** enabled by `UseVanillaRaidConfiguration = true`; old 24 custom SLS raid definitions are retained as an archive, but are not active when using this switch.
2. **Starred ordinary creatures:** remain enabled, including extended star distributions and star-dependent HP/damage, visuals and size behavior.
3. **Ordinary creature Major/Minor modifiers:** KEEP enabled, with unchanged chances and limits.
4. **Starred and buffed bosses:** KEEP boss control, HP per star, and all Boss/Major/Minor modifiers unchanged.
5. **Nemesis**: OFF, including dynamic star manipulation and Nemesis ambushes/minibosses.
6. **Object levels**: OFF for birds, fish, tree size/deterministic tree scaling. Rocks were already OFF. Night spawn unlocks remain vanilla-like (do not suppress post-boss spawns).
7. **Quads Bounty Board**: retire standalone `BountyBoard.dll` from all three peers after safe in-world removal. Do not remove `AICompanion.dll` or optional Party HUD.

## Exact changes in SLS CFG

Active Git file: [`config/MidnightsFX.StarLevelSystem.cfg`](config/MidnightsFX.StarLevelSystem.cfg). Every value beyond the six below is byte-for-byte unchanged in the Git baseline.

| INI section | Key | Old | New |
|---|---|---|---|
| `[Raids]` | `UseVanillaRaidConfiguration` | false | **true** |
| `[Nemesis]` | `EnableNemesisSystem` | true | **false** |
| `[ObjectLevels]` | `EnableScalingBirds` | true | **false** |
| `[ObjectLevels]` | `EnableScalingFish` | true | **false** |
| `[ObjectLevels]` | `EnableTreeScaling` | true | **false** |
| `[ObjectLevels]` | `UseDeterministicTreeScaling` | true | **false** |

Already OFF / retained OFF: `EnableNemesisRemoteSpawning=false`, `EnableRockLevels=false`, `EnableLocationReset=false`, `EnableDistanceLevelScalingBonus=false`, `EnableZoneScalingBonus=false`, SLS multiplayer global HP/damage scaling flags = false.

**Explicitly preserved:**
- `MaxLevel=3`, `MaxBossLevel=3`; `DefaultCreatureLevelUpChance`, `BossLevelupGenerators` and special `dhack_companion` exception in `LevelSettings.yaml` unchanged.
- `ControlSpawnerLevels=true`, `ControlBossSpawns=true`, `EnableCreatureScalingPerLevel=true`, `EnableColorization=true`.
- Ordinary mob modifiers: `MaxMajorModifiersPerCreature=1`, `MaxMinorModifiersPerCreature=1`, `ChanceMajorModifier=0.15`, `ChanceMinorModifier=0.25`, `LimitCreatureModifiersToCreatureStarLevel=true`.
- Boss scaling: `BossEnemyHealthMultiplier=0.75` **per star** and `BossEnemyDamageMultiplier=0.02` unchanged. A boss with 0 stars is not boosted by that HP-per-star multiplier.
- Boss modifiers: `EnableBossModifiers=true`, `MaxBossModifiersPerBoss=2`, `ChanceOfBossModifier=1`, `MaxMajorModifiersPerBoss=1`, `MaxMinorModifiersPerBoss=1`, both 0.65 chances unchanged. Modifier-limit by stars is unchanged; a 0★ boss does not automatically receive the full assortment of modifiers.
- Vanilla post-boss night spawns (`EikthyrNightSpawns`, `ElderNightSpawns`, etc.) remain true: setting them false would suppress vanilla unlocks rather than merely simplify the SLS system.

**Conscious remaining scope:** This is a **lean profile, not a total "stars and bosses only" engine**. `LootSettings.yaml` still defines custom entries (Abomination, BlobElite, etc.), `PerLevelLootScale=1`, `PerLevelLootChanceScale=0.05`, egg behavior, loot stacking and additional `LevelSettings.yaml` exceptions remain as before. These were NOT silently changed because they may affect material economy, item progression, and compatibility with EpicLoot or other mods. If user later approves exact vanilla loot, audit first and propose a separate patch. Main SLS DLL cannot be fully stripped of all internal behavior via CFG.

## Disable Quads Bounty Board safely

`Quads Bounty Board` is **independent from StarLevelSystem and Quads Companion**. It adds custom buildable board prefabs and saves a host-controlled group contract state; no global `Enabled=false` switch exists in the current `com.quad.bountyboard.cfg`. Official instructions warn that clients/world areas loading **without the mod may delete placed board pieces**.

**Sequence, with the plugin STILL enabled initially:**
1. Have all three players leave the P2P session, and keep copies of the world `.db` and `.fwl`, each player's characters, host `BepInEx/config/com.quad.bountyboard.cfg`, and any Bounty Board-owned contract/state files alongside the host's settings. Do not guess or delete unknown state files.
2. In the existing world **with BountyBoard still loaded**, finish/turn in any desired group contracts and manually dismantle/remove **every placed Bounty Board**; verify any stored contents or rewards before demolition.
3. Quit Valheim on **all three PCs**.
4. On all three computers, remove **only** `BountyBoard.dll` from `BepInEx/plugins/`, preferably move to a disabled archive outside the active plugins tree. Do not remove BepInEx, `AICompanion.dll`, Party HUD, or other Quads DLLs.
5. Retire `com.quad.bountyboard.cfg` outside the active `BepInEx/config/` folder (optional inert file but best to prevent accidental reuse). The Git copy is archived at [`retired-configs/com.quad.bountyboard.cfg`](retired-configs/com.quad.bountyboard.cfg) and removed from active Git `config/`.
6. Restart the P2P host with a **cloned world first**; check BepInEx logs for missing-plugin errors and verify companions, their inventories, jobs, beds, and any nearby constructions. Ask the two friends to join only after shared plugin set matches.
7. Rollback before loading the working world if the test fails: return the DLL and CFG on all peers, restore world and saved contract state if needed.

**Do not skip step 2:** removing `BountyBoard.dll` while boards remain built is potentially destructive. Do not assume the board state is safe to load without the plugin.

## Raid migration and rollback

The full v3 custom 24-raid YAML `config/StarLevelSystem/RaidSettings.yaml` is intentionally **unchanged**. It is inert for SLS raid behavior with `UseVanillaRaidConfiguration=true`, not deleted. [The previous raid tuning and archive](RAID_WAVE_REBALANCE_2026-10-24_v3.md) are retained only as historical documentation.

1. Back up host SLS CFG and YAML, world and characters. Compare local SLS main CFG to [pre-lean original Git copy](config-backups/MidnightsFX.StarLevelSystem_before_stars_only_2026-10-24.cfg). If different, merge just the **six** INI edits above rather than wholesale overwriting the user's personal values.
2. Apply SLS main CFG **to P2P host**. `UseVanillaRaidConfiguration` is server-authoritative and synced; host choice governs friends. The event frequency will now follow vanilla rules including in-game world raid modifiers; `RaidEventRate=1` remains unchanged.
3. Quit/restart host and inspect `BepInEx/LogOutput.log` for SLS synchronization/parse warnings. The old custom `RaidSettings.yaml` may still be present but must not govern actual raids. Do not alter the world's raid slider unless intended.
4. Test with a cloned world: natural or deliberately triggered **vanilla** event, ambient 0–3★ ordinary mobs, ordinary Major/Minor modifiers, and 0–3★ boss HP/modifiers. Boss appearance involves probability; one boss test is not sufficient proof that modifiers are broken.
5. Verify nemesis-specific attacks no longer occur after state / cooldown refresh; previous spawned enemies may persist until removed naturally or the clone reset.
6. Rollback: stop host, restore original main SLS CFG and any current local overrides, restart. For board mod rollback restore both DLL and original saved world/contract state as necessary.

## New DLL manifest

- Formerly: **47 required Server/Client + 10 optional Only Client = 57 active planned DLL**.
- After retirement of `BountyBoard.dll`: **46 required Server/Client + 10 optional Only Client = 56 planned DLL**, **plus disabled DigDug = 57 accounted**.
- MissingPieces is still selected **FOR TEST** separately. Cartur's Flooring, Sinka, BronzeAgeChest still candidates, not part of this count.
- The exact runtime inventory and loaded DLL versions still require verification on host and both friends.

**Git change control:** one SLS CFG modified in exactly six value lines; one BountyBoard CFG archived byte-identically and removed from active Git config; original SLS CFG snapshot preserved; target DLL manifest updated. Other CFG/YAML, world, and player saves are NOT modified.
