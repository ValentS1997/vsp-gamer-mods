# VSP Gamer — упрощённый PlantEasily для друзей и исключение BossGate (24.10.2026)

## 1. Новое решение пользователя

- **Два друга:** использовать тот же **Advize PlantEasily v2.3.0**, что у хоста, но в собственной облегчённой конфигурации **только массовый сбор на обычную клавишу E**, без Shift, посадки по сетке, привязок, автоматической пересадки и лишнего UI. **Не использовать MassFarming** в качестве замены и не устанавливать оба мода вместе.
- **Хост:** исходный [полный CFG PlantEasily](config/advize.PlantEasily.cfg) **не менялся**; оставлены привычные функции посадки и радиус сбора.
- **BossGate v1.1.2:** исключить из активного комплекта для **P2P-хоста и обоих друзей**. Причина: группа самостоятельно получила **Molten Core** в Ashlands и может строить ванильные **каменные порталы**, которые пропускают металлы. Отдельный boss-kill-gating предметов через порталы больше не нужен. **XPortal сохраняется**.
- **EpicLoot:** ограничения выпадения по прогрессии боссов оставлены; оно **не является BossGate**. Зачарование FreeBuild по ранее согласованной версии патча v2 остаётся **Unlimited**; это другая настройка.
- **HoeRadius:** отдельный нерешённый баг — визуально увеличенный круг при действии лишь в стандартной зоне. В рамках данного изменения мод не заменялся, его CFG не менялся.

## 2. Только сбор по E — профиль для друзей

Файл: [`client-presets/friends/advize.PlantEasily.cfg`](client-presets/friends/advize.PlantEasily.cfg). **Скопировать в `BepInEx/config/advize.PlantEasily.cfg` только на компьютерах двух друзей**. На хосте не применять.

Основные значения:

```ini
[Controls]
KeyboardHarvestModifierKey = E
EnableModKey = None
EnableSnappingKey = None
ToggleAutoReplantKey = None
IncreaseXKey = None
IncreaseYKey = None
DecreaseXKey = None
DecreaseYKey = None
KeyboardModifierKey = None
GamepadModifierKey = None

[General]
ModActive = true
SnapActive = false
Rows = 1
Columns = 1
RandomizeRotation = false
EnableScatter = false

[Harvesting]
EnableBulkHarvest = true
HarvestStyle = AllResources
HarvestRadius = 3
ReplantOnHarvest = false
```

Дополнительно отключены нестандартные проверки и визуализация посадки, дополнительные подсказки, debug; в `Performance` минимум нажатий/объектов. `UseStamina=true` и `UseDurability=true` оставлены ванильными; без массовой посадки они не должны добавлять повторные действия.

**Проверка исходников:** в `Advize_PlantEasily/Patches/InteractPatches.cs` массовый сбор выполняется при `Player.Interact`, если `ZInput.GetKey(config.KeyboardHarvestModifierKey, false)` истинно или `alt`; установка `KeyboardHarvestModifierKey=E` рассчитана на одну обычную клавишу взаимодействия **E**. `ModActive` **не выключать**, иначе отключится и сбор. `Rows=1`, `Columns=1` не создают дополнительных объектов при посадке; `SnapActive=false` отключает привязку. Это **специальный клиентский профиль, игровое тестирование не выполнено**.

- Проверка: взрослые растения разных видов рядом; навести на одно и нажать E **один раз**. Ожидается массовый сбор всех разрешённых ресурсов в радиусе 3 м; обычная посадка — один объект за раз.
- В версии PlantEasily 2.3.0 есть интеграция с ConditionalConfigSync, которая может синхронизировать значения. Автор указывает, что почти все клиентские параметры остаются локальными; исключение — `UseDurability` и `UseStamina`. При фактическом несовпадении параметров проверить правила CCS на хосте.
- **Не устанавливать вместе** с `MassFarming.dll` (официально указанная автором несовместимость). Ветка подготовки MassFarming для друзей ранее была **кандидатом, заменена этим решением**, не была добавлена к активному каталогу.
- Подготовленный ZIP для двух друзей: `Valheim_Friends_PlantEasily_E_only_2026-10-24.zip`, **2586 байт**, SHA-256 `eb47c37eb13c4a3e662daffc8e6906c4ed65cfcb6f24cbfb84e232ee075a5a6e`, содержит полный профиль по пути `BepInEx/config/advize.PlantEasily.cfg`, `README_RU.txt` и `SHA256_MANIFEST.json`. Передан пользователю в беседе. Содержимое CFG соответствует **Git blob `921a1ce5e20c9260cd706162049df34c16c0d36a`**.

## 3. BossGate снят с активного состава

Прежний [`Igao.BossGate.cfg`](retired-configs/Igao.BossGate.cfg), сохранённый в Git **без изменений**, был настроен на:
- `LockAllBosses=false`, у всех боссов `Unlock Day=0`;
- `RequirePreviousBossDefeated=false`, `PerPlayerProgress=false`;
- `PortalItemsRequireBossKill=true`: раньше обычные порталы выпускали металлы по убийствам боссов;
- `KickClientsWithoutMod=true`: если хост с BossGate запущен, клиенты без DLL могут отключаться.

**Git-действие:** исходный `Valheim/config/Igao.BossGate.cfg` перенесён в `Valheim/retired-configs/Igao.BossGate.cfg` с побайтовой проверкой; **из текущего каталога S/C и активного конфигурационного пути удалён**. На игровых компьютерах ничего не удаляли.

**Для реального применения:** одновременно удалить `BossGate.dll` **у хоста и двух друзей**, не запускать старую конфигурацию только у хоста (иначе `KickClientsWithoutMod` отключит клиентов); не восстанавливать CFG в действующей папке. Сначала сделать резервную копию папок BepInEx и мира. После удаления мода обычные деревянные порталы подчиняются ограничениям Valheim/настроек мира; **каменный портал** допускает перевозку металлов, при условии, что **он является порталом отправления**. [Документация BossGate](https://thunderstore.io/c/valheim/p/Igao/BossGate/) и [ванильный Stone Portal](https://valheim.gaming.tools/structures/portal_stone).

**Не удалять XPortal:** он даёт интерфейс управления/выбора порталов и не является модом на босc-гейтинг. Не удалять EpicLoot: его ограничения относятся к выпадению предметов, а не к этому модулю порталов.

## 4. Актуальный состав

**45 обязательных Server/Client + 10 необязательных Only Client = 55 выбранных активных DLL**, плюс один отключённый `DigDug.dll*` (56 учтённых). PlantEasily уже входит в 10 клиентских, дополнительной DLL нет. Последний сохранённый снимок диска 22.10 на 54 DLL **исторический** и включал BossGate; удаление с ПК не подтверждено. [Точный активный манифест](MOD_MANIFEST_2026-10-24.md). До новой проверки логов/установки версии DLL оставлять как сообщённые пользователем.

**Не затрагивать:** `Valheim/config/advize.PlantEasily.cfg` хоста, `Valheim/config/yay.spikehimself.xportal.cfg`, мировые сохранения, NPC Quads, EpicLoot Loot/Item gating, конфиги SLS/MonsterLabZ и ребаланс v2.
