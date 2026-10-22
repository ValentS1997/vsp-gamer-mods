# VSP Gamer — аудит локального архива конфигураций (22.10.2026)

**Источник:** предоставленный пользователем `Архив.zip` из его `BepInEx/config`; SHA-256 архива `1d84e96b4a10204cb0dacd6fc7dedf3d00d46414e5625627bec12cd79765ea1e`. Состав: **135 ZIP-записей, включая 11 папок; 124 файла** (51 CFG, 54 JSON, 12 YAML, 3 YML, 2 TXT, 2 DAT). 57 файлов в корне, 67 — во вложенных папках.

**Статус:** зафиксирован локальный снимок. Присутствие созданного `.cfg` подтверждает, что настройки мода были сгенерированы, но **не доказывает**, что нужная DLL установлена и корректно работает сейчас или у друзей. Сам архив DLL и игровые логи не содержит. Никакой мир, персонаж или настройки игры на `vsp-pc` из Git не менялись.

## Синхронизированные конфиги

Четыре **новых** файла перенесены из архива в `Valheim/config/` и **проверены по Git blob SHA-1 — точное побайтовое соответствие**:

| Путь в `Valheim/config/` | Git blob SHA-1 (равен SHA-1 blob из ZIP) |
|---|---|
| [com.quad.aicompanion.cfg](config/com.quad.aicompanion.cfg) | `dbd3a53fe74b119c14c520b7fadc07c5bda7971c` |
| [com.quad.aicompanion.more.cfg](config/com.quad.aicompanion.more.cfg) | `df69ab9c38c3d6630a481308fa2d8a3916e01f63` |
| [com.quad.bountyboard.cfg](config/com.quad.bountyboard.cfg) | `940f500610a49f3d2441bac6eb5f366517444b01` |
| [com.quad.partyhud.cfg](config/com.quad.partyhud.cfg) | `e336a9da71aee3f3862543aea0501a19a0422c49` |

Дополнительно приведены к **точному побайтовому состоянию ZIP**: `MidnightsFX.AchievementEnabler.cfg`, `MidnightsFX.StarLevelSystem.cfg`, `TastyChickenLegs.AutomaticFuel.cfg`, `advize.PlantEasily.cfg`, `com.quad.buildorders.cfg`, `com.quad.quiver.cfg`, `goldenrevolver.quick_stack_store.cfg`. Из важных прежних расхождений устранены три переключателя AchievementEnabler, автопереключение StarLevelSystem (FirstTimeSetup), мост Build Orders, отключённые горячие клавиши и возврат стрел 75% из существ.

`com.Fire.FiresGhettoNetworkMod.cfg`: синхронизированы значения серверной симуляции / экспериментального ZDO transfer; содержимое файла **не побайтово идентично** ZIP (несущественные комментарии или форматирование требуется отдельно сверить). **Актуальные настройки:** `Enable Server-Side Simulation = true`, broad `Enable Server ZDO Ownership Transfer (EXPERIMENTAL) = false`, selective `Enable Server ZDO Ownership Transfer — Selective (EXPERIMENTAL) = true`. Selective — включён.

## Настройки Quads по локальному ZIP (не гипотезы)

| Мод | Версия в заголовке | Значения |
|---|---|---|
| Companion | 0.25.0 | `MaxCompanions=1`, `WhileAway=Mild`, `MenuKey=J`, `CommandKey=H`; `FightRange=12`, `RespawnSeconds=30`, `BaseHealth=25`, `BaseStamina=75`, `EatBelowPercent=10`, `StartingSkill=0` |
| Bounty Board | 1.4.4 | `MostAtOnce=3`, `RewardPercent=100`, `DaysBetweenNewNotices=1`, `NoticesPerBoard=5`, `ShowOnScreen=false`; доска: `Wood:20, LeatherScraps:6, Flint:4` |
| Party HUD (Only Client) | 1.12.0 | `Enabled=true`, `ShowCompanions=true`, `ShowFood=true`, `ShowStatusEffects=true`, `ToggleKey=F8`, `ShareMyStats=true`, `AllowSharing=true` |

**Два нерешённых конфликта клавиш:** Companion `CommandKey=H` против HipLantern `H`; Party HUD `ToggleKey=F8` против активации силы Отрёкшихся `F8`. Ни одно значение не менялось без согласования; обязательно проверить перед прохождением с друзьями.

**Татьяна:** желаемая девушка-компаньон; архив не подтверждает создание NPC, его внешний вид и имя. `CompanionExp=1` относится только к интеграции с EpicMMO (не включён в утверждённый манифест).

## Дополнительные подтверждения

