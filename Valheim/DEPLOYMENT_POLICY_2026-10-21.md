# Valheim — deployment policy, user-approved (2026-10-21)

**Status: APPROVED deployment INTENT; NOT verified runtime compatibility or a version-locked release.**

This document supersedes provisional role splits in `DEPLOYMENT_AUDIT_2026-10-21.md` and the earlier suggested 24/24 grouping. User directive: **all modules from the observed 48-entry inventory are mandatory on both dedicated server and every participating client, except exactly the seven explicitly optional client mods below and the previously excluded DigDug**. No server-only mods are selected.

## Server / Client — REQUIRED (40)

These are **required by project modpack policy**, even for plugins that their authors permit to run only client-side or whose server-side effect may be null. The list is not proof that every binary loads on a headless dedicated server. Version, Linux/Mono compatibility, transitive dependencies, and runtime verification remain unresolved.

```text
AchievementEnabler.dll
AutomaticFuel.dll
AzuCraftyBoxes.dll
Basements.dll
BetterTames.dll
BiggerPickupRadius.dll
BossGate.dll
BuyableExtractors.dll
ConditionalConfigSync.dll
ConditionalConfigSync.Plugin.dll
Digitalroot.Valheim.ChainManager.dll
EpicLoot.dll
ExtraSlots.dll
ForsakenPowersPlusRemastered.dll
FrizzQOL.AreaRepair.dll
HoeRadius.dll
InstantlyDestroyBoatsAndCarts.dll
Jotunn.dll
LzD_StationsCustomRanges.dll
MonsterLabZ.dll
NewtonsoftJsonDetector.dll
Newtonsoft.Json.dll
NoFoodDegradation.dll
NoMapCartographyTable.dll
OdinCampsite.dll
OdinRealmFishingMod.dll
OreMines.dll
ProjectileTweaks.dll
QuickStackStore.dll
Quiver.dll
SmartRepair.dll
SolidHitboxes.dll
Spearfishing.dll
StakeTweaks.dll
StarLevelSystem.dll
TopMining.dll
VentureValheim.NoSeasonalRestrictions.dll
XPortal.dll
YamlDotNetDetector.dll
YamlDotNet.dll
```

## Only Client — OPTIONAL (7)

Install these only on individual player machines, at player discretion. The server and essential game mechanics must work without them.

```text
Advize_PlantEasily.dll
BetterPickupNotifications.dll
BuildOrders.dll
CarturCompassAndClock.dll
ConfigurationManager.dll
FirstPersonMode.dll
GooderAutoShield.dll
```

## Only Server — REQUIRED (0)

None selected.

## EXCLUDED — DO NOT DEPLOY (1)

```text
DigDug.dll*
```

The user's trailing `*` is an intentional disable-by-renaming technique. Preserve the renamed local file if wanted, but do **not** include it in either pack. Already retired Custom Raids also remains excluded (not counted among the 48 listed entries).

## Reconciliation and operational conditions

- Inventory source: handoff client `BepInEx/plugins` listing at **2026-10-21 21:11 local**, 48 filename entries. Arithmetic: **40 required both + 7 optional client + 1 excluded = 48**.
- `AutomaticFuel [General] / Mod ToggleKey = None`: approved user action, **local change not yet verified**. `PlantEasily F10` unchanged.
- **This is a normative distribution decision, not a statement that vendor docs mandate server installation.** Some 40 binaries are libraries, optional sync plugins, UI helpers, client-oriented gameplay tweaks, or possible patchers; determine exact working server package separately. If a DLL is confirmed client-only and fails server initialization, flag a deployment exception for approval rather than covertly deleting it from the common manifest.
- No game modifications performed. Do not copy or rename active DLLs yet. Collect exact GUIDs, installed mod versions, SHA-256 hashes, server/client BepInEx logs, and non-DLL assets (e.g., patchers and audio) before publishing a production deployment package. Test on disposable world backed up from production; accept only after client joins and gameplay checks succeed. 
- `DEPLOYMENT_AUDIT_2026-10-21.md` is the technical evidence and historical hypotheses; **this document is the binding user-defined modpack policy**.
