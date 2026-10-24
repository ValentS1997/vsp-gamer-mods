# VSP Gamer — StarLevelSystem raid wave rebalance v3 (24 October 2026)

> **HISTORICAL / NOT ACTIVE FROM LATEST USER DECISION (24.10.2026):** The [SLS simplified profile](SLS_VANILLA_RAIDS_AND_BOUNTY_RETIREMENT_2026-10-24.md) sets `UseVanillaRaidConfiguration=true` and returns Valheim vanilla raids. This earlier 24-event v3 YAML wave balance remains preserved for rollback/future opt-in, but **does not govern current planned raid spawns**. Keep this report solely as the historical v3 reference.

**Status:** revised in Git `main`, **NOT confirmed deployed, loaded, or playtested** on P2P host / friends. This version **supersedes the prior blanket 25%-density reduction** but preserves the separately approved foresttrolls correction. No DLL count changes.

**Scope:** 24 raid definitions, 63 spawn entries reviewed. **21 raids modified, 3 preserved** (`pre_eikthyr_pack`, `foresttrolls`, `army_charred_spawners`). Across **51 spawn entries**, **103 scalar lines** changed: 29 `SpawnGroupSize`, 23 `MaxSpawned`, 51 `MaxSpawnTriggers`. Unchanged: all `Activation` rules, global keys, cooldowns, spawn intervals, spawn chances, event `Duration`, AI/factions/levels, boss levels/modifiers, music/environments, `RaidVersion=3`, `RaidCreatureDensity=1`, EpicLoot and MonsterLabZ. There are 63 spawn entries total, but some remain intentionally fixed for unique/boss events.

## Rationale

- Ordinary weak mobs: larger **2–3 creature groups**, limited waves and concurrent caps; few previously one-at-a-time encounters persist.
- Dangerous enemies: **1–2 per wave**; elites, major monsters and Hildir mini-bosses generally **1 per wave** and restricted repetition.
- The resulting attack should feel like waves, not endless stream-spawning. **`MaxSpawnTriggers` limits opportunities to spawn, NOT total event creatures.**
- **`SpawnGroupSize` is a fixed size, not 3–5 random range**. `MaxSpawned` is per spawn entry, not a hard raid-wide cap; fewer than an intended wave can appear if spawning fails or existing enemies count against cap.
- **Raid concurrency:** SLS can start concurrent raids for different players; per-raid limits **do not** ensure that multi-player overlaps cannot exceed a single event's planned counts.
- `RaidCreatureDensity` is a quick-config metadata/slider-derived density marker, not a live runtime multiplier. **Do not move the density slider** after manual changes unless intentionally re-generating numbers.
- This is a **design proposal implemented in Git, not an empirical balance result**. MonsterLabZ enemies and Quads NPCs may compound combat difficulty.

## Full raid matrix

Table columns:
- *Possible initial group total* is the sum of `SpawnGroupSize` across entries, assuming every entry can spawn on its first opportunity; **not a guaranteed simultaneous spawn**.
- *Concurrent entry caps* is the sum of `MaxSpawned` across the event's entries; **not** a world-wide living-creature cap.
- *Theoretical sum of group attempts* is `sum(SpawnGroupSize × MaxSpawnTriggers)`; upper planning figure, **not** a guarantee. Counts exclude natural mobs or other mods.

| Raid | Initial group total | Concurrent entry caps | Potential group-attempt sum | Changed? |
|---|---:|---:|---:|---|
| `pre_eikthyr_pack` | 4 | 4 | 4 | No |
| `army_eikthyr` | 7 | 15 | 17 | Yes |
| `foresttrolls` | 3 | 5 | 15 | No |
| `army_theelder` | 5 | 11 | 13 | Yes |
| `skeletons` | 4 | 8 | 11 | Yes |
| `blobs` | 4 | 8 | 11 | Yes |
| `ghosts` | 3 | 5 | 8 | Yes |
| `surtlings` | 2 | 6 | 6 | Yes |
| `army_bonemass` | 9 | 16 | 17 | Yes |
| `wolves` | 4 | 8 | 11 | Yes |
| `cultists` | 4 | 8 | 11 | Yes |
| `army_moder` | 6 | 10 | 11 | Yes |
| `army_goblin` | 7 | 12 | 15 | Yes |
| `bats` | 3 | 6 | 9 | Yes |
| `gjall_ambush` | 3 | 5 | 5 | Yes |
| `army_seekers` | 5 | 9 | 11 | Yes |
| `army_charred` | 7 | 13 | 17 | Yes |
| `army_charred_spawners` | 1 | 1 | 1 | No |
| `army_elakingar` | 4 | 7 | 9 | Yes |
| `army_jotuns` | 3 | 5 | 8 | Yes |
| `hildir_boss_revenge1` | 5 | 9 | 9 | Yes |
| `hildir_boss_revenge2` | 5 | 7 | 8 | Yes |
| `hildir_boss_revenge3` | 5 | 7 | 8 | Yes |
| `deathlink_surprise` | 5 | 6 | 6 | Yes |

