# Valheim — VSP Gamer Modpack

> **Сложный, но управляемый Valheim:** более опасные противники и боссы, осмысленная прогрессия, редкая магическая добыча, дополнительные занятия, строительство и удобство повседневной игры. Настройки подобраны для совместного прохождения с сохранением ценности исследования мира и развития персонажа.

**Основа:** Valheim **1.0.20** (network 41) · Linux / Steam · **BepInEx**.  
**Состояние документации:** 21 октября 2026 года.  
**Политика сборки:** **40 Server / Client**, **7 Only Client (по желанию)**, **0 Only Server**.  
**Исходный инвентарь:** 48 записей DLL, из них `DigDug.dll*` исключён. `Custom Raids` выведен из активной сборки.

Это **каталог состава и настроек**, а не архив готовых DLL и не список проверенных совместимых версий. Названия DLL взяты из пользовательского инвентаря; ссылки ведут на **страницы загрузки** (не фиксированные версии). Под «Server / Client» понимается **обязательность по политике сборки**, а не обещание автора мода о поддержке headless dedicated server. Это ещё проверяется по логам и игровым тестам.

## Ключевые особенности сборки

- **Hardcore и прогрессия:** StarLevelSystem, MonsterLabZ и BossGate повышают сложность и связывают доступ к части возможностей с победами над боссами. `Custom Raids` удалён из активного состава.
- **Добыча и награды:** EpicLoot использует профиль `Legendary` с намеренно редкими магическими предметами; OreMines добавляет шахты; есть рыбная ловля и новые лагерные объекты.
- **Строительство и быт:** подвалы, усиленные колья, расширенные зоны станций, крафт из сундуков, автозаправка плавилен и упорядоченное хранение.
- **Приручённые существа:** индивидуальная защита с восстановлением через 180 секунд; прочие настройки подробно записаны в [handoff](HANDOFF_2026-10-21.yaml).
- **Необязательный клиентский комфорт:** фермерская сетка, чертежи построек, компас, уведомления о добыче, вид от первого лица, автощит и редактор настроек.

## Каталог модов

В столбце **«Что изменено в конфиге»** записаны известные пользовательские значения или решения из истории сборки. Формулировка **«не зафиксированы»** не означает, что мод обязательно работает с настройками по умолчанию: без сравнения с исходной версией автора это утверждать нельзя. Некоторые локальные значения могут отличаться от файлов Git; [аудит различий](LOCAL_SNAPSHOT_AUDIT_2026-10-21.yaml) сохранён отдельно.

### Server / Client — обязательный комплект (40 DLL)

