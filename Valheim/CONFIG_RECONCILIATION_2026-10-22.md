# VSP Gamer — сведение проблемных конфигураций (22.10.2026)

**Основа сравнения:** локальный архив пользователя `Архив.zip` от 22.10.2026 и актуальный `main` репозитория после [первого аудита](LOCAL_SNAPSHOT_AUDIT_2026-10-22.md). Это **обновление после снимка**, а не описание неизменённого локального ПК. На компьютер пользователя Git-коммиты не применяются автоматически.

## Реально изменено в Git

| Файл | Было в ZIP | Стало в Git | Причина |
|---|---|---|---|
| `org.bepinex.plugins.solid-hitboxes.cfg` | `EnableFriendlyFire=false` | **`true`** | Прямое решение пользователя: включить friendly fire NPC |
| `com.quad.aicompanion.cfg` | `MenuKey=J` | **`L`** | `J` занят EpicLoot Ability Hotkey 3 |
| `com.quad.aicompanion.cfg` | `CommandKey=H` | **`K`** | `H` занят HipLantern и EpicLoot Ability Hotkey 2 |
| `com.quad.partyhud.cfg` | `ToggleKey=F8` | **`F4`** | `F8` — ForsakenPowersPlusRemastered; промежуточная F11 также занята Build Orders (`ImportKey`) |
| `EpicLoot/baseconfig/adventuredata.json` | есть `HipLantern` с ценой 400 | внесено в Git | Вернули локальную дополнительную цену азартного приобретения |
| `EpicLoot/baseconfig/iteminfo.json` | `HipLantern` после `defeated_gdking` | внесено в Git | Сохранили пользовательский boss gate |
| `EpicLoot/baseconfig/loottables.json` | `HipLantern` в Tier2Tools, инструменты редкие | внесено в Git | Сохранили редкий дроп `Tier0/1/2/3/6Tools`: вес **0.1** вместо 1 |

**Важно про SolidHitboxes:** `FriendlyFireDamageModifier=1` оставлен; если игра применяет friendly fire — множитель полный. `LockConfig=true` сохранён. Поведение в отношении Татьяны и других NPC проверить в тестовом мире.

**Три JSON EpicLoot теперь совпадают с присланным ZIP побайтово**, проверено совпадение Git blob SHA-1:
- `adventuredata.json`: `f058920fa2704b3c6a9c158c3dbe5689a6446f8b`
- `iteminfo.json`: `d21db1a4c70fc8da7da9a44fe791f5a08000808b`
- `loottables.json`: `818efa1b4ced1446086a9389e792986e4e6c8f46`

**Три изменённых CFG**, относящихся только к новым исправлениям, сверены с ZIP-патчем по Git blob SHA-1:
- SolidHitboxes: `0602e5c63fd62b015befe089c11b8da68ed9ea64`
- Quads Companion: `5e22f5995a0554e579c2f7a5854014288eeb0787`
- Party HUD: `d3cd3c36aac2043b0d4f1c767b5562bf3f5b8998`

## Что сравнили, но не меняли

- **HipLantern v1.1.14:** 47 активных конфигурационных записей одинаковы в локальном ZIP и Git; различается служебное форматирование/комментарии. Клавиша `H` остаётся для фонаря.
- **FiresGhettoNetworking:** 126 активных записей одинаковы; `Enable Server-Side Simulation=true`, общий `ZDO Ownership Transfer=false`, `Selective=true`. Различается текстовый файл, не активные параметры.
- **BlindCartographer:** одинаковые пять активных параметров: `ModEnabled=true`, карта на столе включена, `Left Alt + Y` для метки. В ZIP конфиг помечен **v1.0.2**, а Git-заготовка помечена **v1.0.3**; это **не проверка установленной DLL**. Временно не меняли конфигурацию, её функции совпадают. Возможное пересечение `Y` с FetchKey BuildOrders проверить в игре: первая требует Alt, вторая — нет.
- **Quads Build Orders:** `F9` занят `ToggleGhostsKey`, поэтому его сознательно не назначали на HUD. `F7` — планирование построек, `F10` — PlantEasily, `F11` — импорт планов и чертежей Build Orders, `F6` — автопосадка PlantEasily. В сохранённых CFG `L`, `K`, `F4` свободны; это не исключает пользовательских горячих клавиш вне Git.
- **Действующий `RaidSettings.yaml` и MonsterLabZ** оставлены в прежнем состоянии. Концепт `MonsterLabzReid` отдельно, новый рейд не создавался.
- **KeepCharacterEffects:** в ZIP не было его конфигурации и DLL; подтвердить установку по `BepInEx/plugins` / логам.

## Локальное применение

На хосте `vsp-pc` после **выхода из игры** сделать резервные копии трёх изменённых CFG, затем распаковать патч из ответа ChatGPT прямо в:

```text
/mnt/steam/SteamLibrary/steamapps/common/Valheim/BepInEx/config/
```

Патч содержит только:
```text
org.bepinex.plugins.solid-hitboxes.cfg
com.quad.aicompanion.cfg
com.quad.partyhud.cfg
```

**Не применять к ПК автоматически** и не заменять три JSON EpicLoot: они уже настроены локально как нужно, правки были только в Git. Для друзей (при установке Companion, Bounty Board) значения, синхронизируемые хостом, берутся от хоста; клиентские хоткеи настраиваются отдельно.

После запуска проверить `BepInEx/LogOutput.log`, меню NPC, приказы, переключение HUD, способность EpicLoot, фонарь и силу Отрёкшихся; дружеский урон NPC тестировать в копии мира. Не публиковать игровые сохранения и пользовательские данные.

## Не доказано

- Что все DLL и совместимые версии действительно установлены у трёх участников.
- Что Quads корректно распознаёт женскую модель и выбранное имя «Татьяна».
- Что NPC friendly fire не влияет на приручённых существ или компаньона при данных настройках (зависит от NPC faction).
- Что игра и другие программы не используют F4; проверка в игре нужна.

См. [README](README.md), [AI-компаньон](AI_COMPANION_CONCEPT.md), [общее правило распространения](DEPLOYMENT_POLICY_2026-10-21.md).