## Complete before → after by spawn entry

Tuple format: `SpawnGroupSize / MaxSpawned / MaxSpawnTriggers`.

### `pre_eikthyr_pack` — intentionally unchanged

- Boar 1/1/1 → 1/1/1
- Neck 1/1/1 → 1/1/1
- Greyling 1/1/1 → 1/1/1
- Greydwarf_Shaman 1/1/1 → 1/1/1

### `army_eikthyr`

- Greyling 1/6/5 → 3/7/3
- Neck 1/3/5 → 2/4/2
- Boar 1/3/5 → 2/4/2

### `foresttrolls` — intentionally unchanged

- Troll 3/5/5 → 3/5/5

### `army_theelder`

- Greydwarf 1/6/5 → 3/7/3
- Greydwarf_Elite 1/2/5 → 1/2/2
- Greydwarf_Shaman 1/1/5 → 1/2/2

### `skeletons`

- Skeleton 1/6/5 → 3/6/3
- Skeleton_Poison 1/2/5 → 1/2/2

### `blobs`

- Blob 1/6/5 → 3/6/3
- BlobElite 1/2/5 → 1/2/2

### `ghosts`

- Ghost 1/3/5 → 2/3/3
- Wraith 1/3/5 → 1/2/2

### `surtlings`

- Surtling 1/11/5 → 2/6/3

### `army_bonemass`

- Skeleton 1/8/5 → 3/6/2
- Blob 1/3/5 → 2/3/2
- Draugr 1/3/5 → 2/4/2
- Draugr_Elite 1/1/5 → 1/1/1
- Draugr_Ranged 1/2/5 → 1/2/2

### `wolves`

- Wolf 1/6/5 → 3/6/3
- Fenring 1/2/5 → 1/2/2

### `cultists`

- Ulv 1/6/5 → 3/6/3
- Fenring_Cultist 1/2/5 → 1/2/2

### `army_moder`

- Hatchling 1/3/5 → 2/4/2
- Wolf 1/3/5 → 3/5/2
- Fenring_Cultist 1/2/5 → 1/1/1

### `army_goblin`

- Goblin 1/4/5 → 3/6/3
- GoblinArcher 1/3/5 → 2/4/2
- GoblinShaman 1/1/5 → 1/1/1
- GoblinBrute 1/1/5 → 1/1/1

### `bats`

- Bat 1/6/5 → 3/6/3

### `gjall_ambush`

- Gjall 1/1/5 → 1/1/1
- Tick 1/4/5 → 2/4/2

### `army_seekers`

- Seeker 1/3/5 → 2/4/3
- SeekerBrute 1/1/5 → 1/1/1
- Tick 1/2/5 → 2/4/2

### `army_charred`

- Charred_Twitcher 1/4/5 → 3/6/3
- Charred_Archer 1/2/5 → 2/4/2
- Charred_Melee 1/1/5 → 2/3/2

### `army_charred_spawners` — intentionally unchanged

- Spawner_CharredStone 1/1/1 → 1/1/1

### `army_elakingar`

- Elaking 1/6/5 → 2/4/3
- ElakingLantern 1/2/5 → 1/2/2
- ElakingMole 1/1/5 → 1/1/1

### `army_jotuns`

- JotunWarrior 1/2/5 → 1/2/2
- Elaking 1/3/5 → 2/3/3

### `hildir_boss_revenge1`

- Skeleton_Hildir 1/1/1 → 1/1/1
- Skeleton 1/4/5 → 3/6/2
- Skeleton_Poison 1/2/5 → 1/2/2

### `hildir_boss_revenge2`

- Fenring_Cultist_Hildir 1/1/1 → 1/1/1
- Ulv 1/4/5 → 3/5/2
- Fenring_Cultist 1/1/5 → 1/1/1

### `hildir_boss_revenge3`

- GoblinBruteBros 1/1/1 → 1/1/1
- Goblin 1/4/5 → 3/5/2
- GoblinShaman 1/1/5 → 1/1/1

