# VSP Gamer — актуальный DLL-манифест Valheim (24.10.2026)

**РЕШЕНИЕ 25.10.2026 — GIZMO И ФИЗИЧЕСКИЕ ПАПКИ ПЛАГИНОВ:** пользователь подтвердил успех теста ComfyGizmo при строительстве из стандартных элементов; **`ComfyGizmo.dll` остаётся постоянно доступным в строительном наборе администратора** (`03-Building/`), но не становится обязательным для друзей. **`CarturFlooring.dll` исключён** из постоянного состава: его необходимо переместить за пределы `BepInEx/plugins/` (пользователь сообщил о намерении удалить, фактическое удаление на диске ещё не подтверждено). **Новый план: 44 обязательных Server/Client + 10 Only Client = 54 DLL**, плюс **1 постоянный инструмент строительства у администратора ComfyGizmo = 55 учтённых в выбранных профилях**; остальные временные инструменты/фактические DLL ПК учитывать отдельно. В последнем снимке от 25.10.2026 00:12 представлены **59 DLL** (перед выключением CarturFlooring), а также `ropesnap.wav` и `Translations/`; физическая сортировка в подпапки на ПК не подтверждена. BepInEx DLL не переименовывать; оригинальные файлы-зависимости двигать отдельно и тестировать запуск. Ни CFG, ни DLL на компьютере это изменение Git не трогает.


**КЛАССИФИКАЦИЯ И ПОЛИТИКА МУЛЬТИПЛЕЕРА — ПОДТВЕРЖДЕНО 24.10.2026:** **Quads Quiver (`Quiver.dll`) обязателен на P2P-хосте и у обоих друзей**: это правило нашей сборки для одинаковой возможности возврата стрел/болтов, хотя сам мод допускает клиентскую установку. **Исторический состав до исключения CarturFlooring: 45 обязательных S/C + 10 Only Client = 55 DLL** (отдельно сохранён отключённый `DigDug.dll*`; фактическую установку на трёх ПК ещё сверить). Четыре ключевых игровых мода получают виртуальную категорию **CGM = Core Game Mechanic**: EpicLoot, StarLevelSystem, MonsterLabZ, Quads Companion. **Категории и маркировка хранятся только в манифесте, а не в имени DLL на диске**, чтобы не повторять ошибки поиска библиотек. Последние решения по сборке: MissingPieces не включать (постройки исчезли в пользовательском тесте), Cartur's Flooring — в основном S/C списке под `!!` (`CarturFlooring.dll`), Sinka — для строительного режима вне обязательного состава, ProjectileTweaks и HoeRadius — удалены по сообщению пользователя, DigDug — полезный, но отключённый; локальные названия и содержимое рабочей папки зафиксированы в чате. Последующие правки состава по снимку ПК — отдельная сверка.

**РЕШЕНИЕ О ПАРАМЕТРАХ QUIVER (24.10.2026; КЛАССИФИКАЦИЯ УТОЧНЕНА ВЫШЕ):** стрелы из земли/деревьев и существ с вероятностью **75%**, болты возвращаются (`IncludeBolts=true`), колчан отображается (`Show=true`), огненные стрелы сгорают (`FireArrowsBurnUp=true`). **`ProjectileTweaks.dll` вновь исключён из активного списка** по последнему явному распоряжению пользователя, его оригинальный CFG сохранён в `retired-configs/`. Quads Bounty Board также исключён ранее. **Исторический план до перевода Quiver в обязательные: 44 S/C + 11 Only Client = 55 DLL**, плюс отключённый DigDug = 56 учтённых. Quads Quiver технически допускает клиентскую установку; по последнему решению VSP Gamer обязателен на всех трёх ПК. [Итоговый профиль и откат](ARCHERY_FINAL_QUIVER_ONLY_2026-10-24.md).