| Мод | Ссылка на скачивание | Автор / публикация | Описание | Server/client тип | Что изменено в конфиге кратко |
|---|---|---|---|---|---|
| **AchievementEnabler**<br><sub>`AchievementEnabler.dll`</sub> | [Страница / скачать](https://thunderstore.io/c/valheim/p/MidnightMods/AchievementEnabler/) | MidnightMods | Разрешает достижения при использовании модов. | **Server / Client** | Отдельные пользовательские изменения не задокументированы. |
| **AutomaticFuel**<br><sub>`AutomaticFuel.dll`</sub> | [Страница / скачать](https://thunderstore.io/c/valheim/p/TastyChickenLegs/AutomaticFuel/) | TastyChickenLegs | Автоматически пополняет топливо и сырьё в производственных станциях из сундуков. | **Server / Client** | Радиус сундуков 15 м; отключение `F10` → `None` согласовано, применение не проверено. |
| **AzuCraftyBoxes**<br><sub>`AzuCraftyBoxes.dll`</sub> | [Страница / скачать](https://thunderstore.io/c/valheim/p/Azumatt/AzuCraftyBoxes/) | Azumatt | Крафт и строительство с использованием материалов из близлежащих контейнеров. | **Server / Client** | Радиус поиска сундуков увеличен до **50 м**. |
| **Basements**<br><sub>`Basements.dll`</sub> | [Страница / скачать](https://thunderstore.io/c/valheim/p/OdinPlus/Basements/) | OdinPlus (порт Elg) | Добавляет размещаемые подвалы для строительства под землёй. | **Server / Client** | Особые пользовательские правки не подтверждены. |
| **BetterTames**<br><sub>`BetterTames.dll`</sub> | [Страница / скачать](https://thunderstore.io/c/valheim/p/xtavim/BetterTames/) | xtavim | Управление прирученными существами: защита, перемещение, питание, развитие. | **Server / Client** | Общая защита выключена; индивидуальная `Alt+E`, восстановление **180 с**; возврат потерявшихся до 30 м. |
| **BiggerPickupRadius**<br><sub>`BiggerPickupRadius.dll`</sub> | [Страница / скачать](https://thunderstore.io/c/valheim/p/mtnewton/BiggerPickupRadius/) | mtnewton | Увеличивает радиус подбора предметов. | **Server / Client** | Индивидуальные правки не зафиксированы. |
| **BossGate**<br><sub>`BossGate.dll`</sub> | [Страница / скачать](https://thunderstore.io/c/valheim/p/Igao/BossGate/) | Igao | Ограничивает технологии и перенос металлов прогрессией убийства боссов. | **Server / Client** | Разрешение металлов через портал после босса; `KickClientsWithoutMod=true`; прогресс общий. |
| **BuyableExtractors**<br><sub>`BuyableExtractors.dll`</sub> | [Страница / скачать](https://thunderstore.io/c/valheim/p/Rollstuhltreter/BuyableExtractors/) | Rollstuhltreter (публикация) | Добавляет покупаемые экстракторы ресурсов. | **Server / Client** | Индивидуальные правки не зафиксированы. |
| **ConditionalConfigSync**<br><sub>`ConditionalConfigSync.dll`</sub> | [Страница / скачать](https://thunderstore.io/c/valheim/p/shudnal/ConditionalConfigSync/) | shudnal | Библиотека синхронизации и серверных политик конфигурации. | **Server / Client** | Файлы правил в `shudnal.ConditionalConfigSync/`; специальных изменений не подтверждено. |
| **ConditionalConfigSync.Plugin**<br><sub>`ConditionalConfigSync.Plugin.dll`</sub> | [Страница / скачать](https://thunderstore.io/c/valheim/p/shudnal/ConditionalConfigSync/) | shudnal | Компонент загрузки той же библиотеки ConditionalConfigSync. | **Server / Client** | Отдельных настроек компонента нет; используется вместе с `ConditionalConfigSync.dll`. |
| **Chain Manager**<br><sub>`Digitalroot.Valheim.ChainManager.dll`</sub> | [Страница / скачать](https://thunderstore.io/c/valheim/p/Digitalroot/Chain_Manager/) | Digitalroot | Позволяет получать/изготавливать цепи без прежних ограничений. | **Server / Client** | Индивидуальные правки не зафиксированы. |
| **EpicLoot**<br><sub>`EpicLoot.dll`</sub> | [Страница / скачать](https://thunderstore.io/c/valheim/p/RandyKnapp/EpicLoot/) | RandyKnapp | Магические предметы, зачарования и награды с прогрессией по боссам. | **Server / Client** | Профиль **Legendary**; глобальный дроп ×0.3, предметы 0.4, материалы 0.35, сеты 0.02; максимум 5 заданий; JSON-патч для инструментов. |
| **ExtraSlots**<br><sub>`ExtraSlots.dll`</sub> | [Страница / скачать](https://thunderstore.io/c/valheim/p/shudnal/ExtraSlots/) | shudnal | Отдельные слоты экипировки, еды и боеприпасов. | **Server / Client** | Клавиши еды `Alt+4/5/6`; отключено облегчение веса в слотах. |
| **ForsakenPowersPlusRemastered**<br><sub>`ForsakenPowersPlusRemastered.dll`</sub> | [Страница / скачать](https://thunderstore.io/c/valheim/p/turbero/ForsakenPowersPlusRemastered/) | turbero | Настройка силы Отрёкшихся: время действия, откат и управление. | **Server / Client** | Действие **300 с**, откат **1200 с**; активация `F8`, сброс без горячей клавиши. |
| **Area Repair**<br><sub>`FrizzQOL.AreaRepair.dll`</sub> | [Страница / скачать](https://thunderstore.io/c/valheim/p/FrizzQOL/Area_Repair/) | FrizzQOL | Массовый ремонт построек в выбранной области. | **Server / Client** | Отдельные правки не задокументированы. |
| **HoeRadius**<br><sub>`HoeRadius.dll`</sub> | [Страница / скачать](https://github.com/aedenthorn/ValheimMods) | aedenthorn | Изменение радиуса воздействия мотыги на местность. | **Server / Client** | Отключена отладочная информация (`debug=false`). |
| **Instantly Destroy Boats And Carts**<br><sub>`InstantlyDestroyBoatsAndCarts.dll`</sub> | [Страница / скачать](https://thunderstore.io/c/valheim/p/Goldenrevolver/Instantly_Destroy_Boats_And_Carts/) | Goldenrevolver | Быстрое разрушение лодок и телег. | **Server / Client** | Отдельные правки не зафиксированы. |
| **Jötunn / Valheim Library**<br><sub>`Jotunn.dll`</sub> | [Страница / скачать](https://thunderstore.io/c/valheim/p/ValheimModding/Jotunn/) | ValheimModding | Библиотека API для модов с предметами, рецептами и строительными объектами. | **Server / Client** | Отдельного пользовательского конфига в снимке нет. |
| **Stations Custom Ranges**<br><sub>`LzD_StationsCustomRanges.dll`</sub> | [Страница / скачать](https://thunderstore.io/c/valheim/p/LzD/LzD_Stations_Custom_Ranges/) | LzD | Настраивает дистанции производственных станций и связанных взаимодействий. | **Server / Client** | Включён; радиус верстака **60 м**, крафт из сундуков **50 м**. |
| **MonsterLabZ**<br><sub>`MonsterLabZ.dll`</sub> | [Страница / скачать](https://thunderstore.io/c/valheim/p/MonsterLabZ/MonsterLabZ/) | MonsterLabZ | Новые противники и существа в биомах. | **Server / Client** | Для **35** секций шанс спавна уменьшен до 25% прежнего, лимиты и группы около ½; `Spawn=Default` сохранён. |
| **JsonDotNET — detector**<br><sub>`NewtonsoftJsonDetector.dll`</sub> | [Страница / скачать](https://thunderstore.io/c/valheim/p/ValheimModding/JsonDotNET/) | ValheimModding (сборка) | Вспомогательный модуль обнаружения версии библиотеки Json.NET. | **Server / Client** | Настройки отсутствуют; подбирается вместе с пакетом зависимости. |
| **JsonDotNET / Newtonsoft.Json**<br><sub>`Newtonsoft.Json.dll`</sub> | [Страница / скачать](https://thunderstore.io/c/valheim/p/ValheimModding/JsonDotNET/) | Newtonsoft; ValheimModding (пакет) | Библиотека чтения и записи JSON, используемая другими модами. | **Server / Client** | Настройки отсутствуют. |
| **NoFoodDegradation**<br><sub>`NoFoodDegradation.dll`</sub> | [Страница / скачать](https://thunderstore.io/c/valheim/p/Dreich/NoFoodDegradation/) | Dreich | Убирает постепенное снижение бонусов пищи. | **Server / Client** | Индивидуальные правки не зафиксированы. |
| **NoMapCartographyTable**<br><sub>`NoMapCartographyTable.dll`</sub> | [Страница / скачать](https://thunderstore.io/c/valheim/p/Dreich/NoMapCartographyTable/) | Dreich | Функции картографического стола для игры без обычной карты. | **Server / Client** | Индивидуальные правки не зафиксированы. |
| **OdinCampsite**<br><sub>`OdinCampsite.dll`</sub> | [Страница / скачать](https://thunderstore.io/c/valheim/p/OdinPlus/OdinCampsite/) | OdinPlus | Дополнительные объекты для лагеря и обустройства стоянки. | **Server / Client** | Индивидуальные правки не зафиксированы; есть файл локализации. |
| **OdinRealmFishing**<br><sub>`OdinRealmFishingMod.dll`</sub> | [Страница / скачать](https://thunderstore.io/c/valheim/p/Odinrealm/OdinRealmFishing/) | Odinrealm | Рыболовные удочки, ловушки, сети и дополнительная рыбалка. | **Server / Client** | Отдельные правки не зафиксированы; ресурс `ropesnap.wav` сохраняется. |
| **OreMines**<br><sub>`OreMines.dll`</sub> | [Страница / скачать](https://thunderstore.io/c/valheim/p/blacks7ar/OreMines/) | blacks7ar | Шахты и рудные жилы как новые точки добычи в мире. | **Server / Client** | Сброс шахт через **30 игровых дней**, шанс появления жилы **35%**. |
| **ProjectileTweaks**<br><sub>`ProjectileTweaks.dll`</sub> | [Страница / скачать](https://thunderstore.io/c/valheim/p/Searica/ProjectileTweaks/) | Searica | Изменяет поведение снарядов и дистанционного оружия. | **Server / Client** | Специальные изменения не задокументированы. |
| **Quick Stack Store**<br><sub>`QuickStackStore.dll`</sub> | [Страница / скачать](https://www.nexusmods.com/valheim/mods/2094) | Goldenrevolver | Быстрое складирование и пополнение предметов из сундуков. | **Server / Client** | Радиус складывания/пополнения **40 м**; удаление горячей клавишей отключено локально (`None`). |
| **Quads Quiver**<br><sub>`Quiver.dll`</sub> | [Страница / скачать](https://thunderstore.io/c/valheim/p/Quads_Lab/Quads_Quiver/) | Quads_Lab | Колчан, возврат стрел и поддержка болтов. | **Server / Client** | Возврат стрел: с земли **100%**, из существ **50%**; огненные сгорают; колчан отображается. |
| **SmartRepair**<br><sub>`SmartRepair.dll`</sub> | [Страница / скачать](https://thunderstore.io/c/valheim/p/LJIndustries/SmartRepair/) | LJIndustries | Автоматически выбирает подходящие повреждённые предметы для ремонта. | **Server / Client** | Отдельные правки не зафиксированы. |
| **SolidHitboxes**<br><sub>`SolidHitboxes.dll`</sub> | [Страница / скачать](https://thunderstore.io/c/valheim/p/Korppis/SolidHitboxes/) | Korppis | Твёрдые хитбоксы и дополнительные настройки коллизий. | **Server / Client** | Индивидуальные правки не зафиксированы. |
| **Spearfishing**<br><sub>`Spearfishing.dll`</sub> | [Страница / скачать](https://thunderstore.io/c/valheim/p/Korppis/Spearfishing/) | Korppis | Рыбалка метательным/дальнобойным оружием. | **Server / Client** | Включены гарпуны, луки и арбалеты; копья выключены (их механику ведёт OdinRealmFishing). |
| **Stake Tweaks**<br><sub>`StakeTweaks.dll`</sub> | [Страница / скачать](https://thunderstore.io/c/valheim/p/TOOLKINGS/Stake_Tweaks/) | TOOLKINGS | Баланс колючих кольев и защитных стен. | **Server / Client** | Урон кольев **×2.5**, прочность кольев и стен **×3**, возврат материалов при разборе. |
| **StarLevelSystem**<br><sub>`StarLevelSystem.dll`</sub> | [Страница / скачать](https://thunderstore.io/c/valheim/p/MidnightMods/StarLevelSystem/) | MidnightMods | Повышенные уровни существ и боссов, модификаторы, Nemesis и рейды. | **Server / Client** | Первичная автоконфигурация: уровни до **3**, Nemesis включён, сброс локаций выключен, множитель спавна **1.1**; дальнейшая настройка отложена. |
| **TopMining**<br><sub>`TopMining.dll`</sub> | [Страница / скачать](https://thunderstore.io/c/valheim/p/NexusTransfer/TopMining/) | NexusTransfer (публикация) | Упрощает добычу рудных месторождений. | **Server / Client** | Отдельные правки не зафиксированы. |
| **No Seasonal Restrictions**<br><sub>`VentureValheim.NoSeasonalRestrictions.dll`</sub> | [Страница / скачать](https://thunderstore.io/c/valheim/p/VentureValheim/No_Seasonal_Restrictions/) | VentureValheim | Снимает сезонные ограничения некоторых игровых предметов. | **Server / Client** | Отдельных пользовательских настроек нет в снимке. |
| **XPortal**<br><sub>`XPortal.dll`</sub> | [Страница / скачать](https://thunderstore.io/c/valheim/p/SpikeHimself/XPortal/) | SpikeHimself | Улучшенная система выбора и управления порталами. | **Server / Client** | Индивидуальные правки не зафиксированы; интеграция с BossGate требует проверки. |
| **YamlDotNet — detector**<br><sub>`YamlDotNetDetector.dll`</sub> | [Страница / скачать](https://thunderstore.io/c/valheim/p/ValheimModding/YamlDotNet/) | ValheimModding (сборка) | Вспомогательный модуль обнаружения версии YamlDotNet. | **Server / Client** | Настройки отсутствуют; устанавливается с пакетом зависимости. |
| **YamlDotNet**<br><sub>`YamlDotNet.dll`</sub> | [Страница / скачать](https://thunderstore.io/c/valheim/p/ValheimModding/YamlDotNet/) | Antoine Aubry и соавторы; ValheimModding (пакет) | Библиотека чтения YAML-конфигураций других модов. | **Server / Client** | Настройки отсутствуют. |

### Only Client — необязательные дополнения (7 DLL)

Эти моды каждый игрок устанавливает **только на своём ПК и по желанию**. Для основной сборки они не должны быть необходимы.

| Мод | Ссылка на скачивание | Автор / публикация | Описание | Server/client тип | Что изменено в конфиге кратко |
|---|---|---|---|---|---|
| **PlantEasily**<br><sub>`Advize_PlantEasily.dll`</sub> | [Страница / скачать](https://thunderstore.io/c/valheim/p/Advize/PlantEasily/) | Advize | Посадка растений по сетке, массовая посадка и уборка. | **Only Client** | Глобальная клавиша включения отключена; привязка к сетке **F10**. |
| **BetterPickupNotifications**<br><sub>`BetterPickupNotifications.dll`</sub> | [Страница / скачать](https://thunderstore.io/c/valheim/p/Pfhoenix/BetterPickupNotifications/) | Pfhoenix | Удобные групповые уведомления о подобранных предметах. | **Only Client** | Индивидуальные правки не зафиксированы. |
| **Quads Build Orders**<br><sub>`BuildOrders.dll`</sub> | [Страница / скачать](https://thunderstore.io/c/valheim/p/Quads_Lab/Quads_Build_Orders/) | Quads_Lab | Планирование построек и размещение призрачных чертежей. | **Only Client** | Планирование **F7**, радиус сборки **24 м**; локально мост: ширина 4, `CoreWood`, `Steps` (Git отличается). |
| **Cartur's Compass and Clock**<br><sub>`CarturCompassAndClock.dll`</sub> | [Страница / скачать](https://thunderstore.io/c/valheim/p/Cartur/Carturs_Compass_and_Clock/) | Cartur | Полоска компаса, метки направления и часы. | **Only Client** | Индивидуальные правки не зафиксированы. |
| **ConfigurationManager**<br><sub>`ConfigurationManager.dll`</sub> | [Страница / скачать](https://thunderstore.io/c/valheim/p/shudnal/ConfigurationManager/) | shudnal | Игровой редактор настроек BepInEx и модов. | **Only Client** | Индивидуальные правки не зафиксированы. |
| **FirstPersonMode**<br><sub>`FirstPersonMode.dll`</sub> | [Страница / скачать](https://thunderstore.io/c/valheim/p/Azumatt/FirstPersonMode/) | Azumatt | Вид от первого лица. | **Only Client** | Индивидуальные правки не зафиксированы. |
| **GooderAutoShield**<br><sub>`GooderAutoShield.dll`</sub> | [Страница / скачать](https://thunderstore.io/c/valheim/p/MainStreetGaming/GooderAutoShield/) | MainStreetGaming (публикация; HumanSandbag) | Автоматическое экипирование подходящего щита. | **Only Client** | Индивидуальные правки не зафиксированы; состояние выбранного щита персональное и не публикуется. |

## Исключения и технические примечания

- **`DigDug.dll*`** сохранён пользователем как намеренно отключённый переименованием DLL и **не входит** ни в серверный, ни в клиентский пакет.
- **`SandboxTools.dll`** — вспомогательный локальный инструмент разблокировки рецептов; **не включён** в распространяемую сборку.
- **`Custom Raids`** выведен из использования, прежние конфиги заархивированы. Используется система рейдов StarLevelSystem.
- **`AutomaticFuel` / `PlantEasily`:** решение отключить клавишу переключения AutomaticFuel (`None`) принято; по предоставленным файлам применение именно этого значения ещё не верифицировано. `PlantEasily F10` сохраняется.
- **`StarLevelSystem`:** использована автоматическая первичная настройка; дополнительное изменение баланса отложено. Записи локальных `*.yaml` и базы EpicLoot не всегда побайтово совпадают с Git.
- Библиотеки `Jotunn`, `ConditionalConfigSync`, `JsonDotNET` и `YamlDotNet` учтены в таблице как **отдельные DLL**, но при скачивании поставляются пакетами с зависимостями. Не устанавливайте случайную другую версию DLL отдельно.
- Конфиги и ссылки на моды **не гарантируют**, что конкретные версии всех DLL загрузятся на dedicated server. Для подтверждения нужны `BepInEx/LogOutput.log`, версии, пробное подключение клиентов и тест на резервной копии мира.

## Где хранятся настройки и история изменений

| Документ / каталог | Назначение |
|---|---|
| [`config/`](config/) | Публичный baseline конфигураций BepInEx и модов |
| [`DEPLOYMENT_POLICY_2026-10-21.md`](DEPLOYMENT_POLICY_2026-10-21.md) | Принятое распределение 40 + 7 + исключения |
| [`CONFIG_PATCH_2026-10-21.md`](CONFIG_PATCH_2026-10-21.md) | Баланс, горячие клавиши, EpicLoot, приручение |
| [`CONFIG_FOLLOWUP_2026-10-21.md`](CONFIG_FOLLOWUP_2026-10-21.md) | AzuCraftyBoxes 50 м и снижение спавна MonsterLabZ |
| [`STAR_LEVEL_SYSTEM_2026-10-21.md`](STAR_LEVEL_SYSTEM_2026-10-21.md) | Снимок автоконфигурации StarLevelSystem |
| [`LOCAL_SNAPSHOT_AUDIT_2026-10-21.yaml`](LOCAL_SNAPSHOT_AUDIT_2026-10-21.yaml) | Отличия локальных конфигов от Git |
| [`CONTINUE_HERE.md`](CONTINUE_HERE.md) · [`HANDOFF_2026-10-21.yaml`](HANDOFF_2026-10-21.yaml) | Точка продолжения и полный технический контекст |

**Безопасность и восстановление:** в репозиторий не включены миры, персонажи, персональные файлы игроков, сохранённые bounty, `SavedData`, временные `*.dat` и DLL. Для переноса сначала установите соответствующие моды, остановите игру/сервер, сделайте резервную копию `BepInEx/config` и миров; только затем применяйте нужные конфиги выборочно. При ошибках откатите конфиги и сохранения из резервной копии.

## Благодарности

Искренняя благодарность **всем авторам, участникам и сопровождающим модов** из таблицы: команде **ValheimModding** и разработчикам **BepInEx** — за инфраструктуру модификаций; **RandyKnapp, MidnightMods, MonsterLabZ, Igao, xtavim, blacks7ar, OdinPlus, Odinrealm, Azumatt, shudnal, Advize, Quads_Lab, Pfhoenix, Cartur, Searica, Korppis** и остальным авторам — за игровой контент, баланс, удобство и поддержку совместимости. Отдельное спасибо создателям и сопровождающим **Json.NET** и **YamlDotNet**, на чьих библиотеках основана работа ряда модов.

Это **любительская подборка и конфигурация**, а не официальный продукт авторов модов или студии Iron Gate. Все авторские права и лицензии принадлежат соответствующим правообладателям; при скачивании и распространении необходимо соблюдать условия оригинальных проектов.