### `deathlink_surprise`

- GoblinBruteBros 1/1/1 → 1/1/1
- Fenring_Cultist_Hildir 1/1/1 → 1/1/1
- Skeleton_Hildir 1/1/1 → 1/1/1
- Skeleton_Poison 1/2/5 → 1/2/2
- GoblinShaman 1/1/5 → 1/1/1


## Special findings / protections

1. **`pre_eikthyr_pack` deliberately preserved:** custom event `RaidActiveTillDefeated=true`, four named spawn entries, each `1/1/1`; the older header comment claims a mixed pack of **13**, while the effective YAML has only **four entries / four total attempts**. This is an actual **comment-to-config mismatch**. Do not "restore 13" without another explicit design decision.
2. **`foresttrolls` preserved:** `Troll = 3/5/5`, `SpawnInterval=40`, `Duration=180`. There can theoretically be up to **15** summoned over all five successful attempts, but no more than **5 living from that entry** concurrently; this **does not mean 3–5 randomly selected per wave**. Older objective of 3–5 total per *entire raid* is superseded by user's newer goal of 3–5 **per wave**.
3. **`army_charred_spawners` preserved:** one `Spawner_CharredStone`, single allowed trigger. Spawner may generate additional mobs through its own mechanics outside these raid entry caps.
4. **Hildir boss prefabs preserved:** one per special raid: `Skeleton_Hildir`, `Fenring_Cultist_Hildir`, `GoblinBruteBros` (all `1/1/1`). Any other Hildir/Deathlink boss entries keep original caps.
5. **`gjall_ambush`:** one Gjall per event attempt sequence instead of potentially five; Tick groups increased to 2, limited to two attempts.
6. **`deathlink_surprise`:** first three bosses keep their `SpawnInterval=230`, longer than `Duration=180`; whether they actually spawn within the event depends on initial spawn timing. **Unverified runtime behavior**; no timing changes in this balance pass.
7. **Deep North events** (`army_elakingar`, `army_jotuns`) are especially [Needs playtest]: encounter strength at Valheim 1.0.20 with this stack was not independently confirmed.

## Deployment, validation and rollback

**Do not blindly overwrite the host's current local YAML**: Git is a documented baseline and user has not provided a fresh on-disk SLS YAML after the last test. Older attachments from another chat may not be accessible.

1. Stop the host/game and make offline backups of the complete current `BepInEx/config/StarLevelSystem/RaidSettings.yaml`, the world `.db` + `.fwl` and characters.
2. Compare the local YAML against the previous Git baseline [pre-v3 snapshot](raid-backups/RaidSettings_before_wave_rebalance_2026-10-24.yaml). If local config has any other hand-tuned changes, **merge only the documented 103 field-line edits** into the local file, do not overwrite unrelated state.
3. If no differences except documented changes, deploy the [current Git YAML](config/StarLevelSystem/RaidSettings.yaml) to the P2P host; restart the Valheim session. The main SLS CFG should keep `UseVanillaRaidConfiguration=false`. Raid configuration is server-authoritative and synced to joining clients; do not separately overwrite friends' unrelated local files.
4. Review `BepInEx/LogOutput.log` for YAML parse errors, auto-regeneration/version migration, and missing prefab warnings. **Do not modify `RaidVersion` manually.**
5. Test in a **cloned world** using SLS console command `sls-raid-spawn <raid_name>` with a nearby open spawn area. Suggested cross-tier checks: `foresttrolls`, `army_eikthyr`, `army_theelder`, `skeletons`, `army_bonemass`, `wolves`, `army_goblin`, `army_seekers`, `army_charred`, then special boss raids carefully. Count the **first wave**, **concurrent living peak**, and **total over whole raid** separately.
6. **Rollback:** stop game, restore the backed-up local `RaidSettings.yaml`, restart the host and confirm reload. Git rollback snapshot: [the exact previous YAML](raid-backups/RaidSettings_before_wave_rebalance_2026-10-24.yaml) (blob `dd5a91ce0c6bb21b930ab791f80ea7a5e02a06db`). No other config/world changes are part of this Git revision.

**Acceptance criteria:** file parses and SLS loads; ordinary mobs reliably appear in groups, boss/elite caps remain reasonable, no accidental 20+ heavy mobs overwhelm the base, `foresttrolls` works as previously chosen, no other config files modified, and no loss or corruption of saves. Actual acceptance **[Pending in-game test]**.
