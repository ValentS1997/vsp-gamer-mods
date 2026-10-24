# Valheim — Building mods: test selection and saved candidates (2026-10-24)

> **LATEST GLOBAL COUNT (24.10.2026):** After retiring `ProjectileTweaks.dll` and reclassifying Quads Quiver as client-only, target now **44 S/C + 11 C = 55 chosen DLL**; the older 46+10=56 and 47+10=57 totals below are historical. [Archery decision](ARCHERY_QUIVER_ONLY_2026-10-24.md). MissingPieces still test-only and not included. No local installation implied.

> **CURRENT GLOBAL DLL COUNT UPDATE (24.10.2026):** With Quads Bounty Board retired after this earlier building-mod selection, core target is now **46 S/C + 10 client-only = 56 DLL**, not the **47+10=57** shown below in historical accounting sections. MissingPieces remains test-only (not promoted), Cartur's Flooring / Sinka / BronzeAgeChest still candidates. See [latest decision](SLS_VANILLA_RAIDS_AND_BOUNTY_RETIREMENT_2026-10-24.md). The rest of this test audit remains unchanged.

This file records the **latest explicit user decision** and overrides older pending-mod notes. Scope: Valheim 1.0.20, native Linux, 3 human players, P2P host. User-reported installation is **not** proof of runtime DLL metadata or installation on all three peers.

## Результат 25.10.2026 — Comfy Gizmo прошёл тест, Cartur's Flooring исключён

Пользователь подтвердил **успешный тест Gizmo для работы с оригинальными строительными деталями**, включая эксперимент с плоской крышей. `ComfyGizmo.dll` **оставить постоянно в строительном профиле администратора** (категория `!!`; в последнем `ls -la` DLL присутствует). **Не делать обязательным для друзей** только из-за инструмента поворота: уже построенные детали должны использовать исходные prefab, однако необходим отдельный runtime-тест у друзей на синхронизацию и отсутствие ошибок. Мод может быть установлен постоянно у администратора, не создавая новые prefab ID для этих повернутых vanilla-элементов.

`CarturFlooring.dll` **исключить** из основного S/C-модпака; на ПК пользователя физически переместить в архив вне `BepInEx/plugins/` или удалить вручную после остановки игры. Для актуальной версии манифеста считать **44 обязательных S/C + 10 клиентских = 54**, плюс 1 постоянный админский Gizmo = **55 отобранных DLL в профилях**. Снимок `ls -la` 25.10.2026 до переноса включает 59 физических DLL (и `ropesnap.wav`, `Translations/`), поэтому планы и фактическое состояние диска нельзя смешивать.

**Обслуживание Linux BepInEx:** DLL можно разложить по `plugins/00-Libraries`, `01-CGM`, `02-Gameplay`, `03-Building`, `04-Client`, `05-Admin`; исходные имена сохранять, библиотеки переносить после теста загрузки обычных модов. Соседние файлы `ropesnap.wav` и `Translations/` не переносить автоматически. Git не означает, что пользователь уже выполнил команды на игровом ПК.

## Проверено пользователем 24.10.2026 — мосты Quads Build Orders сохраняются без DLL

**Правильная атрибуция — Quads Build Orders (`BuildOrders.dll`), НЕ PlanBuild.** Пользователь построил округлённые/арочные мосты через инструмент Bridge в BuildOrders, затем отключил мод и наблюдал, что **построенные мосты сохранились в мире**. Это **пользовательский локальный тест**, не полная гарантия для всех вариантов моста, обновлений игры или иной модификации объектов.

