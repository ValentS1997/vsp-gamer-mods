# Valheim — VSP Gamer Modpack

> **Сложный, но управляемый Valheim:** более опасные противники и боссы, осмысленная прогрессия, редкая магическая добыча, дополнительные занятия, строительство и удобство повседневной игры. Настройки подобраны для совместного прохождения с сохранением ценности исследования мира и развития персонажа.

**Основа:** Valheim **1.0.20** (network 41) · Linux / Steam · **BepInEx**.  
**Состояние документации:** 21 октября 2026 года.  
**Состав сборки:** **42 Server / Client**, **7 Only Client (по желанию)**, **0 Only Server**; два новых мода — FiresGhettoNetworking и HipLantern. Обязательность установки указана по политике проекта, runtime-тест dedicated server остаётся открытым.  
**Исходный инвентарь (21.10.2026):** 48 записей DLL, из них `DigDug.dll*` исключён; **после добавления 2 новых модов:** 50 учтённых записей (42 общих + 7 необязательных + 1 исключённая). `Custom Raids` выведен из активной сборки.

Это **каталог состава и настроек**, а не архив готовых DLL и не список проверенных совместимых версий. Названия DLL взяты из пользовательского инвентаря; ссылки ведут на **страницы загрузки** (не фиксированные версии). Под «Server / Client» понимается **обязательность по политике сборки**, а не обещание автора мода о поддержке headless dedicated server. Это ещё проверяется по логам и игровым тестам.

## Ключевые особенности сборки

- **Hardcore и прогрессия:** StarLevelSystem, MonsterLabZ и BossGate повышают сложность и связывают доступ к части возможностей с победами над боссами. `Custom Raids` удалён из активного состава.
- **Добыча и награды:** EpicLoot использует профиль `Legendary` с намеренно редкими магическими предметами; OreMines добавляет шахты; есть рыбная ловля и новые лагерные объекты.
- **Строительство и быт:** подвалы, усиленные колья, расширенные зоны станций, крафт из сундуков, автозаправка плавилен и упорядоченное хранение.
- **Приручённые существа:** индивидуальная защита с восстановлением через 180 секунд; прочие настройки подробно записаны в [handoff](HANDOFF_2026-10-21.yaml).
- **Необязательный клиентский комфорт:** фермерская сетка, чертежи построек, компас, уведомления о добыче, вид от первого лица, автощит и редактор настроек.

## Каталог модов

В столбце **«Что изменено в конфиге»** записаны известные пользовательские значения или решения из истории сборки. Формулировка **«не зафиксированы»** не означает, что мод обязательно работает с настройками по умолчанию: без сравнения с исходной версией автора это утверждать нельзя. Некоторые локальные значения могут отличаться от файлов Git; [аудит различий](LOCAL_SNAPSHOT_AUDIT_2026-10-21.yaml) сохранён отдельно.

### Server / Client — обязательный комплект (42 DLL)

**Тип:** `S/C` — Server / Client (обязательно на сервере и у игроков); `C` — Only Client (необязательный клиентский мод). Ссылки скачивания размещены вместе с именами модов, типы — рядом с авторами. Так для описания и изменений конфигурации остаётся больше места.

