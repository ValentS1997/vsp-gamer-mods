# VSP Gamer — личная сборка vsp-pc, 2026-11-03

**Источник:** предоставленные владельцем инвентаризация BepInEx (03.11.2026 16:48) и архив BepInEx/config (147 файлов). Это снимок файловой системы, **не доказательство успешной загрузки DLL**. Изменения в этом документе относятся к личной сборке, **не являются серверным манифестом**.

## Инвентарь

- 55 файлов с расширением `.dll` (потенциально активные), 9 файлов `.dll*` (физически отключены).
- `AutoServerPassword` присутствует как активная DLL, CFG v1.0.2.
- `ProximityVoiceChat.dll*` физически отключён; его сохранённый CFG от v1.0.5 не подтверждает активную загрузку.
- `ComfyGizmo` активен; остальные строительные и административные инструменты сверять с исходным инвентарём.

## Подтверждённые значения в новом локальном ZIP

| Конфиг | Значение |
|---|---|
| StarLevelSystem | `BossEnemyHealthMultiplier=1.5`, `BossEnemyDamageMultiplier=0.5` |
| AICompanion | `MaxCompanions=1`, `FightRange=5`, `ShowDecisions=false` |
| PlantEasily (vsp-pc) | `ModActive=true`, `EnableModKey=KeypadPeriod` |
| BlindCartographer | `ShowHotKeyText=false` |
| AutomaticFuel | `Mod ToggleKey=F10` |
| XPortal | `DefaultPortal={x:387,y:35,z:-51}` |
| Voice Chat | CFG `Allow Global Voice=On`, `Use Voice Activation=On`, `Voice Volume=1`, `Auto Gain Target=0.12`; DLL отключена |

## Политика безопасности

Не переносить в публичный Git файлы `AutoServerPassword/passwords.json`, пользовательские `QuickStackStore_player_*.dat`, записи `StarLevelSystem/SavedData/`, `EpicLoot/BountySaves/`, `BuildOrders/*.txt`, персональные чертежи, `DHack.BountyBoard.*`, `EpicLoot/configstate.json` и локальный `StarLevelSystem/NemesisSettings.yaml` с созданными боссами. Шаблон Git `NemesisSettings.yaml` с пустым `AvailableMiniBosses` сохраняется неизменным.

## Границы синхронизации

В этом обновлении сохранены **выборочные подтверждённые различия**, а не бинарная копия всех 147 файлов. Дополнительные несовпадения по SHA (включая `StarLevelSystem/LevelSettings.yaml`, сетевой CFG `com.Fire.FiresGhettoNetworkMod.cfg`, `randyknapp.mods.epicloot.cfg` и локальный voice CFG) требуют отдельного контентного сравнения перед полной синхронизацией. Не считать их совпадающими с Git.

Игровой мир, установленная конфигурация Dedicated Server и конфиги друзей данным коммитом не меняются.