**ИСТОРИЧЕСКАЯ ПРАВКА (ОТМЕНЕНА): СТРЕЛЫ 75% / 75%, БОЛТЫ И PROJECTILETWEAKS ВОЗВРАЩЕНЫ (24.10.2026):** Подтверждено пользователем: сохранить колчан и возврат стрел Quads Quiver (`ChanceOnGround=0.75`, `ChanceOnCreature=0.75`, `IncludeBolts=true`, `Show=true`, `FireArrowsBurnUp=true`), а также **вернуть `ProjectileTweaks.dll`** с исходным без изменений CFG для зума и настроек полёта снарядов. Quads Bounty Board остаётся исключённым (пользователь сообщил об удалении). **Тогдашний, уже отменённый целевой состав: 45 обязательных S/C + 11 Only Client = 56 DLL**, плюс выключенный DigDug = 57 учтённых. Quads Quiver остаётся клиентским и желателен на P2P-хосте для синхронизации шанса возврата. [Конфиг и ZIP](ARCHERY_75PERCENT_PROJECTILETWEAKS_2026-10-24.md).


**ИСТОРИЧЕСКИЙ ЭТАП — ТОЛЬКО СТРЕЛЫ И КОЛЧАН (ЗНАЧЕНИЯ ПОЗДНЕЕ ИЗМЕНЕНЫ):** `ProjectileTweaks.dll` исключается из целевого состава: отдельные правки угла/траектории/зум/счётчик боеприпасов не нужны. `Quiver.dll` (Quads Quiver) **оставлен** для возврата стрел (земля 100%, противник 75%) и визуального колчана; восстановление болтов выключено. По документации автора Quads Quiver работает **client-only**: переносим его из обязательных S/C в опциональные клиентские (хосту стоит держать его установленным для единой вероятности возврата в P2P). **Исторический план до возврата ProjectileTweaks: 44 обязательных S/C + 11 Only Client = 55 DLL**, + отключённый DigDug = 56 учтённых. Удаление `ProjectileTweaks.dll` со всех ПК и `BountyBoard.dll` — по инструкции, пока **не подтверждено**. [Инструкция и rollback](ARCHERY_QUIVER_ONLY_2026-10-24.md).


**ПОСЛЕДНЕЕ РЕШЕНИЕ 24.10.2026 — упрощение SLS и отказ от Quads Bounty Board:** SLS использует ванильные рейды; Nemesis и объектное масштабирование отключены, звёзды, модификаторы обычных мобов и боссов сохранены. **`BountyBoard.dll` исключён из целевого списка на всех трёх ПК**, но удалять его только после демонтажа всех игровых досок и бэкапа контрактов/мира. Quads Companion / Party HUD остаются. **Исторический план до упрощения стрельбы: 46 обязательных S/C + 10 Only Client = 56 DLL; актуальный план: 44 S/C + 11 Only Client = 55 DLL, плюс отключённый DigDug = 56 учтённых.** MissingPieces отдельно в тестировании и сюда НЕ входит. [План миграции и настройки](SLS_VANILLA_RAIDS_AND_BOUNTY_RETIREMENT_2026-10-24.md).


**Статус:** согласованный целевой состав после отказа от BossGate; список DLL из README, а не повторная проверка диска. **44 общих (хост и оба друга) + 10 необязательных клиентских = 54 DLL по базовому плану, плюс ComfyGizmo у администратора**; `DigDug.dll*` намеренно выключен (всего 56 учтённых). Реальное удаление DLL у трёх игроков ещё не проверено.

**ОБНОВЛЕНИЕ СТАТУСА 24.10.2026:** пользователь сообщил, что **PlanBuild и ModularLadders установлены** у него; получен [PlanBuild v0.20.0 CFG](config/marcopogo.PlanBuild.cfg). По одним сообщениям/CFG нельзя подтвердить версию фактической DLL, отсутствие ошибок загрузки и наличие у двух друзей. **MissingPieces 2.3.2 выбран отдельно для ТЕСТА**, пока не считается 48-й S/C DLL. **Cartur's Flooring, Sinka, BronzeAgeChest — только кандидаты.** [Подробности](BUILDING_MODS_TEST_2026-10-24.md). Историческая база до отказа от Bounty Board: **47 S/C + 10 C = 57 DLL**; после отказа **46 S/C + 10 C = 56 DLL**.

**ИСТОРИЧЕСКОЕ РАСПОРЯЖЕНИЕ (теперь сообщено об установке) — PlanBuild:** `PlanBuild.dll` **0.20.0** на P2P-хосте и обоих друзьях. BepInExPack и Jötunn уже входят в список; HookGenPatcher не требуется. Схемы домов сохраняются в `.blueprint` и могут включать предметы из сундуков, но воспроизведение предметов только через Direct Build (бесплатная постройка/риск дубликатов). **Сначала бэкап мира, тест на одном сундуке; позднее пользователь прислал CFG, см. ссылку выше.** [Подробная процедура](PLANBUILD_REBUILD_2026-10-24.md).

