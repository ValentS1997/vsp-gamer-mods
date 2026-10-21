# Valheim 1.0.20 — staged configuration update

Git snapshot of 12 modified .cfg files plus one EpicLoot JSON patch. No DLLs, saves, live-session data, or world state included.

## Installation
1. Shut down Valheim and the server (if any). Back up the entire current BepInEx/config folder, world and character.
2. Extract `BepInEx/config/` from this ZIP into the **Valheim game directory**, allowing these 13 files to be copied to their matching locations. Do not delete unrelated configs.
3. Ensure synced changes also reach the server when using a dedicated server; server settings may override client values.
4. Launch, inspect BepInEx/LogOutput.log, and test features on a copy of the world before production play.

## Included changes
- ExtraSlots: disabled weight-reduced rows, Food 1-3 switched to Alt+4/5/6. Visual quiver unchanged.
- F8 reserved for Forsaken powers; PlantEasily's global on/off key disabled, planting snapping remains F10.
- F9 reserved for BuildOrders ghost toggle; Forsaken reset key disabled.
- F10 BuildOrders stability shortcut disabled; AutomaticFuel global toggle disabled, station toggle B remains.
- Delete reserved for BuildOrders plan removal; QuickStack trash key disabled, trash UI remains available.
- BuildOrders planning moved to F7; DigDug menu to LeftAlt.
- BetterTames: global protection disabled, 180-second recovery for manually protected pets. Naming alone does not confer protection. No outgoing-damage penalty implemented (not available in this cfg).
- BossGate: portal restrictions based on boss kills enabled. StationsCustomRanges enabled with existing distances. Custom Raids untouched.
- Spearfishing: bow, harpoon, crossbow enabled; spear still disabled.
- EpicLoot: legendary template kept, boss opens next-biome items, drop-rate tuned (global 0.3; item ratio 0.4; material ratio 0.35; sets 0.02), rune removal breaks rune.
- EpicLoot patch: tool category selection weights reduced to 0.1 for Tier 0,1,2,3,6; OdinRealmFishing fishing gear remains. Patch engine rebuild must be verified in LogOutput.log.

## Limitations / verification
- All checks are static. Valheim 1.0.20 runtime has not been tested.
- LeftAlt can still interact with inventory modifiers, and pressing Alt while holding a pickaxe may open DigDug; test.
- EpicLoot JSON patch paths select 5 item-set entries verified against this baseline. If an older EpicLoot release retains unchanged baseconfig, confirm that the patch is actually applied; DO NOT blindly enable `Always Refresh Core Configs`, which can discard local customizations.
- Neither automatic protection by name nor damage reduction for protected pets is provided by BetterTames 0.9.0; use the manual protection key.
- BossGate's server-synced config must match, and settings may be overridden by server.

## Rollback
Restore the original files from the baseline Git commit (before this change) or your BepInEx/config backup. Delete only the new EpicLoot/patches/vsp-gamer/loottables.json patch if rolling back.
