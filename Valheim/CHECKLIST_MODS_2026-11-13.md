# VSP Gamer — чек-лист модов и обновления локаций

**Дата постановки:** 2026-11-13, 12:05 (из переписки).  
**Основание:** запрос владельца VSP Gamer и последующее согласование плана.  
**Состояние:** OPEN / работа не завершена. Чек-лист — план и контрольные точки, а не подтверждение выполнения.  
**Объекты:** личный клиент `vsp-pc`, Valheim Dedicated Server (VM 9001) и клиенты друзей; манипуляции с копией мира — **локально на `vsp-pc`**, не на Dedicated Server.

> Сохранена исходная нумерация. **Этапы 6, 8 и 9 не входят в этот чек-лист**: владелец выполняет их самостоятельно в другом чате. Не отмечать их завершёнными по факту создания этого файла.

## 1. Проверить обновления всех модов — PARTIAL RESEARCH, NOT VERIFIED IN RUNTIME

- [ ] Получить актуальные списки реально загруженных DLL и версий из BepInEx на `vsp-pc` и Dedicated Server; отдельно зафиксировать различия с клиентами друзей. Не считать Git CFG доказательством установленной версии.
- [ ] Сверить каждую версию с официальными страницами выпусков, зависимостями, совместимостью Valheim/BepInEx и моделью client-only/server-required.
- [ ] Отметить доступные обновления и риски миграции, сформировать контролируемый порядок rollout и rollback. Никакого массового обновления без предварительного бэкапа мира и конфигов.

**Контекст предыдущей проверки:** по заголовкам CFG в Git — EpicLoot `0.14.13`, StarLevelSystem `1.26.3`, AICompanion `0.25.1`; найденные ранее новые версии требуют повторной проверки на дату фактического обновления.

**Критерий приёмки:** таблица «мод → версия на ПК/сервере → официальный релиз → действие/совместимость», подтверждённые runtime-логи и отсутствие неподтверждённых версий.

### Контрольная точка 2026-11-13 — клиентский runtime (PARTIAL)

**Источник:** вывод `grep -E 'Loading \\[' BepInEx/LogOutput.log` пользователя с `vsp-pc` (2026-11-13 14:19); только загрузка плагинов при последнем запуске, не статус Dedicated Server. Всего **53** строки `Loading [`. 

**Подтверждённые версии клиента:** `EpicLoot 0.14.13`; `AICompanion 0.25.1`; `StarLevelSystem 1.26.3`; `MonsterLabZ 3.0.15`; `GooderAutoShield 1.0.4`; `OreMines 1.2.1`; `RecipeManager 0.12.2`; `Jotunn 2.30.2`; `ExtraSlots 1.2.21`; `AzuCraftyBoxes 1.8.19`; `PartyHud 1.12.0`; `PlantEverything 1.21.4`.