**ИСТОРИЧЕСКОЕ РАСПОРЯЖЕНИЕ (теперь сообщено об установке):** `ModularLadders.dll` v1.0.0 на P2P-хосте и у двух друзей. Автор требует присутствия у всех из-за дополнительных строительных объектов. BepInEx уже используется; Jötunn не требуется. Лестницы исчезнут при удалении DLL, поэтому не удалять без бэкапа мира. **CFG не создавать.** [Решение](MOD_DECISIONS_2026-10-24.md).

**УДАЛИТЬ при следующей локальной синхронизации:** `BossGate.dll` у хоста и обоих игроков. Конфиг удалён из активной папки Git и сохранён в [архиве](retired-configs/Igao.BossGate.cfg); не копировать его обратно в `BepInEx/config/`. **XPortal.dll остаётся.** Каменные порталы позволяют переносить руду/металлы без BossGate. EpicLoot-гейтинг добычи не изменён.

**ИСКЛЮЧЁН Quads Bounty Board (ранее):** `BountyBoard.dll` (прошлый №35) удалить/перенести в отключённые DLL **только после демонтажа игровых досок**, закрытия или сохранения групповых контрактов и резервной копии мира. [Архив бывшего CFG](retired-configs/com.quad.bountyboard.cfg); не копировать обратно в рабочий `BepInEx/config/`. `AICompanion.dll` и Party HUD оставить. В Git игровой мир не меняется.

**PlantEasily для друзей:** `Advize_PlantEasily.dll` уже входит в 10 Only Client. Не добавлять MassFarming одновременно: вместо этого установить [отдельный профиль](client-presets/friends/advize.PlantEasily.cfg) с `E` и радиусом 3 м; у хоста [основной CFG](config/advize.PlantEasily.cfg) без изменений.

## Server / Client — 44

**Политика маркировки:** `CGM` — Core Game Mechanic, четыре основных игровых мода; `!` — API/библиотека/важный мод, `!!` — строительный мод, `!K-` (только латинская **K**) — клиентский мод, `*.dll*` — намеренно отключённый файл, который хранится у администратора для отдельного режима. Это **учётные обозначения**, не требование переименовывать DLL: библиотеки (`Jotunn.dll`, `YamlDotNet.dll`, `Newtonsoft.Json.dll`, `ConditionalConfigSync*.dll`) должны сохранять штатные имена для совместимости. Обозначения `!` и `!!` здесь описаны как категории и не навязываются спорным модам: `Basements`, `OdinCampsite`, `LzD_StationsCustomRanges`, `FrizzQOL.AreaRepair` оставлены **без дополнительных меток**. Quads Quiver относится к обязательным S/C по политике VSP Gamer, а **не** к `!K-`.