| Мод и скачивание | Автор / тип | Описание | Изменения конфига |
|---|---|---|---|
| **AchievementEnabler**<br><sub><code>Achievement<wbr>Enabler.<wbr>dll</code></sub><br>[Скачать](https://thunderstore.io/c/valheim/p/MidnightMods/AchievementEnabler/) | MidnightMods<br>**S/C** | Разрешает достижения при использовании модов. | Отдельные пользовательские изменения не задокументированы. |
| **AutomaticFuel**<br><sub><code>Automatic<wbr>Fuel.<wbr>dll</code></sub><br>[Скачать](https://thunderstore.io/c/valheim/p/TastyChickenLegs/AutomaticFuel/) | TastyChickenLegs<br>**S/C** | Автоматически пополняет топливо и сырьё в производственных станциях из сундуков. | Радиус сундуков 15 м; отключение `F10` → `None` согласовано, применение не проверено. |
| **AzuCraftyBoxes**<br><sub><code>Azu<wbr>Crafty<wbr>Boxes.<wbr>dll</code></sub><br>[Скачать](https://thunderstore.io/c/valheim/p/Azumatt/AzuCraftyBoxes/) | Azumatt<br>**S/C** | Крафт и строительство с использованием материалов из близлежащих контейнеров. | Радиус поиска сундуков увеличен до **50 м**. |
| **Basements**<br><sub><code>Basements.<wbr>dll</code></sub><br>[Скачать](https://thunderstore.io/c/valheim/p/OdinPlus/Basements/) | OdinPlus (порт Elg)<br>**S/C** | Добавляет размещаемые подвалы для строительства под землёй. | Особые пользовательские правки не подтверждены. |
| **BetterTames**<br><sub><code>Better<wbr>Tames.<wbr>dll</code></sub><br>[Скачать](https://thunderstore.io/c/valheim/p/xtavim/BetterTames/) | xtavim<br>**S/C** | Управление прирученными существами: защита, перемещение, питание, развитие. | Общая защита выключена; индивидуальная `Alt+E`, восстановление **180 с**; возврат потерявшихся до 30 м. |
| **BiggerPickupRadius**<br><sub><code>Bigger<wbr>Pickup<wbr>Radius.<wbr>dll</code></sub><br>[Скачать](https://thunderstore.io/c/valheim/p/mtnewton/BiggerPickupRadius/) | mtnewton<br>**S/C** | Увеличивает радиус подбора предметов. | Индивидуальные правки не зафиксированы. |
| **BossGate**<br><sub><code>Boss<wbr>Gate.<wbr>dll</code></sub><br>[Скачать](https://thunderstore.io/c/valheim/p/Igao/BossGate/) | Igao<br>**S/C** | Ограничивает технологии и перенос металлов прогрессией убийства боссов. | Разрешение металлов через портал после босса; `KickClientsWithoutMod=true`; прогресс общий. |
| **BuyableExtractors**<br><sub><code>Buyable<wbr>Extractors.<wbr>dll</code></sub><br>[Скачать](https://thunderstore.io/c/valheim/p/Rollstuhltreter/BuyableExtractors/) | Rollstuhltreter (публикация)<br>**S/C** | Добавляет покупаемые экстракторы ресурсов. | Индивидуальные правки не зафиксированы. |
| **Conditional<wbr>Config<wbr>Sync**<br><sub><code>Conditional<wbr>Config<wbr>Sync.<wbr>dll</code></sub><br>[Скачать](https://thunderstore.io/c/valheim/p/shudnal/ConditionalConfigSync/) | shudnal<br>**S/C** | Библиотека синхронизации и серверных политик конфигурации. | Файлы правил в `shudnal.ConditionalConfigSync/`; специальных изменений не подтверждено. |
| **Conditional<wbr>Config<wbr>Sync.<wbr>Plugin**<br><sub><code>Conditional<wbr>Config<wbr>Sync.<wbr>Plugin.<wbr>dll</code></sub><br>[Скачать](https://thunderstore.io/c/valheim/p/shudnal/ConditionalConfigSync/) | shudnal<br>**S/C** | Компонент загрузки той же библиотеки ConditionalConfigSync. | Отдельных настроек компонента нет; используется вместе с `ConditionalConfigSync.dll`. |
| **Chain Manager**<br><sub><code>Digitalroot.<wbr>Valheim.<wbr>Chain<wbr>Manager.<wbr>dll</code></sub><br>[Скачать](https://thunderstore.io/c/valheim/p/Digitalroot/Chain_Manager/) | Digitalroot<br>**S/C** | Позволяет получать/изготавливать цепи без прежних ограничений. | Индивидуальные правки не зафиксированы. |
| **EpicLoot**<br><sub><code>Epic<wbr>Loot.<wbr>dll</code></sub><br>[Скачать](https://thunderstore.io/c/valheim/p/RandyKnapp/EpicLoot/) | RandyKnapp<br>**S/C** | Магические предметы, зачарования и награды с прогрессией по боссам. | Профиль **Legendary**; глобальный дроп ×0.3, предметы 0.4, материалы 0.35, сеты 0.02; максимум 5 заданий; JSON-патч для инструментов. |
| **ExtraSlots**<br><sub><code>Extra<wbr>Slots.<wbr>dll</code></sub><br>[Скачать](https://thunderstore.io/c/valheim/p/shudnal/ExtraSlots/) | shudnal<br>**S/C** | Отдельные слоты экипировки, еды и боеприпасов. | Клавиши еды `Alt+4/5/6`; отключено облегчение веса в слотах. |
| **FiresGhettoNetworking**<br><sub><code>VAGhettoNetworking.dll</code></sub><br>[Скачать](https://thunderstore.io/c/valheim/p/VerdantsAscent/FiresGhettoNetworking/) | VerdantsAscent<br>**S/C** | Комплексная сетевая оптимизация: сжатие, очереди и автоподстройка; дополнительные функции симуляции на dedicated server. | В конфиге v1.5.65 включены `Server-Side Simulation` и обе экспериментальные настройки `ZDO Ownership Transfer`; режим Selective имеет приоритет. Для обычного игрового хоста серверные режимы не подтверждены. |
| **Forsaken<wbr>Powers<wbr>Plus<wbr>Remastered**<br><sub><code>Forsaken<wbr>Powers<wbr>Plus<wbr>Remastered.<wbr>dll</code></sub><br>[Скачать](https://thunderstore.io/c/valheim/p/turbero/ForsakenPowersPlusRemastered/) | turbero<br>**S/C** | Настройка силы Отрёкшихся: время действия, откат и управление. | Действие **300 с**, откат **1200 с**; активация `F8`, сброс без горячей клавиши. |
| **Area Repair**<br><sub><code>Frizz<wbr>QOL.<wbr>Area<wbr>Repair.<wbr>dll</code></sub><br>[Скачать](https://thunderstore.io/c/valheim/p/FrizzQOL/Area_Repair/) | FrizzQOL<br>**S/C** | Массовый ремонт построек в выбранной области. | Отдельные правки не задокументированы. |
| **HoeRadius**<br><sub><code>Hoe<wbr>Radius.<wbr>dll</code></sub><br>[Скачать](https://github.com/aedenthorn/ValheimMods) | aedenthorn<br>**S/C** | Изменение радиуса воздействия мотыги на местность. | Отключена отладочная информация (`debug=false`). |
| **HipLantern**<br><sub><code>HipLantern.dll</code></sub><br>[Скачать](https://thunderstore.io/c/valheim/p/shudnal/HipLantern/) | shudnal<br>**S/C** | Поясной фонарь с постоянным освещением, топливом, теплом и отдельным слотом через ExtraSlots. | `ExtraSlots - Create slot = true`; `Available after discovery = false`; `Scale = 0.5` (**×2**); топливо **240 минут**. Git-конфиг восстановлен из старой загрузки и согласованных правок, точная локальная копия не загружена. |
| **Instantly Destroy Boats And Carts**<br><sub><code>Instantly<wbr>Destroy<wbr>Boats<wbr>And<wbr>Carts.<wbr>dll</code></sub><br>[Скачать](https://thunderstore.io/c/valheim/p/Goldenrevolver/Instantly_Destroy_Boats_And_Carts/) | Goldenrevolver<br>**S/C** | Быстрое разрушение лодок и телег. | Отдельные правки не зафиксированы. |
| **Jötunn / Valheim Library**<br><sub><code>Jotunn.<wbr>dll</code></sub><br>[Скачать](https://thunderstore.io/c/valheim/p/ValheimModding/Jotunn/) | ValheimModding<br>**S/C** | Библиотека API для модов с предметами, рецептами и строительными объектами. | Отдельного пользовательского конфига в снимке нет. |
| **Stations Custom Ranges**<br><sub><code>Lz<wbr>D_<wbr>Stations<wbr>Custom<wbr>Ranges.<wbr>dll</code></sub><br>[Скачать](https://thunderstore.io/c/valheim/p/LzD/LzD_Stations_Custom_Ranges/) | LzD<br>**S/C** | Настраивает дистанции производственных станций и связанных взаимодействий. | Включён; радиус верстака **60 м**, крафт из сундуков **50 м**. |
| **MonsterLabZ**<br><sub><code>Monster<wbr>Lab<wbr>Z.<wbr>dll</code></sub><br>[Скачать](https://thunderstore.io/c/valheim/p/MonsterLabZ/MonsterLabZ/) | MonsterLabZ<br>**S/C** | Новые противники и существа в биомах. | Для **35** секций шанс спавна уменьшен до 25% прежнего, лимиты и группы около ½; `Spawn=Default` сохранён. |
| **JsonDotNET — detector**<br><sub><code>Newtonsoft<wbr>Json<wbr>Detector.<wbr>dll</code></sub><br>[Скачать](https://thunderstore.io/c/valheim/p/ValheimModding/JsonDotNET/) | ValheimModding (сборка)<br>**S/C** | Вспомогательный модуль обнаружения версии библиотеки Json.NET. | Настройки отсутствуют; подбирается вместе с пакетом зависимости. |
| **JsonDotNET / Newtonsoft.Json**<br><sub><code>Newtonsoft.<wbr>Json.<wbr>dll</code></sub><br>[Скачать](https://thunderstore.io/c/valheim/p/ValheimModding/JsonDotNET/) | Newtonsoft; ValheimModding (пакет)<br>**S/C** | Библиотека чтения и записи JSON, используемая другими модами. | Настройки отсутствуют. |
| **NoFoodDegradation**<br><sub><code>No<wbr>Food<wbr>Degradation.<wbr>dll</code></sub><br>[Скачать](https://thunderstore.io/c/valheim/p/Dreich/NoFoodDegradation/) | Dreich<br>**S/C** | Убирает постепенное снижение бонусов пищи. | Индивидуальные правки не зафиксированы. |
| **No<wbr>Map<wbr>Cartography<wbr>Table**<br><sub><code>No<wbr>Map<wbr>Cartography<wbr>Table.<wbr>dll</code></sub><br>[Скачать](https://thunderstore.io/c/valheim/p/Dreich/NoMapCartographyTable/) | Dreich<br>**S/C** | Функции картографического стола для игры без обычной карты. | Индивидуальные правки не зафиксированы. |
| **OdinCampsite**<br><sub><code>Odin<wbr>Campsite.<wbr>dll</code></sub><br>[Скачать](https://thunderstore.io/c/valheim/p/OdinPlus/OdinCampsite/) | OdinPlus<br>**S/C** | Дополнительные объекты для лагеря и обустройства стоянки. | Индивидуальные правки не зафиксированы; есть файл локализации. |
| **OdinRealmFishing**<br><sub><code>Odin<wbr>Realm<wbr>Fishing<wbr>Mod.<wbr>dll</code></sub><br>[Скачать](https://thunderstore.io/c/valheim/p/Odinrealm/OdinRealmFishing/) | Odinrealm<br>**S/C** | Рыболовные удочки, ловушки, сети и дополнительная рыбалка. | Отдельные правки не зафиксированы; ресурс `ropesnap.wav` сохраняется. |
| **OreMines**<br><sub><code>Ore<wbr>Mines.<wbr>dll</code></sub><br>[Скачать](https://thunderstore.io/c/valheim/p/blacks7ar/OreMines/) | blacks7ar<br>**S/C** | Шахты и рудные жилы как новые точки добычи в мире. | Сброс шахт через **30 игровых дней**, шанс появления жилы **35%**. |
| **ProjectileTweaks**<br><sub><code>Projectile<wbr>Tweaks.<wbr>dll</code></sub><br>[Скачать](https://thunderstore.io/c/valheim/p/Searica/ProjectileTweaks/) | Searica<br>**S/C** | Изменяет поведение снарядов и дистанционного оружия. | Специальные изменения не задокументированы. |
| **Quick Stack Store**<br><sub><code>Quick<wbr>Stack<wbr>Store.<wbr>dll</code></sub><br>[Скачать](https://www.nexusmods.com/valheim/mods/2094) | Goldenrevolver<br>**S/C** | Быстрое складирование и пополнение предметов из сундуков. | Радиус складывания/пополнения **40 м**; удаление горячей клавишей отключено локально (`None`). |
| **Quads Quiver**<br><sub><code>Quiver.<wbr>dll</code></sub><br>[Скачать](https://thunderstore.io/c/valheim/p/Quads_Lab/Quads_Quiver/) | Quads_Lab<br>**S/C** | Колчан, возврат стрел и поддержка болтов. | Возврат стрел: с земли **100%**, из существ **50%**; огненные сгорают; колчан отображается. |
| **SmartRepair**<br><sub><code>Smart<wbr>Repair.<wbr>dll</code></sub><br>[Скачать](https://thunderstore.io/c/valheim/p/LJIndustries/SmartRepair/) | LJIndustries<br>**S/C** | Автоматически выбирает подходящие повреждённые предметы для ремонта. | Отдельные правки не зафиксированы. |
| **SolidHitboxes**<br><sub><code>Solid<wbr>Hitboxes.<wbr>dll</code></sub><br>[Скачать](https://thunderstore.io/c/valheim/p/Korppis/SolidHitboxes/) | Korppis<br>**S/C** | Твёрдые хитбоксы и дополнительные настройки коллизий. | Индивидуальные правки не зафиксированы. |
| **Spearfishing**<br><sub><code>Spearfishing.<wbr>dll</code></sub><br>[Скачать](https://thunderstore.io/c/valheim/p/Korppis/Spearfishing/) | Korppis<br>**S/C** | Рыбалка метательным/дальнобойным оружием. | Включены гарпуны, луки и арбалеты; копья выключены (их механику ведёт OdinRealmFishing). |
| **Stake Tweaks**<br><sub><code>Stake<wbr>Tweaks.<wbr>dll</code></sub><br>[Скачать](https://thunderstore.io/c/valheim/p/TOOLKINGS/Stake_Tweaks/) | TOOLKINGS<br>**S/C** | Баланс колючих кольев и защитных стен. | Урон кольев **×2.5**, прочность кольев и стен **×3**, возврат материалов при разборе. |
| **StarLevelSystem**<br><sub><code>Star<wbr>Level<wbr>System.<wbr>dll</code></sub><br>[Скачать](https://thunderstore.io/c/valheim/p/MidnightMods/StarLevelSystem/) | MidnightMods<br>**S/C** | Повышенные уровни существ и боссов, модификаторы, Nemesis и рейды. | Первичная автоконфигурация: уровни до **3**, Nemesis включён, сброс локаций выключен, множитель спавна **1.1**; дальнейшая настройка отложена. |
| **TopMining**<br><sub><code>Top<wbr>Mining.<wbr>dll</code></sub><br>[Скачать](https://thunderstore.io/c/valheim/p/NexusTransfer/TopMining/) | NexusTransfer (публикация)<br>**S/C** | Упрощает добычу рудных месторождений. | Отдельные правки не зафиксированы. |
| **No Seasonal Restrictions**<br><sub><code>Venture<wbr>Valheim.<wbr>No<wbr>Seasonal<wbr>Restrictions.<wbr>dll</code></sub><br>[Скачать](https://thunderstore.io/c/valheim/p/VentureValheim/No_Seasonal_Restrictions/) | VentureValheim<br>**S/C** | Снимает сезонные ограничения некоторых игровых предметов. | Отдельных пользовательских настроек нет в снимке. |
| **XPortal**<br><sub><code>XPortal.<wbr>dll</code></sub><br>[Скачать](https://thunderstore.io/c/valheim/p/SpikeHimself/XPortal/) | SpikeHimself<br>**S/C** | Улучшенная система выбора и управления порталами. | Индивидуальные правки не зафиксированы; интеграция с BossGate требует проверки. |
| **YamlDotNet — detector**<br><sub><code>Yaml<wbr>Dot<wbr>Net<wbr>Detector.<wbr>dll</code></sub><br>[Скачать](https://thunderstore.io/c/valheim/p/ValheimModding/YamlDotNet/) | ValheimModding (сборка)<br>**S/C** | Вспомогательный модуль обнаружения версии YamlDotNet. | Настройки отсутствуют; устанавливается с пакетом зависимости. |
| **YamlDotNet**<br><sub><code>Yaml<wbr>Dot<wbr>Net.<wbr>dll</code></sub><br>[Скачать](https://thunderstore.io/c/valheim/p/ValheimModding/YamlDotNet/) | Antoine Aubry и соавторы; ValheimModding (пакет)<br>**S/C** | Библиотека чтения YAML-конфигураций других модов. | Настройки отсутствуют. |

### Only Client — необязательные дополнения (7 DLL)

Эти моды каждый игрок устанавливает **только на своём ПК и по желанию**. Для основной сборки они не должны быть необходимы.

| Мод и скачивание | Автор / тип | Описание | Изменения конфига |
|---|---|---|---|
| **PlantEasily**<br><sub><code>Advize_<wbr>Plant<wbr>Easily.<wbr>dll</code></sub><br>[Скачать](https://thunderstore.io/c/valheim/p/Advize/PlantEasily/) | Advize<br>**C** | Посадка растений по сетке, массовая посадка и уборка. | Глобальная клавиша включения отключена; привязка к сетке **F10**. |
| **Better<wbr>Pickup<wbr>Notifications**<br><sub><code>Better<wbr>Pickup<wbr>Notifications.<wbr>dll</code></sub><br>[Скачать](https://thunderstore.io/c/valheim/p/Pfhoenix/BetterPickupNotifications/) | Pfhoenix<br>**C** | Удобные групповые уведомления о подобранных предметах. | Индивидуальные правки не зафиксированы. |
| **Quads Build Orders**<br><sub><code>Build<wbr>Orders.<wbr>dll</code></sub><br>[Скачать](https://thunderstore.io/c/valheim/p/Quads_Lab/Quads_Build_Orders/) | Quads_Lab<br>**C** | Планирование построек и размещение призрачных чертежей. | Планирование **F7**, радиус сборки **24 м**; локально мост: ширина 4, `CoreWood`, `Steps` (Git отличается). |
| **Cartur's Compass and Clock**<br><sub><code>Cartur<wbr>Compass<wbr>And<wbr>Clock.<wbr>dll</code></sub><br>[Скачать](https://thunderstore.io/c/valheim/p/Cartur/Carturs_Compass_and_Clock/) | Cartur<br>**C** | Полоска компаса, метки направления и часы. | Индивидуальные правки не зафиксированы. |
| **ConfigurationManager**<br><sub><code>Configuration<wbr>Manager.<wbr>dll</code></sub><br>[Скачать](https://thunderstore.io/c/valheim/p/shudnal/ConfigurationManager/) | shudnal<br>**C** | Игровой редактор настроек BepInEx и модов. | Индивидуальные правки не зафиксированы. |
| **FirstPersonMode**<br><sub><code>First<wbr>Person<wbr>Mode.<wbr>dll</code></sub><br>[Скачать](https://thunderstore.io/c/valheim/p/Azumatt/FirstPersonMode/) | Azumatt<br>**C** | Вид от первого лица. | Индивидуальные правки не зафиксированы. |
| **GooderAutoShield**<br><sub><code>Gooder<wbr>Auto<wbr>Shield.<wbr>dll</code></sub><br>[Скачать](https://thunderstore.io/c/valheim/p/MainStreetGaming/GooderAutoShield/) | MainStreetGaming (публикация; HumanSandbag)<br>**C** | Автоматическое экипирование подходящего щита. | Индивидуальные правки не зафиксированы; состояние выбранного щита персональное и не публикуется. |


**Новые конфигурации (22.10.2026):** [FiresGhettoNetworking v1.5.65](config/com.Fire.FiresGhettoNetworkMod.cfg) сохранён точно по последней загрузке пользователя; [HipLantern v1.1.14](config/shudnal.HipLantern.cfg) восстановлен из ранее приложенного конфига с согласованными изменениями после скриншота. Фактический текущий файл HipLantern с ПК повторно не присылался. В `FiresGhettoNetworking` оба experimental ownership-переключателя остаются `true` из присланного файла; режим Selective имеет приоритет, полноценная серверная симуляция предназначена для dedicated server.

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