**Официальные релизы на дату проверки (Thunderstore):** `EpicLoot 0.15.6` (<https://thunderstore.io/c/valheim/p/RandyKnapp/EpicLoot/versions/>), `AICompanion 0.25.3` (<https://thunderstore.io/c/valheim/p/Quads_Lab/Quads_Companion/versions/>), `StarLevelSystem 1.32.0` (<https://thunderstore.io/c/valheim/p/MidnightMods/StarLevelSystem/>), `ExtraSlots 1.2.24` (<https://thunderstore.io/c/valheim/p/shudnal/ExtraSlots/versions>). Для `Jotunn`, `MonsterLabZFix`, `GooderAutoShield`, `OreMines`, `PlantEverything` и `PartyHud` установленные версии совпали с опубликованными. Пакет `AzuCraftyBoxes 1.8.19` помечен deprecated (<https://thunderstore.io/c/valheim/p/Azumatt/AzuCraftyBoxes/>).

**Отдельно:** `RecipeManager 0.12.2` загружается (старые пометки PLANNED_NOT_INSTALLED неактуальны). `UpgradeWorld` и `ServerDevcommands` в полученных строках загрузки отсутствуют; это не равнозначно доказательству отсутствия файлов на диске.

**Открыто:** сверка оставшихся модов с релизами; серверные runtime версии; зависимости; решение о порядке обновления. **Установка и изменения: NOT RUN.**

## 2. Автоматический щит — исключить ножи — KNIFE TEST PASSED, REGRESSION PENDING

- [x] Подтвердить, что текущий GooderAutoShield не имеет поддерживаемого исключения по типу оружия (имеющиеся в Git настройки: `InstantEquip`, `AutoUnequip`, `DebugMode`). — подтверждено по CFG в Git и README автора.
- [x] Пользователь перешёл на Shield Auto-Equip и настроил allowlist, не включающий ножи; в клиентском тесте щит с ножом не появился (2026-11-14). Не считать этим доказанной проверку всех видов оружия.
- [ ] Регрессионный тест остальных сценариев: меч/булава, смена предметов, сохранение/снятие щита. Сценарий ножа **PASS** по наблюдению владельца.

**Критерий приёмки:** при использовании ножа щит не появляется автоматически, а с разрешённым оружием работает как согласовано.

### Контрольная точка 2026-11-13 — официальные источники (RESEARCHED, RUNTIME NOT RUN)

- `GooderAutoShield 1.0.4`: официальный README описывает автоподбор щита для любого одноручного оружия и явно указывает несовместимость с `Shield Auto Equip` от Zinal001: <https://thunderstore.io/c/valheim/p/MainStreetGaming/GooderAutoShield/>.
- `Shield Auto Equip` от Zinal001 `1.0.0`: `Detected Weapons` принимает список prefab/item ID через запятую; **пустой список разрешает всё одноручное оружие**. Настройка `Equippable Shields` аналогично ограничивает допустимые щиты. Источник: <https://thunderstore.io/c/valheim/p/Zinal001/Shield_Auto_Equip/>. Пример (не production config): `Detected Weapons = SwordIron, MaceBronze, Club` — ножи не перечислены.
- **Риск:** последний опубликованный пакет Zinal001 датирован 2022 годом; совместимость с текущим Valheim, поведение auto-unequip и взаимодействие с ExtraSlots — **[Unverified]**.
- **Порядок теста:** на `vsp-pc` сохранить текущую GooderAutoShield DLL+CFG, отключить старую DLL без удаления, установить только одну альтернативу, включить белый список, проверить нож/меч/булаву/смену оружия/снятие щита/релогин; если неработоспособно — убрать новую DLL и вернуть исходную. Dedicated Server не изменять.
- **Статус:** документация проверена, скачивание/установка/запуск/тест — **NOT RUN**. Второй и третий чекбоксы этапа №2 остаются открытыми до runtime test.

## 3. AICompanion — RETIRE ACCEPTED / RUNTIME REMOVAL PENDING

**Решение владельца (2026-11-14):** отказаться от AICompanion, очистить его материалы и изучить замену. Исходные симптомы: слабая автономность, задержки интерфейса, частые падения, ранее наблюдавшееся масштабирование со StarLevelSystem. **Не пытаться больше исправлять AICompanion** в рамках этого чек-листа.

- [ ] Создать независимые backup мира и персонажей перед выгрузкой сохранённых NPC.
- [ ] Пока AICompanion ещё загружен на сервере и у игроков: забрать всё из сумок и экипировки/надгробий NPC; каждому владельцу выполнить `Release forever` (двойное подтверждение), штатно сохранить мир. Официальный changelog предупреждает, что удаление DLL до этого может уничтожить NPC вместе с вещами: <https://thunderstore.io/c/valheim/p/Quads_Lab/Quads_Companion/changelog/>.
- [ ] Штатно остановить игры; отключить `AICompanion.dll` на `vsp-pc`, Dedicated Server и клиентах друзей в одной согласованной операции, предварительно сохранив копии.
- [ ] После проверки отсутствия записей `Loading [AICompanion ...]` и работоспособности мира удалить/архивировать только специфические данные: `BepInEx/config/com.quad.aicompanion.cfg`, `com.quad.aicompanion.more.cfg`, `BepInEx/AICompanion/activity*.log`, если существует — `BepInEx/config/translations/com.quad.aicompanion/`; осмотреть старый legacy prefix `com.dhack.aicompanion`. Не трогать `PartyHud`, `Quiver`, `BuildOrders` и общие библиотеки.
- [ ] После подтверждённого удаления из runtime убрать активные конфиги AICompanion из Git. Исторический snapshot `Valheim/Valheim Dedicated Server/config-snapshot-2026-11-04/` сохранить как историческое evidence или явно архивировать, а не выдавать за текущий.
- [ ] Исследовать замену: `VikingsForHire 1.6.7` (<https://thunderstore.io/c/valheim/p/Worobeyko/VikingsForHire/v/1.6.7/>), `HiredHands 0.12.10` (<https://thunderstore.io/c/valheim/p/Spronglehump/HiredHands/v/0.12.10/>), `VillageCompanion 0.18.2` (экспериментально). Первое включение — исключительно на резервной копии мира.

**Критерий приёмки:** нет загруженной AICompanion DLL на всех участниках, личное имущество компаньонов возвращено, сохранение мира корректно загружается, удалены только относящиеся к моду файлы; выбранный новый мод тестируется отдельно.

**Статус:** решение подтверждено, очистка и новая установка — **NOT RUN**.

## 4. StarLevelSystem × AICompanion — SUPERSEDED BY AICompanion RETIREMENT

- [ ] Согласовать версии SLS и AICompanion; проверить заявленные исправления взаимодействия.
- [ ] Проверить, что SLS не присваивает компаньонам звёзды, нестандартные размеры, модификаторы или дополнительные копии NPC.
- [ ] Не менять глобальное масштабирование всех существ как обходное решение для одних компаньонов.
- [ ] Протестировать поведение на клиенте и Dedicated Server после согласованного обновления, сохранив возможность возврата прежних DLL/CFG.

**Критерий приёмки:** внешний вид компаньонов стабилен, чужие существа продолжают масштабироваться в соответствии с согласованным балансом.

**Решение 2026-11-14:** проверки межмодовой совместимости AICompanion с SLS больше нецелесообразны после принятого отказа от AICompanion. Сами настройки SLS не меняются этим решением; пункт №4 закрывается как **SUPERSEDED**, а не выполненный тест.

## 5. MonsterLabZ — регистрация дополнительных локаций — IDS COLLECTED, RUNTIME NOT VERIFIED

- [ ] Проверить загрузку MonsterLabZ на клиенте и Dedicated Server и регистрацию префабов локаций.
- [ ] Проверить ID по установленной версии: `Mystical_Well0`, `Balder_Altar`, `AshHuldraQueen_Altar`, `SpiderCave01`, `AshlandsCave_01`, `AshlandsCave_02`, `ML_ShipWreck02`, `ML_ShipWreck03`.
- [ ] Проверить доступность инструмента Upgrade World и корректность его команд для **фактически установленной версии**, до применения к сохранению.
- [ ] Не приписывать колодец EpicLoot; если какой-либо prefab ID не распознаётся, зафиксировать ошибку и остановить процедуру.

**Критерий приёмки:** нужные prefab ID зарегистрированы и определён безопасный метод добавления недостающих локаций в уже существующий мир.

### Контрольная точка 2026-11-13 19:48 — `locations_count` на локальной карте

- **Источник:** снимок консоли Valheim, предоставленный владельцем. Выполнено `locations_count Mystical_Well0,Balder_Altar,AshHuldraQueen_Altar,SpiderCave01,AshlandsCave_01,AshlandsCave_02,ML_ShipWreck02,ML_ShipWreck03`. **Результат: `Total: 0`**.
- **Интерпретация:** текущий реестр локаций локального мира не содержит совпадающих записей; это не доказывает, что prefab в MonsterLabZ не зарегистрированы. Формат `locations_count [id1,id2,...]` подтверждён официальной документацией Upgrade World: <https://github.com/JereKuusela/valheim-upgrade_world>.
- **Следующее действие:** подготовить `locations_add SpiderCave01,AshlandsCave_01,AshlandsCave_02,AshHuldraQueen_Altar,Balder_Altar,ML_ShipWreck02,ML_ShipWreck03,Mystical_Well0` в локальной игре, получить preview / сообщения об ошибках. Список локаций приведён в инструкции обновления модпака: <https://old.thunderstore.io/c/valheim/p/Jumpperi/Jumpperi_Curated_Modpack/changelog/>.
- Конфигурация пользователя ранее: `Automatic start=false`; после подготовки **не выполнять `start`**, пока не проверены preview, версия DLL, резервная копия мира (`.db`, `.fwl`) и защита построек. **Изменения мира: NOT RUN.**

## 7. Локальное обновление локаций через Upgrade World — NOT RUN

- [ ] Получить подтверждение, что рабочая копия мира и резервная копия готовы на `vsp-pc` (подготовка/передача файла выполняется владельцем вне этого чек-листа).
- [ ] В локальном мире с совместимыми MonsterLabZ + Upgrade World подготовить **адресную операцию** добавления отсутствующих локаций, аналогично процедуре OreMines; не выполнять полный `world_reset`.
- [ ] Проверить предварительный результат операции, список локаций, ограничения размещения и защиту построек; при неизвестных ID или сомнениях **не выполнять** `start`.
- [ ] Только после подтверждённого бэкапа и корректного preview применить операцию через `start`; записать результат и возможные ошибки.

**Критерий приёмки:** операция Upgrade World выполнена над локальной копией без ошибок; её результат пригоден для дальнейшей игровой проверки владельцем. Возврат мира на сервер **вне объёма** этого чек-листа.

### Контрольная точка 2026-11-13 17:20 — `vsp-pc` (файлы пользователя, read-only)

**Evidence:** пользователь предоставил `ls -laR` каталога `/mnt/steam/SteamLibrary/steamapps/common/Valheim/BepInEx` и ZIP из 172 записей с CFG/данными (локальная проверка архивов без исполнения). Пользователь сообщил, что мир перенесён на `vsp-pc` и локальная игра запущена. **Файлы мира, наличие независимого backup и фактический BepInEx Loading-log после 17:08 не проверены.**

- В `plugins/003-Admin/` по дереву присутствуют `UpgradeWorld.dll`, `ServerDevcommands.dll`, `WorldEditCommands.dll`. Сгенерированные конфиги сообщают версии Upgrade World `1.87`, Server Devcommands `1.116`; `Automatic start=false`, `Safe zones=2`, `Disable automatic genloc=false`. Регистрация команд **[Needs confirmation]** по live F5.
- `plugins/002-CGM/` содержит AICompanion, EpicLoot, MonsterLabZ, StarLevelSystem DLL. Заголовки текущих CFG: `AICompanion 0.25.1`, `EpicLoot 0.14.13`, `MonsterLabZ 3.0.15`, `StarLevelSystem 1.26.3`; `ExtraSlots 1.2.21`. Заголовки CFG **не доказывают** версии DLL после возможной замены.
- Для этапа №2: `tech.zinals.valheim.shieldautoequip.dll` указан в `999-Client`; `GooderAutoShield.dll` в дереве не указан, хотя прежние CFG/JSON остались. `Detected Weapons =` **пусто**, то есть ножи не исключены. Игровой тест — **NOT RUN**.
- Текущий локальный `com.quad.aicompanion.more.cfg`: `FightRange=50` (ранее в Git 5), `BaseHealth=25`, `BaseStamina=75`, `RespawnSeconds=30`. Серверные значения не подтверждены.
- ZIP содержит **чувствительные файлы** (`AutoServerPassword/passwords.json` и сохранённые данные игроков). **Не коммитить архив и не переносить его содержимое в Git целиком.** Зафиксированы только безопасные сведения выше.
- **Следующий read-only checkpoint:** в локальном мире `F5` → `locations_count Mystical_Well0,Balder_Altar,AshHuldraQueen_Altar,SpiderCave01,AshlandsCave_01,AshlandsCave_02,ML_ShipWreck02,ML_ShipWreck03`. Затем `locations_list` для нужных ID. `locations_add` и `start` **NOT RUN** до подтверждения резервной копии и анализа результата. Источник синтаксиса: <https://github.com/JereKuusela/valheim-upgrade_world>.

### Контрольная точка 2026-11-13 19:48+ — Upgrade World применён локально

**Источник:** скриншот внутриигровой консоли `vsp-pc`, предоставленный владельцем. В отличие от предыдущего контрольного пункта, здесь пользователь **выполнил `start`**, изменение локальной копии мира подтверждено выводом Upgrade World; сохранение на диск и независимый backup после применения **[Needs confirmation]**.

- Выполнено `locations_add SpiderCave01,AshlandsCave_01,AshlandsCave_02,AshHuldraQueen_Altar,Balder_Altar,ML_ShipWreck02,ML_ShipWreck03,Mystical_Well0` → затем `start`.
- Preview: `Spawn missing locations to zones. Player base detection (3x3 safe zones). 6435 zones: 428 skipped by having a player base.`
- Вывод: `Failed to place all AshlandsCave_01, placed 1 out of 7.` и `Failed to place all AshlandsCave_02, placed 2 out of 7.`
- Итоговые строки: `69 locations ... added to the world (total amount in the world: 27)`; `Spawn missing locations: 100%`; `Spawn missing locations completed. 2 locations spawned to already generated areas.`
- **Интерпретация:** операция закончилась; цифры 69 и 27 имеют разную/неясную семантику и не могут использоваться как проверенный фактический подсчёт размещённых объектов. Для этого нужен **post-operation `locations_count`** и при необходимости `locations_list`. Физическое наличие объектов, сохранение на диск, базы и посещаемость — **[Needs confirmation]**.
- **Ограничения:** не повторять `start`, `locations_add`, `genloc` и `world_reset` без отдельной причины и согласования. Операция выполнялась только над локальной копией мира, серверный мир **не изменялся в рамках данного этапа**.
- Документация автора: <https://github.com/JereKuusela/valheim-upgrade_world>. После проверки списка объектов — корректно сохранить, закрыть локальную игру и сделать независимую копию нового состояния, сохраняя исходный rollback.

### Контрольная точка 2026-11-13 21:11 — SLS/EpicLoot: анализ баланса (READ-ONLY)

**Источник состояния:** предоставленный владельцем ZIP конфигураций от 2026-11-13 17:19; после этого владелец сообщил, что моды обновлены и карта играбельна. **Версии DLL после обновления и фактически действующие CFG/YAML на Dedicated Server [Needs confirmation].** Сообщение о чрезмерном входящем уроне — наблюдение игроков, не количественный тест.

- `MidnightsFX.StarLevelSystem.cfg`: `EnemyDamageLevelMultiplier=0.1` (+10% урона/уровень), `EnemyHealthMultiplier=1` (+100% HP/уровень), `BossEnemyDamageMultiplier=0.5` (+50% урона/уровень), `BossEnemyHealthMultiplier=1.5` (+150% HP/уровень); `EnableMultiplayerEnemyDamageScaling=false`, `EnableNemesisSystem=true`, `MaxLevel=3`, `MaxBossLevel=3`, `ShowQuickConfigureButton=false`.
- `StarLevelSystem/LevelSettings.yaml`: `EnableConditionalCreatureLevelupChance=true`; таблицы после `defeated_eikthyr` разрешают для Meadows генератор `MinLevel=2, MaxLevel=8`; после `defeated_fader` — `MinLevel=8, MaxLevel=36`. Встроенные комментарии YAML: активный условный tier переопределяет диапазон биома. Это **риск экстремальной прогрессии**, а не подтверждение текущего достигнутого этапа в мире. Требуется проверить global boss keys/уровни в игре.
- `StarLevelSystem/Modifiers.yaml` содержит боевые аффиксы `Brutal`, `ElementalChaos`, `Fire`, `Poison`, а также `FireNova`, `PoisonNova`. По документации внутри YAML непустые пулы заменяют дефолтные, то есть новые модификаторы SLS 1.28 не включаются автоматически в сохранённый список.
- **World Combat:** в более раннем проектном обсуждении у владельца был выбран `Very Hard`; активное состояние мира **[Needs confirmation]**. Значение Very Hard = игрок получает 200% урона, наносит 70% и встречает больше звёздных врагов; SLS 1.25+ учитывает Combat modifier для звёзд и части эффектов. Источники: <https://valheim.weirdgloop.org/w/World_Modifiers>, <https://thunderstore.io/c/valheim/p/MidnightMods/StarLevelSystem/changelog>.
- **Безопасный предложенный тест, не выполнен:** сначала проверить реальный Combat modifier; если `Very Hard`, рассмотреть `Hard` (150% входящего урона) с backup и обратимым изменением **одного** параметра; затем оценить обычных мобов и боссов. Не переписывать YAML массово.
- `randyknapp.mods.epicloot.cfg`: `Balance Template=legendary`, `Global Drop Rate Modifier=0.3`, `Item Drop Limits=BossKillUnlocksNextBiomeItems`, `Adventure Mode Enabled=true`, `Defer Chest Loot Roll=true`. В `EpicLoot/patches/vsp-gamer/loottables.json` пять патчей для Tier0,1,2,3,6 Tools с `Weight=0.1`. Совместимость этих JSONPath с новой схемой 0.15.x **[Needs confirmation]**.
- **Новые возможности релизов:** SLS 1.32 — Simple/Advanced Quick Configure, Regions scaling, расширенная условная прогрессия, генераторы боссов; EpicLoot 0.15 — Quick Configure, новая система комплектов и таблиц добычи. Сохраняющиеся старые CFG и baseconfig не следует удалять/генерировать без diff и backup. Источники: <https://thunderstore.io/c/valheim/p/MidnightMods/StarLevelSystem/changelog>, <https://thunderstore.io/c/valheim/p/RandyKnapp/EpicLoot/changelog>.
- **Статус:** анализ и рекомендации; изменение gameplay CFG/YAML/мира **NOT RUN**; решение за владельцем.

## 10. Актуализировать Git — NOT RUN

- [ ] Обновить подтверждённый манифест версий/распределение модов по client/server, не смешивая runtime `vsp-pc` и Dedicated Server.
- [ ] Сохранить только проверенные новые CFG и решения по GooderAutoShield, AICompanion, SLS, MonsterLabZ.
- [ ] Приложить evidence результатов игрового тестирования и операции Upgrade World, если они действительно выполнены; отметить всё непроверенное.
- [ ] Проверить diff и исключить секреты, персональные сохранения и бинарные файлы мира; записать commit/PR и итоговый статус.

**Критерий приёмки:** Git отражает подтверждённое состояние и выполненные изменения; сведения можно воспроизвести и проверить независимо.

---

**Правила выполнения:** сначала read-only preflight → backup → одно контролируемое изменение → проверка → rollback при сбое. Пункты не считать выполненными только из-за обсуждения или наличия коммита с этим чек-листом. Никаких изменений сервера, локального мира, DLL или конфигов данный файл не выполняет.
