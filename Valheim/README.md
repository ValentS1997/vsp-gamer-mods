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

**Тип:** `S/C` — Server / Client (обязательно на сервере и у игроков); `C` — Only Client (необязательный клиентский мод). Длинные имена DLL можно переносить по частям — название при этом не меняется.

| Мод | Скачать | Автор | Описание | Тип | Изменения конфига |
|---|---|---|---|---|---|
| **AchievementEnabler**<br><sub><code>Achievement<wbr>Enabler.<wbr>dll</code></sub> | [Скачать](https://thunderstore.io/c/valheim/p/MidnightMods/AchievementEnabler/) | MidnightMods | Разрешает достижения при использовании модов. | **S/C** | Отдельные пользовательские изменения не задокументированы. |
| **AutomaticFuel**<br><sub><code>Automatic<wbr>Fuel.<wbr>dll</code></sub> | [Скачать](https://thunderstore.io/c/valheim/p/TastyChickenLegs/AutomaticFuel/) | TastyChickenLegs | Автоматически пополняет топливо и сырьё в производственных станциях из сундуков. | **S/C** | Радиус сундуков 15 м; отключение `F10` → `None` согласовано, применение не проверено. |
| **AzuCraftyBoxes**<br><sub><code>Azu<wbr>Crafty<wbr>Boxes.<wbr>dll</code></sub> | [Скачать](https://thunderstore.io/c/valheim/p/Azumatt/AzuCraftyBoxes/) | Azumatt | Крафт и строительство с использованием материалов из близлежащих контейнеров. | **S/C** | Радиус поиска сундуков увеличен до **50 м**. |
| **Basements**<br><sub><code>Basements.<wbr>dll</code></sub> | [Скачать](https://thunderstore.io/c/valheim/p/OdinPlus/Basements/) | OdinPlus (порт Elg) | Добавляет размещаемые подвалы для строительства под землёй. | **S/C** | Особые пользовательские правки не подтверждены. |
| **BetterTames**<br><sub><code>Better<wbr>Tames.<wbr>dll</code></sub> | [Скачать](https://thunderstore.io/c/valheim/p/xtavim/BetterTames/) | xtavim | Управление прирученными существами: защита, перемещение, питание, развитие. | **S/C** | Общая защита выключена; индивидуальная `Alt+E`, восстановление **180 с**; возврат потерявшихся до 30 м. |
| **BiggerPickupRadius**<br><sub><code>Bigger<wbr>Pickup<wbr>Radius.<wbr>dll</code></sub> | [Скачать](https://thunderstore.io/c/valheim/p/mtnewton/BiggerPickupRadius/) | mtnewton | Увеличивает радиус подбора предметов. | **S/C** | Индивидуальные правки не зафиксированы. |
| **BossGate**<br><sub><code>Boss<wbr>Gate.<wbr>dll</code></sub> | [Скачать](https://thunderstore.io/c/valheim/p/Igao/BossGate/) | Igao | Ограничивает технологии и перенос металлов прогрессией убийства боссов. | **S/C** | Разрешение металлов через портал после босса; `KickClientsWithoutMod=true`; прогресс общий. |
| **BuyableExtractors**<br><sub><code>Buyable<wbr>Extractors.<wbr>dll</code></sub> | [Скачать](https://thunderstore.io/c/valheim/p/Rollstuhltreter/BuyableExtractors/) | Rollstuhltreter (публикация) | Добавляет покупаемые экстракторы ресурсов. | **S/C** | Индивидуальные правки не зафиксированы. |
| **Conditional<wbr>Config<wbr>Sync**<br><sub><code>Conditional<wbr>Config<wbr>Sync.<wbr>dll</code></sub> | [Скачать](https://thunderstore.io/c/valheim/p/shudnal/ConditionalConfigSync/) | shudnal | Библиотека синхронизации и серверных политик конфигурации. | **S/C** | Файлы правил в `shudnal.ConditionalConfigSync/`; специальных изменений не подтверждено. |
| **Conditional<wbr>Config<wbr>Sync.<wbr>Plugin**<br><sub><code>Conditional<wbr>Config<wbr>Sync.<wbr>Plugin.<wbr>dll</code></sub> | [Скачать](https://thunderstore.io/c/valheim/p/shudnal/ConditionalConfigSync/) | shudnal | Компонент загрузки той же библиотеки ConditionalConfigSync. | **S/C** | Отдельных настроек компонента нет; используется вместе с `ConditionalConfigSync.dll`. |
| **Chain Manager**<br><sub><code>Digitalroot.<wbr>Valheim.<wbr>Chain<wbr>Manager.<wbr>dll</code></sub> | [Скачать](https://thunderstore.io/c/valheim/p/Digitalroot/Chain_Manager/) | Digitalroot | Позволяет получать/изготавливать цепи без прежних ограничений. | **S/C** | Индивидуальные правки не зафиксированы. |
| **EpicLoot**<br><sub><code>Epic<wbr>Loot.<wbr>dll</code></sub> | [Скачать](https://thunderstore.io/c/valheim/p/RandyKnapp/EpicLoot/) | RandyKnapp | Магические предметы, зачарования и награды с прогрессией по боссам. | **S/C** | Профиль **Legendary**; глобальный дроп ×0.3, предметы 0.4, материалы 0.35, сеты 0.02; максимум 5 заданий; JSON-патч для инструментов. |
| **ExtraSlots**<br><sub><code>Extra<wbr>Slots.<wbr>dll</code></sub> | [Скачать](https://thunderstore.io/c/valheim/p/shudnal/ExtraSlots/) | shudnal | Отдельные слоты экипировки, еды и боеприпасов. | **S/C** | Клавиши еды `Alt+4/5/6`; отключено облегчение веса в слотах. |
| **Forsaken<wbr>Powers<wbr>Plus<wbr>Remastered**<br><sub><code>Forsaken<wbr>Powers<wbr>Plus<wbr>Remastered.<wbr>dll</code></sub> | [Скачать](https://thunderstore.io/c/valheim/p/turbero/ForsakenPowersPlusRemastered/) | turbero | Настройка силы Отрёкшихся: время действия, откат и управление. | **S/C** | Действие **300 с**, откат **1200 с**; активация `F8`, сброс без горячей клавиши. |
| **Area Repair**<br><sub><code>Frizz<wbr>QOL.<wbr>Area<wbr>Repair.<wbr>dll</code></sub> | [Скачать](https://thunderstore.io/c/valheim/p/FrizzQOL/Area_Repair/) | FrizzQOL | Массовый ремонт построек в выбранной области. | **S/C** | Отдельные правки не задокументированы. |
| **HoeRadius**<br><sub><code>Hoe<wbr>Radius.<wbr>dll</code></sub> | [Скачать](https://github.com/aedenthorn/ValheimMods) | aedenthorn | Изменение радиуса воздействия мотыги на местность. | **S/C** | Отключена отладочная информация (`debug=false`). |
| **Instantly Destroy Boats And Carts**<br><sub><code>Instantly<wbr>Destroy<wbr>Boats<wbr>And<wbr>Carts.<wbr>dll</code></sub> | [Скачать](https://thunderstore.io/c/valheim/p/Goldenrevolver/Instantly_Destroy_Boats_And_Carts/) | Goldenrevolver | Быстрое разрушение лодок и телег. | **S/C** | Отдельные правки не зафиксированы. |
| **Jötunn / Valheim Library**<br><sub><code>Jotunn.<wbr>dll</code></sub> | [Скачать](https://thunderstore.io/c/valheim/p/ValheimModding/Jotunn/) | ValheimModding | Библиотека API для модов с предметами, рецептами и строительными объектами. | **S/C** | Отдельного пользовательского конфига в снимке нет. |
| **Stations Custom Ranges**<br><sub><code>Lz<wbr>D_<wbr>Stations<wbr>Custom<wbr>Ranges.<wbr>dll</code></sub> | [Скачать](https://thunderstore.io/c/valheim/p/LzD/LzD_Stations_Custom_Ranges/) | LzD | Настраивает дистанции производственных станций и связанных взаимодействий. | **S/C** | Включён; радиус верстака **60 м**, крафт из сундуков **50 м**. |
| **MonsterLabZ**<br><sub><code>Monster<wbr>Lab<wbr>Z.<wbr>dll</code></sub> | [Скачать](https://thunderstore.io/c/valheim/p/MonsterLabZ/MonsterLabZ/) | MonsterLabZ | Новые противники и существа в биомах. | **S/C** | Для **35** секций шанс спавна уменьшен до 25% прежнего, лимиты и группы около ½; `Spawn=Default` сохранён. |
| **JsonDotNET — detector**<br><sub><code>Newtonsoft<wbr>Json<wbr>Detector.<wbr>dll</code></sub> | [Скачать](https://thunderstore.io/c/valheim/p/ValheimModding/JsonDotNET/) | ValheimModding (сборка) | Вспомогательный модуль обнаружения версии библиотеки Json.NET. | **S/C** | Настройки отсутствуют; подбирается вместе с пакетом зависимости. |
| **JsonDotNET / Newtonsoft.Json**<br><sub><code>Newtonsoft.<wbr>Json.<wbr>dll</code></sub> | [Скачать](https://thunderstore.io/c/valheim/p/ValheimModding/JsonDotNET/) | Newtonsoft; ValheimModding (пакет) | Библиотека чтения и записи JSON, используемая другими модами. | **S/C** | Настройки отсутствуют. |
| **NoFoodDegradation**<br><sub><code>No<wbr>Food<wbr>Degradation.<wbr>dll</code></sub> | [Скачать](https://thunderstore.io/c/valheim/p/Dreich/NoFoodDegradation/) | Dreich | Убирает постепенное снижение бонусов пищи. | **S/C** | Индивидуальные правки не зафиксированы. |
| **No<wbr>Map<wbr>Cartography<wbr>Table**<br><sub><code>No<wbr>Map<wbr>Cartography<wbr>Table.<wbr>dll</code></sub> | [Скачать](https://thunderstore.io/c/valheim/p/Dreich/NoMapCartographyTable/) | Dreich | Функции картографического стола для игры без обычной карты. | **S/C** | Индивидуальные правки не зафиксированы. |
| **OdinCampsite**<br><sub><code>Odin<wbr>Campsite.<wbr>dll</code></sub> | [Скачать](https://thunderstore.io/c/valheim/p/OdinPlus/OdinCampsite/) | OdinPlus | Дополнительные объекты для лагеря и обустройства стоянки. | **S/C** | Индивидуальные правки не зафиксированы; есть файл локализации. |
| **OdinRealmFishing**<br><sub><code>Odin<wbr>Realm<wbr>Fishing<wbr>Mod.<wbr>dll</code></sub> | [Скачать](https://thunderstore.io/c/valheim/p/Odinrealm/OdinRealmFishing/) | Odinrealm | Рыболовные удочки, ловушки, сети и дополнительная рыбалка. | **S/C** | Отдельные правки не зафиксированы; ресурс `ropesnap.wav` сохраняется. |
| **OreMines**<br><sub><code>Ore<wbr>Mines.<wbr>dll</code></sub> | [Скачать](https://thunderstore.io/c/valheim/p/blacks7ar/OreMines/) | blacks7ar | Шахты и рудные жилы как новые точки добычи в мире. | **S/C** | Сброс шахт через **30 игровых дней**, шанс появления жилы **35%**. |
| **ProjectileTweaks**<br><sub><code>Projectile<wbr>Tweaks.<wbr>dll</code></sub> | [Скачать](https://thunderstore.io/c/valheim/p/Searica/ProjectileTweaks/) | Searica | Изменяет поведение снарядов и дистанционного оружия. | **S/C** | Специальные изменения не задокументированы. |
| **Quick Stack Store**<br><sub><code>Quick<wbr>Stack<wbr>Store.<wbr>dll</code></sub> | [Скачать](https://www.nexusmods.com/valheim/mods/2094) | Goldenrevolver | Быстрое складирование и пополнение предметов из сундуков. | **S/C** | Радиус складывания/пополнения **40 м**; удаление горячей клавишей отключено локально (`None`). |
| **Quads Quiver**<br><sub><code>Quiver.<wbr>dll</code></sub> | [Скачать](https://thunderstore.io/c/valheim/p/Quads_Lab/Quads_Quiver/) | Quads_Lab | Колчан, возврат стрел и поддержка болтов. | **S/C** | Возврат стрел: с земли **100%**, из существ **50%**; огненные сгорают; колчан отображается. |
| **SmartRepair**<br><sub><code>Smart<wbr>Repair.<wbr>dll</code></sub> | [Скачать](https://thunderstore.io/c/valheim/p/LJIndustries/SmartRepair/) | LJIndustries | Автоматически выбирает подходящие повреждённые предметы для ремонта. | **S/C** | Отдельные правки не зафиксированы. |
| **SolidHitboxes**<br><sub><code>Solid<wbr>Hitboxes.<wbr>dll</code></sub> | [Скачать](https://thunderstore.io/c/valheim/p/Korppis/SolidHitboxes/) | Korppis | Твёрдые хитбоксы и дополнительные настройки коллизий. | **S/C** | Индивидуальные правки не зафиксированы. |
| **Spearfishing**<br><sub><code>Spearfishing.<wbr>dll</code></sub> | [Скачать](https://thunderstore.io/c/valheim/p/Korppis/Spearfishing/) | Korppis | Рыбалка метательным/дальнобойным оружием. | **S/C** | Включены гарпуны, луки и арбалеты; копья выключены (их механику ведёт OdinRealmFishing). |
| **Stake Tweaks**<br><sub><code>Stake<wbr>Tweaks.<wbr>dll</code></sub> | [Скачать](https://thunderstore.io/c/valheim/p/TOOLKINGS/Stake_Tweaks/) | TOOLKINGS | Баланс колючих кольев и защитных стен. | **S/C** | Урон кольев **×2.5**, прочность кольев и стен **×3**, возврат материалов при разборе. |
| **StarLevelSystem**<br><sub><code>Star<wbr>Level<wbr>System.<wbr>dll</code></sub> | [Скачать](https://thunderstore.io/c/valheim/p/MidnightMods/StarLevelSystem/) | MidnightMods | Повышенные уровни существ и боссов, модификаторы, Nemesis и рейды. | **S/C** | Первичная автоконфигурация: уровни до **3**, Nemesis включён, сброс локаций выключен, множитель спавна **1.1**; дальнейшая настройка отложена. |
| **TopMining**<br><sub><code>Top<wbr>Mining.<wbr>dll</code></sub> | [Скачать](https://thunderstore.io/c/valheim/p/NexusTransfer/TopMining/) | NexusTransfer (публикация) | Упрощает добычу рудных месторождений. | **S/C** | Отдельные правки не зафиксированы. |
| **No Seasonal Restrictions**<br><sub><code>Venture<wbr>Valheim.<wbr>No<wbr>Seasonal<wbr>Restrictions.<wbr>dll</code></sub> | [Скачать](https://thunderstore.io/c/valheim/p/VentureValheim/No_Seasonal_Restrictions/) | VentureValheim | Снимает сезонные ограничения некоторых игровых предметов. | **S/C** | Отдельных пользовательских настроек нет в снимке. |
| **XPortal**<br><sub><code>XPortal.<wbr>dll</code></sub> | [Скачать](https://thunderstore.io/c/valheim/p/SpikeHimself/XPortal/) | SpikeHimself | Улучшенная система выбора и управления порталами. | **S/C** | Индивидуальные правки не зафиксированы; интеграция с BossGate требует проверки. |
| **YamlDotNet — detector**<br><sub><code>Yaml<wbr>Dot<wbr>Net<wbr>Detector.<wbr>dll</code></sub> | [Скачать](https://thunderstore.io/c/valheim/p/ValheimModding/YamlDotNet/) | ValheimModding (сборка) | Вспомогательный модуль обнаружения версии YamlDotNet. | **S/C** | Настройки отсутствуют; устанавливается с пакетом зависимости. |
| **YamlDotNet**<br><sub><code>Yaml<wbr>Dot<wbr>Net.<wbr>dll</code></sub> | [Скачать](https://thunderstore.io/c/valheim/p/ValheimModding/YamlDotNet/) | Antoine Aubry и соавторы; ValheimModding (пакет) | Библиотека чтения YAML-конфигураций других модов. | **S/C** | Настройки отсутствуют. |

### Only Client — необязательные дополнения (7 DLL)

Эти моды каждый игрок устанавливает **только на своём ПК и по желанию**. Для основной сборки они не должны быть необходимы.

| Мод | Скачать | Автор | Описание | Тип | Изменения конфига |
|---|---|---|---|---|---|
| **PlantEasily**<br><sub><code>Advize_<wbr>Plant<wbr>Easily.<wbr>dll</code></sub> | [Скачать](https://thunderstore.io/c/valheim/p/Advize/PlantEasily/) | Advize | Посадка растений по сетке, массовая посадка и уборка. | **C** | Глобальная клавиша включения отключена; привязка к сетке **F10**. |
| **Better<wbr>Pickup<wbr>Notifications**<br><sub><code>Better<wbr>Pickup<wbr>Notifications.<wbr>dll</code></sub> | [Скачать](https://thunderstore.io/c/valheim/p/Pfhoenix/BetterPickupNotifications/) | Pfhoenix | Удобные групповые уведомления о подобранных предметах. | **C** | Индивидуальные правки не зафиксированы. |
| **Quads Build Orders**<br><sub><code>Build<wbr>Orders.<wbr>dll</code></sub> | [Скачать](https://thunderstore.io/c/valheim/p/Quads_Lab/Quads_Build_Orders/) | Quads_Lab | Планирование построек и размещение призрачных чертежей. | **C** | Планирование **F7**, радиус сборки **24 м**; локально мост: ширина 4, `CoreWood`, `Steps` (Git отличается). |
| **Cartur's Compass and Clock**<br><sub><code>Cartur<wbr>Compass<wbr>And<wbr>Clock.<wbr>dll</code></sub> | [Скачать](https://thunderstore.io/c/valheim/p/Cartur/Carturs_Compass_and_Clock/) | Cartur | Полоска компаса, метки направления и часы. | **C** | Индивидуальные правки не зафиксированы. |
| **ConfigurationManager**<br><sub><code>Configuration<wbr>Manager.<wbr>dll</code></sub> | [Скачать](https://thunderstore.io/c/valheim/p/shudnal/ConfigurationManager/) | shudnal | Игровой редактор настроек BepInEx и модов. | **C** | Индивидуальные правки не зафиксированы. |
| **FirstPersonMode**<br><sub><code>First<wbr>Person<wbr>Mode.<wbr>dll</code></sub> | [Скачать](https://thunderstore.io/c/valheim/p/Azumatt/FirstPersonMode/) | Azumatt | Вид от первого лица. | **C** | Индивидуальные правки не зафиксированы. |
| **GooderAutoShield**<br><sub><code>Gooder<wbr>Auto<wbr>Shield.<wbr>dll</code></sub> | [Скачать](https://thunderstore.io/c/valheim/p/MainStreetGaming/GooderAutoShield/) | MainStreetGaming (публикация; HumanSandbag) | Автоматическое экипирование подходящего щита. | **C** | Индивидуальные правки не зафиксированы; состояние выбранного щита персональное и не публикуется. |

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
