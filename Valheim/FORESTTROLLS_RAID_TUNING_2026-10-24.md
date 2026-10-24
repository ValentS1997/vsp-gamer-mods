# VSP Gamer — foresttrolls raid correction, 2026-10-24

## Goal and reported incident

User reported that the SLS raid **«Земля трясётся»** spawned only one Troll. New goal: approximately **3–5 trolls per wave** without reverting to the previous excessive overall raid density.

This is a **source-controlled config change only**, not yet deployed or playtested in the host's current world. The raid in SLS is `foresttrolls`. Existing `RaidSettings.yaml` is authoritative only if the host uses `UseVanillaRaidConfiguration = false` (the Git config does).

## Exact approved narrow edit

File: [RaidSettings.yaml](config/StarLevelSystem/RaidSettings.yaml), section `- Name: foresttrolls`, Troll entry.

| Field | Before | After | Meaning |
|---|---:|---:|---|
| SpawnGroupSize | 1 | **3** | Targeted count per full spawn wave |
| MaxSpawned | 2 | **5** | Concurrent cap of living Troll from this entry |
| SpawnInterval | 40 | 40 | Seconds between spawn attempts, unchanged |
| MaxSpawnTriggers | 5 | 5 | Trigger/attempt cap, unchanged |
| Duration | 180 | 180 | Event duration, unchanged |

The SLS `SpawnGroupSize` property is a **single integer**, not a minimum/maximum range: **this configuration does not randomly spawn 3–5 trolls per wave** and **does not hard-guarantee >=3 actually spawn on every attempt**. Reduced partial waves / failures to find suitable positions are possible when current mobs count against `MaxSpawned`. It also does **not** cap total event spawns at five: repeated waves may produce more as existing Trolls die. `MaxSpawnTriggers=5` limits the number of spawn attempts, not the cumulative total to five.

The initial expected full wave is three, at most five Trolls from this group alive at the same time. **[In-game validation required].**

Unchanged: every other raid, level tables, activation conditions, boss HP, MonsterLabZ and EpicLoot; `RaidVersion: 3` remains untouched (never manually bump to suppress migrations); `GlobalSettings` and `RaidCreatureDensity=1` unchanged.

## Deploy / rollback

1. **Close the game and back up** world `.db/.fwl`, characters, and the host's exact current `BepInEx/config/StarLevelSystem/RaidSettings.yaml`.
2. Compare the local raid `foresttrolls` section to Git before copying: a file on Git does not prove that the host's local YAML matches the previous baseline. Preserve any other local edits. Prefer merging **only** the two field changes if local content differs.
3. On the **P2P host**, replace the validated raid YAML (or merge the two fields). Do not overwrite `SavedData`, `LevelSettings.yaml`, `LootSettings.yaml` or main CFG. Restart the host session. The official mod states raid definitions are server-authoritative and synced to joining clients.
4. Check `BepInEx/LogOutput.log` for SLS YAML parse errors, config resets or migration backups. Use a cloned world for controlled test.
5. If needed, use SLS debug command **`sls-raid-spawn foresttrolls`** (run only in a test world / admin-capable context) to request this raid. Verify first wave, wave interval, max concurrent count, duration and absence of unexpected reversion of other raids.
6. If behavior is bad, stop the host, restore the backed-up `RaidSettings.yaml` and restart.

**Acceptance:** 3 Trolls in a full initial wave; no more than 5 living simultaneously from this specific raid spawn group; no SLS parsing errors; all other raid settings remain unchanged. Any different behavior should be treated as a failed/partial acceptance test, not an automatic guaranteed spawn claim.

Git baseline preceding this narrow change: blob `5ffa3315baea9ff2a740cd48429be07bbf4c6354`.
