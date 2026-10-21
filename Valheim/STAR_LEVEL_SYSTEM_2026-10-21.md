# StarLevelSystem configuration snapshot — 2026-10-21

Source: user-supplied `StarLevelSystem.zip` after first-time automatic setup.
Target on disk: `BepInEx/config/` (repository paths are `Valheim/config/`).

Included unchanged:
- `config/MidnightsFX.StarLevelSystem.cfg` — generated global BepInEx settings.
- `config/StarLevelSystem/*.yaml` — 7 YAML subsystem settings.
- `config/StarLevelSystem/localizations/*.json` — 35 supplied localization files.

Deliberately excluded:
- `StarLevelSystem/SavedData/ServerRaidSavedData.*.yaml`, which contains world/player identifiers and session raid state. Do **not** publish or copy this runtime file back over live server state.

IMPORTANT: These are the mod's first-time **auto-configured** values, with no additional balance changes applied in this commit.
Existing Custom Raids configurations are archived separately under `Valheim/Нашли лучшего кандидата/Custom Raids/`.
Review and back up the active BepInEx config before copying these files into a running server; stop the game first.
