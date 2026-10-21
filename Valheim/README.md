# Valheim — BepInEx configuration baseline

Game: **Valheim 1.0.20** (network version 41), Linux/Steam, BepInEx.

`config/` holds the supplied mod configuration snapshot from `BepInEx/config/`, without game saves or transient per-session data.

## Restore

1. Back up your existing `BepInEx/config/` and game saves.
2. Install the matching game and mod versions separately (not included here).
3. Copy the required files from `Valheim/config/` into `BepInEx/config/` while the game is stopped.
4. Start the game and inspect `BepInEx/LogOutput.log`; validate critical mod functions in a test world.

**Note:** This is a configuration snapshot, not a reproducible mod-version lockfile. Exact DLL versions and runtime compatibility have not been established by this upload.

Excluded runtime state: BuildOrders per-world records, EpicLoot bounty ledger and `configstate.json`, GooderAutoShield's last-equipped state. No savegames, character files, or DLL binaries included.
## Продолжение работы (21 октября 2026)

Перед началом нового чата прочитать [точку входа](CONTINUE_HERE.md) и [YAML-контекст](HANDOFF_2026-10-21.yaml). [Аудит расхождений локальных файлов и Git](LOCAL_SNAPSHOT_AUDIT_2026-10-21.yaml) содержит только безопасные хеши и сравнение — игровые и персональные данные туда не включены.
