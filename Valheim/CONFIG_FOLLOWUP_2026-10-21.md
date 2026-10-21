# Valheim 1.0.20 — follow-up config changes (2026-10-21)

## Included, ready-to-copy config files

- `BepInEx/config/Azumatt.AzuCraftyBoxes.cfg`:
  `Container Range` 20 -> 50 meters (matches the user's tested local change).
- `BepInEx/config/MonsterLabZ.cfg`: all 35 creature sections:
  `Spawn chance` -> 25% of old value; `Maximum creature count` -> half rounded up;
  `Group size` endpoints -> half rounded up, capped to the new maximum creature count.
  `Spawn = Default` was preserved in every section.
  No drops, health, damage, spawn conditions, encounter settings, or prefab references changed.

IMPORTANT: spawn probability per check and max count are limits, not a guaranteed exact
75% or 50% reduction in actual world population. Counts of one remain one. StarLevelSystem
may further adjust creature spawns; it is NOT configured in this patch.

## BetterTames butcher knife: SOURCE ONLY, NOT INSTALLED

Existing BetterTames v0.9.0 explicitly allows butcher knives to bypass its individual
protection. There is NO .cfg switch for this. The `optional-source` directory contains
source for a standalone Harmony compatibility plugin that intercepts ONLY that bypass.
It is NOT compiled, loaded, or validated against the user's live game build.
Do not treat knife protection as active until the plugin has been compiled and tested.
Build only if using the matching BepInEx version, a .NET SDK, and game files:

```
cd optional-source/BetterTamesNoButcherBypass
dotnet build -c Release -p:ValheimDir=/mnt/steam/SteamLibrary/steamapps/common/Valheim
```

Then install the built DLL separately into BepInEx/plugins on a backed-up test world.
Without this plugin, protected pets can still be killed by butcher knife as before.

## Not changed

- StarLevelSystem configs: postponed; game auto-configured these separately.
- DigDug: temporary trench-building tool, leave DLL as-is until digging ends.
- Custom Raids: its 4 configs were ALREADY archived in Git in commit 5769047.
  Move/remove `BepInEx/plugins/Valheim.CustomRaids.dll` locally if still present.
- BetterTames config: no changed .cfg values; individual protection and 180s stay.
- All other configs from the last baseline stay unchanged.

## Install/restore

Stop Valheim first; back up the existing `BepInEx/config` directory and world.
From the directory containing this archive:

```
unzip -o Valheim_1.0.20_followup_patch_2026-10-21.zip 'BepInEx/config/*' -d /mnt/steam/SteamLibrary/steamapps/common/Valheim/
```

Only the 2 CFG files under `BepInEx/config` are applied by that command.
Restart and inspect `BepInEx/LogOutput.log` and creature populations in a test area.
Backup/restore of the two CFG files is sufficient to revert these config changes.