- **AchievementEnabler v0.5.1:** `VanillaOnlyRequirements=true`, `ShowAllRequirements=true`, `ShowSecretAchievements=true`, `BackfillAchievementStats=true`, `KeepBestStats=true`.
- **StarLevelSystem v1.26.3:** `RaidSettings.yaml` **побайтово совпадает** с Git, присутствует ранее протестированный `pre_eikthyr_pack`. Рейды не переписывались. В главном CFG: `ShowQuickConfigureButton=false`, `FirstTimeSetup=Never`, `LimitCreatureModifierPrefixes=0`.
- **MonsterLabZ v3.0.15**, **OreMines v1.2.1** и **SolidHitboxes v1.0.8**: главные CFG побайтово совпадали с Git до этого обновления. SolidHitboxes `EnableFriendlyFire=false`.
- **AutomaticFuel v1.5.7:** `Mod ToggleKey=None` — прежнее намерение подтверждено. **PlantEasily v2.3.0:** `EnableModKey=None`, `EnableSnappingKey=F10`.
- **Quads Quiver v0.2.4:** `ChanceOnGround=1`, `ChanceOnCreature=0.75`. Ранее в документации было 0.5.
- **Quads Build Orders v1.14.7:** мост `Width=4`, `Material=CoreWood`, `Ends=Steps`; теперь Git соответствует локальному.
- **HipLantern v1.1.14:** локальный CFG предоставлен, основные опции (`ExtraSlots`, `Scale=0.5`, `H`) совпадают с Git; **полное текстовое/побайтовое совпадение не установлено** — в Git всё ещё восстановленный ранее вариант.
- **BlindCartographer:** локальный конфиг сообщает **v1.0.2**, в подготовленной ранее Git-заготовке указана **v1.0.3**. `ModEnabled`, функция картографического стола и горячая клавиша `Left Alt + Y` совпадают. **Версию DLL подтвердить по логам или файлу DLL**; старого `NoMapCartographyTable.cfg` в архиве нет.
- **KeepCharacterEffects:** отдельного файла конфигурации в ZIP **нет**; это не доказывает отсутствие DLL. Требуется отдельная проверка установленного плагина.
- В архиве всё ещё есть настройки **Upgrade World v1.86** и **Server Devcommands v1.116**, применявшихся для размещения OreMines. Наличие CFG **не доказывает**, что административные DLL по-прежнему установлены; они не включены в обязательную сборку.

## Различия и запрет на слепую перезапись

1. У `EpicLoot/baseconfig` минимум три файла не совпадают с предыдущим Git: `adventuredata.json`, `iteminfo.json`, `loottables.json`. Это потенциально важные пользовательские настройки/автогенерация EpicLoot; не заменять без содержательного сравнения. `EpicLoot/patches/vsp-gamer/loottables.json` совпадает с Git.
2. `shudnal.HipLantern.cfg`, `nightkosh.BlindCartographer.cfg`, `com.Fire.FiresGhettoNetworkMod.cfg` имеют отличающиеся SHA, хотя проверенные игровые значения совпадают с обновлённым Git (кроме версии BlindCartographer в заголовке). Их не перезаписывали вслепую.
3. Языковые JSON `StarLevelSystem/localizations` и `EpicLoot/localizations` не импортированы автоматически. Старые снимки содержали различия в переводах, а слепая синхронизация может испортить пользовательские/модовые переводы.
4. Не публиковать игровой runtime/персональные файлы: `StarLevelSystem/SavedData/*`, `EpicLoot/BountySaves/*`, `BuildOrders/*.txt`, `DHack.BountyBoard.*.txt`, `QuickStackStore_player_*.dat`, локальные JSON GooderAutoShield с пользовательскими именами. Они могут раскрывать сведения о мире и персонажах.
5. `server_devcommands.cfg`, `upgrade_world.cfg`, `com.antigravity.valheim.digdug.cfg` — **не включать в распространяемый обязательный комплект** только из-за их наличия в config. DigDug ранее намеренно отключён.

## Актуальная политика распространения

**План:** 44 Server / Client + 9 Only Client = 53 активные DLL при установке всего выбранного набора, ещё 1 отключённый `DigDug.dll*` вне активного счёта. Сами DLL в этом ZIP **отсутствуют**, поэтому фактическая установленная численность и версии подтверждаются только инвентаризацией `BepInEx/plugins` и логами. Компаньон и доска — обязательны у трёх игроков; Party HUD и KeepCharacterEffects — выборочные клиентские дополнения.

См. [каталог модов](README.md), [политику распространения](DEPLOYMENT_POLICY_2026-10-21.md), [концепт Татьяны](AI_COMPANION_CONCEPT.md) и предыдущий [аудит 21.10](LOCAL_SNAPSHOT_AUDIT_2026-10-21.yaml).