| № | Мод | DLL | Класс |
|---:|---|---|---|
| 1 | AchievementEnabler | `AchievementEnabler.dll` | — |
| 2 | AutomaticFuel | `AutomaticFuel.dll` | — |
| 3 | AzuCraftyBoxes | `AzuCraftyBoxes.dll` | — |
| 4 | Basements | `Basements.dll` | — |
| 5 | BetterTames | `BetterTames.dll` | — |
| 6 | BiggerPickupRadius | `BiggerPickupRadius.dll` | — |
| 7 | BuyableExtractors | `BuyableExtractors.dll` | — |
| 8 | ConditionalConfigSync | `ConditionalConfigSync.dll` | — |
| 9 | ConditionalConfigSync.Plugin | `ConditionalConfigSync.Plugin.dll` | — |
| 10 | Chain Manager | `Digitalroot.Valheim.ChainManager.dll` | — |
| 11 | ChilloutForcedPVP | `ChilloutForcedPVP.dll` | — |
| 12 | DoorDirector | `DoorDirector.dll` | — |
| 13 | EpicLoot | `EpicLoot.dll` | **CGM** |
| 14 | ExtraSlots | `ExtraSlots.dll` | — |
| 15 | FiresGhettoNetworking | `VAGhettoNetworking.dll` | — |
| 16 | ForsakenPowersPlusRemastered | `ForsakenPowersPlusRemastered.dll` | — |
| 17 | Area Repair | `FrizzQOL.AreaRepair.dll` | — |
| 18 | HipLantern | `HipLantern.dll` | — |
| 19 | Instantly Destroy Boats And Carts | `InstantlyDestroyBoatsAndCarts.dll` | — |
| 20 | Jötunn / Valheim Library | `Jotunn.dll` | — |
| 21 | Stations Custom Ranges | `LzD_StationsCustomRanges.dll` | — |
| 22 | ModularLadders | `ModularLadders.dll` | — |
| 23 | MonsterLabZ | `MonsterLabZ.dll` | **CGM** |
| 24 | JsonDotNET — detector | `NewtonsoftJsonDetector.dll` | — |
| 25 | JsonDotNET / Newtonsoft.Json | `Newtonsoft.Json.dll` | — |
| 26 | NoFoodDegradation | `NoFoodDegradation.dll` | — |
| 27 | BlindCartographer | `BlindCartographer.dll` | — |
| 28 | OdinCampsite | `OdinCampsite.dll` | — |
| 29 | OdinRealmFishing | `OdinRealmFishingMod.dll` | — |
| 30 | OreMines | `OreMines.dll` | — |
| 31 | PlanBuild | `PlanBuild.dll` | — |
| 32 | Quick Stack Store | `QuickStackStore.dll` | — |
| 33 | Quads Quiver | `Quiver.dll` | — |
| 34 | Quads Companion | `AICompanion.dll` | **CGM** |
| 35 | SmartRepair | `SmartRepair.dll` | — |
| 36 | SolidHitboxes | `SolidHitboxes.dll` | — |
| 37 | Spearfishing | `Spearfishing.dll` | — |
| 38 | Stake Tweaks | `StakeTweaks.dll` | — |
| 39 | StarLevelSystem | `StarLevelSystem.dll` | **CGM** |
| 40 | TopMining | `TopMining.dll` | — |
| 41 | No Seasonal Restrictions | `VentureValheim.NoSeasonalRestrictions.dll` | — |
| 42 | XPortal | `XPortal.dll` | — |
| 43 | YamlDotNet — detector | `YamlDotNetDetector.dll` | — |
| 44 | YamlDotNet | `YamlDotNet.dll` | — |

## Only Client — 10 (по выбору игроков)

`!K-` в столбце «Класс» — только **маркировка манифеста**; физические имена DLL лучше оставлять исходными.

| № | Мод | DLL | Класс |
|---:|---|---|---|
| 1 | PlantEasily | `Advize_PlantEasily.dll` | !K- |
| 2 | BetterPickupNotifications | `BetterPickupNotifications.dll` | !K- |
| 3 | Quads Build Orders | `BuildOrders.dll` | !K- |
| 4 | Cartur's Compass and Clock | `CarturCompassAndClock.dll` | !K- |
| 5 | ConfigurationManager | `ConfigurationManager.dll` | !K- |
| 6 | FirstPersonMode | `FirstPersonMode.dll` | !K- |
| 7 | Quads Party HUD | `PartyHud.dll` | !K- |
| 8 | Venture Logout Tweaks | `VentureValheim.LogoutTweaks.dll` | !K- |
| 9 | WorkbenchesPlus | `WorkbenchesPlus.dll` | !K- |
| 10 | GooderAutoShield | `GooderAutoShield.dll` | !K- |

## Строительные и административные моды вне обязательного комплекта

