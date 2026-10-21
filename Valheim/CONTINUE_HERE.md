# Valheim vsp-gamer — CONTINUE HERE (2026-10-21)

This public repository contains **configuration baselines, not a deployable server pack, not game saves and not a verified BepInEx plugin lockfile**.

## Current handoff

- [Maximal Russian-language context and decision register](HANDOFF_2026-10-21.yaml)
- [Latest supplied local `config.zip` vs Git audit (safe hashes and diffs only)](LOCAL_SNAPSHOT_AUDIT_2026-10-21.yaml)
- [Valheim baseline README](README.md)

Game: native Linux / Steam, Valheim 1.0.20 (network version 41), BepInEx. Latest observed client plugin list: **48 named DLL entries** on 2026-10-21 at 21:11. Latest `config.zip`: 112 regular files, of which 8 are world/player/runtime data that must not be committed. Of 104 safe files, 61 match the Git baseline and 43 differ (35 StarLevelSystem localizations and 8 further files). **Never overwrite local edits with Git contents or the opposite without reviewing the differences.**

Latest decision: Custom Raids retired; StarLevelSystem installed and auto-configured, further SLS tuning deferred. EpicLoot is legendary with intentionally rare magic; boss-gated metals via BossGate; MonsterLabZ spawn chance reduced 75%, size/cap roughly halved; OreMines reset 30 in-game days, 35% veins; HoeRadius debug off; protected BetterTames pets recover in 180 seconds, butcher-knife exception deliberately left untouched.

## Next task awaiting completion

Verify **every DLL** against current vendor documentation and actual dependency versions, then split into **Server & Client**, **Server Only**, **Client Only**, noting optional server-side config-sync installs. The YAML has a preliminary `deploy_hypothesis` for each DLL, explicitly **not** a verified classification. There is no proven server-only plugin yet. Check the literal-looking `DigDug.dll*` filename; the latest client listing has no `Valheim.CustomRaids.dll`.

Detected local keyboard conflict: AutomaticFuel toggle `F10` versus PlantEasily snap `F10`; Git has AutomaticFuel toggle blank. Need user approval before changing. Other local-only modifications and unverified compatibility are documented in the handoff.

## Evidence and safety policy

The YAML is a precise snapshot **as of 2026-10-21**, grounded in user-provided `ls` and uploaded `config.zip`, plus GitHub `main` from before this documentation commit. It **cannot confirm that each DLL loaded or runs correctly on a dedicated server**. Require BepInEx client/server logs and backup of world/character before installations, removals or terrain changes. No personal JSON, SavedData, player IDs, bounty ledgers or world-state files are included. Do not use the archived Custom Raids configs as active ones. Do not compile the experimental BetterTames butcher workaround: the user declined that change.

## User clarifications (2026-10-21, continuation)

- **AutomaticFuel / PlantEasily F10 collision:** user decided to change `AutomaticFuel` config `[General] / Mod ToggleKey` to `None` themselves. **Decision confirmed; execution and runtime effect NOT yet verified**. Last supplied local snapshot still has `F10`; Git baseline has a blank value. Keep PlantEasily `EnableSnappingKey=F10`. Do not claim the conflict has already been eliminated, and do not silently edit the live config.
- **DigDug.dll***: the trailing literal `*` is an **intentional user-controlled disable-by-rename technique**; the user retains the file instead of removing it. Treat the plugin as **disabled in the reported client state**, not as a malformed filename requiring investigation. Do not revert this rename or remove the file without a new instruction. This is a user report, not BepInEx runtime verification.
- These clarifications supersede the corresponding open questions in `HANDOFF_2026-10-21.yaml` and earlier lines of this document; historical snapshot evidence is preserved unchanged.

## Deployment category policy — user-defined (2026-10-21)

The deployment categories here are defined by the user in terms of **functional necessity**, not simply whether the mod can technically load on a dedicated server:

- **Only Client:** optional secondary mods that an individual player chooses to install on their own PC; the essential Server/Client pack should remain functional **without** these optional client mods. This is the target deployment policy, **not yet runtime-tested** for the entire mod set.
- **Server / Client:** mods required to provide the intended common gameplay and corresponding dependencies, to be installed on both server and client where their documented behavior requires it. Still needs per-version verification.
- **Only Server:** components necessary only on the dedicated server, if any; none confirmed yet.

**User-selected Only Client (exactly 7 DLL names):**

```text
Advize_PlantEasily.dll
BetterPickupNotifications.dll
BuildOrders.dll
CarturCompassAndClock.dll
ConfigurationManager.dll
FirstPersonMode.dll
GooderAutoShield.dll
```

**Explicitly excluded from both build manifests:** `DigDug.dll*`. User keeps its disabled renamed file for personal retention, but it is **not used in server or client builds**. Also keep already-retired Custom Raids out.

**Inventory accounting:** the latest observed client listing contains 48 DLL filename entries = 7 explicitly designated optional Only Client + 1 excluded DigDug + **40 not yet assigned by this new policy**. Do **not** infer that the remaining 40 are all mandatory Server / Client or move them from the user's PC. Verify actual runtime dependencies and classify them in the next audit.

This policy supersedes the earlier assistant-proposed 24/24 split. No live config, DLL or world data has been changed by this documentation entry.