Причина, подтверждённая [исходным кодом BuildOrders](https://github.com/HardHeadHackerHead/valheim-mods/blob/main/mods/BuildOrders/Plugin.BridgeDesign.cs): генератор мостов собирает конструкцию из **стандартных Valheim prefab** (`wood_floor`, `wood_beam`, `wood_pole`, `wood_roof` и др.) с разными позициями и углами (`Quaternion.Euler`); отдельная уникальная 3D-модель моста для построенных частей не требуется. Арочная форма — комбинация обычных деталей под наклоном, а **не изменение сетки (mesh) одного prefab**. Поэтому результат может переживать удаление строительного инструмента. Ghost-планы/меню инструмента, в отличие от уже построенных стандартных деталей, не обязательно сохранят функциональность после удаления DLL.

**Исследование плоской крыши:** попробовать повернуть оригинальный `wood_roof` или `darkwood_roof` по дополнительной оси до горизонтального положения с помощью временного инструмента 3D-поворота, например [ComfyMods Gizmo](https://thunderstore.io/c/valheim/p/ComfyMods/Gizmo/). Использование исходного prefab с сохранёнными position/rotation безопаснее постоянной зависимости от новых `roof_wood_2m` prefab MissingPieces. Это **не утверждение, что крыша прошла тест**: на КОПИИ мира проверить ориентацию, стыки, опоры, `Shelter`/защиту от дождя, сохранение после перезагрузки и после отключения поворотного мода; вход второго игрока без этого мода. Не путать изменение `Transform.rotation` со `MeshFilter.mesh` или принудительным масштабированием: последнее обычно требует runtime-мода и откатывается при его отсутствии.

**Политика VSP Gamer:** отдавать предпочтение модам-инструментам, создающим/расставляющим **vanilla-prefab**, а не добавляющим новые строительные prefab ID. `MissingPieces` не переводить в базовую сборку: после отключения пользователь наблюдал исчезновение его уникальных строительных элементов. `BuildOrders.dll*` остаётся временным строительным инструментом; факт сохранности округлённых мостов относится именно к нему, не к PlanBuild. Никаких CFG, DLL, настроек мира этим документированием не изменяется.

## Latest decision: MissingPieces test

- **[BentoG / MissingPieces](https://thunderstore.io/c/valheim/p/BentoG/MissingPieces/)** — **USER SELECTED FOR TESTING**, reference version **2.3.2** (previously researched, recheck before download).
- It has separate flat roof prefab IDs `roof_wood_2m`, `roof_darkwood_2m` and independent chest/drawer prefab `piece_chest_wooden_drawer`. Reported default crafting costs: roof wood 2 Wood; darkwood 2 Wood + 1 Tar; drawer 10 FineWood + 2 Iron + 1 Coal.
- **Not yet confirmed installed or successfully used.** Stage as a test-only addition; **do not silently mark it as part of the 57-DLL baseline** until the user approves promotion after tests. Intended shared S/C deployment on P2P host and both friends because it adds persistent construction prefab objects.
- Before test: backup world `.db` and `.fwl` plus characters; use a cloned world; check DLL dependencies, all-peer consistency, piece durability and roof rain cover, saves/reloads, drawer access, inventory persistence and PlanBuild blueprint capture/direct-build behavior.
- Removing a prefab mod from a world containing its pieces carries object/item loss risk.

## Save as candidates — not selected, no CFG or DLL changes

| Candidate | Link | Notes |
|---|---|---|
| Cartur's Flooring | https://thunderstore.io/c/valheim/p/Cartur/Carturs_Flooring/ | Existing floors act as rain-cover roofs; previous research version 1.1.4; client presence on all participating peers should be tested |
| Sinka | https://thunderstore.io/c/valheim/p/Ezomic/Sinka/ | Snapping and vertical stacking of containers; previous research version 1.3.1; when StackContainers enabled, all peers must install to avoid destruction through unsupported-piece calculations |
| BronzeAgeChest | https://thunderstore.io/c/valheim/p/probablykory/BronzeAgeChest/ | Separate `piece_chest_bronze`, 15 slots in prior research; configurable recipe, not a high-capacity chest; previous research version 1.0.8 |

**MissingPiecesFix** (https://thunderstore.io/c/valheim/p/lhoffl_MissingPiecesFix/MissingPiecesFix/) — historical fork/link from the user's earlier candidate selection. **Not selected for test and should not be installed alongside BentoG MissingPieces**; earlier research marked this fork deprecated.

## Existing selected mods — user-reported installation update

- **PlanBuild** — USER REPORTED INSTALLED on their Valheim setup (2026-10-24); attached configuration is `config/marcopogo.PlanBuild.cfg` with header `PlanBuild v0.20.0`. BepInEx runtime plugin version, error-free load, and both friends' installations are **UNVERIFIED**. Already counted among the baseline 47 S/C — no additional count.
- **ModularLadders** — USER REPORTED INSTALLED (2026-10-24); DLL version and full peer deployment **UNVERIFIED**. Already counted among the baseline 47 S/C — no additional count.
- **PlanBuild CFG options** from attachment: `Default build mode = Planned`, `Allow direct build = false` (admins exempt), `Allow terrain tools = false`, `Allow blueprint rune = true`, `Save directory = BepInEx/config/PlanBuild/blueprints`, `Blueprint Marketplace GUI toggle key = End`, `Toggle = Q`, `Mirror = H`.
- **Potential key collisions**: PlanBuild Mirror = `H` overlaps existing HipLantern toggle `H` and EpicLoot ability 2 `H`; test in-game, rebind deliberately if simultaneous handling occurs. `Q` may overlap vanilla auto-run; contextual behavior not tested.
- Copy of the CFG is a snapshot of the supplied configuration file, **not proof of successful plugin loading**. No CFG settings were altered for this documentation task.

## DLL accounting

- **Existing baseline unchanged:** 47 S/C + 10 Only Client = **57 selected active DLL**, plus disabled DigDug = 58 accounted.
- **1 separately selected test candidate:** MissingPieces; if and only if user later promotes it to the active mandatory bundle and it adds one DLL, then 48 S/C + 10 client = 58 selected active DLL.
- **3 saved pending candidates:** Cartur's Flooring, Sinka, BronzeAgeChest. None counted.
- No mod installation, world files, player data, or private saves are modified by this Git documentation update.