- **Comfy Gizmo** — `ComfyGizmo.dll`, категория **`!!` (постоянный строительный мод администратора)**. Пользователь успешно протестировал поворот исходных prefab для плоской крыши и решил оставить Gizmo в строительной сборке постоянно. Инструмент не добавляет новых prefab для построенной крыши и **не обязан присутствовать у друзей**, но реальные сохранённые постройки нужно проверять на всех клиентах. В последнем локальном снимке DLL активна. [Страница мода](https://thunderstore.io/c/valheim/p/ComfyMods/Gizmo/).
- **Cartur's Flooring** — **исключён 25.10.2026**, `CarturFlooring.dll` не входит в обязательный набор; переместить за пределы `BepInEx/plugins/`. Выбор сделан после удачного теста стандартной крыши с Comfy Gizmo.


- **Sinka** — `!!Sinka.dll` (категория `!!`, строительный режим администратора). По пользовательскому тесту закреплённые сундуки сохраняются после отключения, незакреплённые разваливаются. В последнем снимке ПК 24.10.2026 DLL присутствует активной, но она **не навязывается двум друзьям и не входит в 55 выбранных обязательных/клиентских DLL**. Для сохранения мира перед отключением проверить закрепление и сделать бэкап.
- **PlanBuild** — `!!PlanBuild.dll*` в последнем снимке: отключённый строительный инструмент администратора. Старый план считать обязательным для друзей **не подтверждён текущим локальным снимком**; вопрос совместимости построек/планов решать перед включением.
- **DigDug** — `!!DigDug.dll*`: выключен, но сохранён как инструмент ландшафтного редактирования; пользователь подтвердил сохранение изменений ландшафта после отключения.
- **Quads Build Orders** — `!!BuildOrders.dll*` в последнем снимке ПК: временно выключен; прежняя классификация Only Client относится к режиму, когда он включён. **ПОЛОЖИТЕЛЬНЫЙ ИГРОВОЙ ТЕСТ 24.10.2026:** округлённые/арочные мосты, построенные **BuildOrders (не PlanBuild)** из оригинальных элементов Valheim, **не исчезают при отключении его DLL**. Гарантия относится к наблюдавшемуся мосту, не ко всем модовым объектам и ghost-планам. [Почему сохраняется и идея плоской крыши с поворотом vanilla-prefab](BUILDING_MODS_TEST_2026-10-24.md).
- **MissingPieces** — не включать в рабочую сборку; пользователь протестировал исчезновение добавленных строительных объектов после отключения DLL.
- **ModularLadders** — значился в старом целевом перечне, но **не обнаружен в предоставленном локальном `ls -la`** от 24.10.2026. В перечне пока сохранён как ранее выбранный, требующий сверки фактической установки и безопасного обращения с возможными сохранёнными лестницами.
- **HoeRadius** — удалён пользователем и больше не входит в основную таблицу.

**Учёт (актуальное):** 44 выбранных S/C (включая Quads Quiver, но без Cartur's Flooring) + 10 клиентских = 54 DLL базового плана; отдельно постоянный админский ComfyGizmo = 55 модов в выбранных профилях. Отдельные инструменты из этого раздела не прибавлять автоматически к постоянному базовому набору. Сам последний снимок папки ПК содержит как активные, так и отключённые DLL, поэтому его физическая численность и плановые 55 DLL — разные показатели.

## Отложено — не входит в число DLL

- [SkillsReworked](https://thunderstore.io/c/valheim/p/M2Valheim/SkillsReworked/) — отложен.
- [TalentTree v2.3.5](https://thunderstore.io/c/valheim/p/M2Valheim/TalentTree/v/2.3.5/) — отложен; зависит от SkillsReworked.

## Исключены и архивированы

- `ProjectileTweaks.dll` — **ИСТОРИЧЕСКАЯ ЗАПИСЬ: ВКЛЮЧЕНИЕ ОТМЕНЕНО, МОД СНОВА ИСКЛЮЧЁН** по решению пользователя позже 24.10.2026; ранее исключён 24.10.2026: больше не меняем скорость/прицеливание/зум/счётчик боеприпасов, функции возврата стрел и колчана остаются в `Quiver.dll`. CFG [архивирован](retired-configs/Searica.Valheim.ProjectileTweaks.cfg). Удаление локальной DLL у игроков ещё не проверено.
- `BountyBoard.dll` — исключён из списка ранее 24.10.2026, пользователь приступил к удалению; фактическое удаление на всех ПК и сохранность поставленных досок не подтверждены.

- `BossGate.dll` — **удалён из текущего плана 24.10.2026**. Никакой BossGate-only объект/предмет в мир не добавлялся; сохранять мир и героев всё равно обязательно перед изменением установленных модов.
- `DigDug.dll*` — по-прежнему намеренно выключен.
- `MassFarming.dll` — **не выбирать для друзей**, т.к. их единственная требуемая функция уже есть в PlantEasily; одновременная установка конфликтует.

Исторические контрольные снимки DLL до изменений не переписывать. [Каталог функций и ссылок](README.md); [политика распространения](DEPLOYMENT_POLICY_2026-10-21.md).
