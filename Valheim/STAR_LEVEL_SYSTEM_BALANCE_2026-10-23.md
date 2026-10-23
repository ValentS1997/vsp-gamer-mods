# Valheim — StarLevelSystem: возвращение редких звёзд (23.10.2026)

**Статус:** точечная настройка **Git-baseline** от 23.10.2026. Не утверждает, что файлы скопированы на игровой хост `vsp-pc` или что проведён игровой тест. Источники: пользовательский отзыв о слишком частых звёздах, дальнем юге и избытке добычи; исходники SLS `LevelSelection.cs`, `LevelSystemData.cs`, `WorldRates.cs` (MidnightsFX/Valheim_Star_Levels_Expanded).

## Проблема

В старом конфиге параллельно действовали: `EnableDistanceLevelScalingBonus=true`, `EnableDistanceLevelBonus=true`, `EnableZoneScalingBonus=true`, `EnableConditionalCreatureLevelupChance=true`, биомные лимиты/минимумы после боссов, ночной множитель 1.5 и `DefaultLevelupGenerators` (который **перезаписывал** ручную таблицу звёзд). В `LootSettings.yaml` был `EnableDistanceLootModifier=true`, добавляющий количество добычи до +35% далеко от центра. В `BiomeConfiguration.All` `SpawnRateModifier=1.1` создавал дополнительные спавны.

## Изменено в Git

| Файл | Параметр | Было → стало | Зачем |
|---|---|---|---|
| `config/MidnightsFX.StarLevelSystem.cfg` | `EnableDistanceLevelScalingBonus` | `true` → **`false`** | Не повышать звёзды к внешним кольцам мира |
| То же | `EnableZoneScalingBonus` | `true` → **`false`** | Не повышать звёзды локальными территориальными зонами убийств |
| То же | `OffspringCanBeStrongerThanParents` | `false` → **`true`** | Синхронизировать в Git ранее одобренное локальное разведение; шанс 5% уже был задан |
| `config/StarLevelSystem/LevelSettings.yaml` | `EnableDistanceLevelBonus` | `true` → **`false`** | Второй выключатель кольцевых бонусов |
| То же | `EnableConditionalCreatureLevelupChance` | `true` → **`false`** | Убрать принудительный рост минимальных уровней существ после убийства боссов |
| То же | `DefaultLevelupGenerators` | генератор Exponential 0.4 → **`[]`** | Использовать явную таблицу уровней, а не генератор |
| То же | `BiomeConfiguration` | разные `BiomeMaxLevelOverride` и бонусы расстояния → **удалены** | Все обычные биомы под общим `MaxLevel=3` |
| То же | `BiomeConfiguration.All.SpawnRateModifier` | `1.1` → **`1.0`** | Убрать дополнительные спавны SLS |
| То же | `NightLevelUpChanceScaler` | `1.5` → **`1.0`** | Ночью не повышать вероятность звёзд |
| То же | `CreatureConfiguration.dhack_companion` | отсутствовал в Git → **0★ / размер 0.85 / SizePerLevel 0** | Сохранить протестированный локально фикс Quads Companion |
| `config/StarLevelSystem/LootSettings.yaml` | `EnableDistanceLootModifier` | `true` → **`false`** | Убрать бонус добычи за удалённость |

**Новая таблица для обычных существ**, где ключ — **внутренний уровень** SLS, а не число звёзд:

```yaml
DefaultCreatureLevelUpChance:
  1: 10
  2: 1
  3: 0.05
  4: 0
DefaultLevelupGenerators: []
EnableDistanceLevelBonus: false
EnableConditionalCreatureLevelupChance: false
```

### Ожидаемая доля новых обычных существ

SLS использует один roll 0..100: ближайший порог останавливает выбор уровня; `MaxLevel=3` задаёт потолок **трёх звёзд** (внутренний `Character.m_level=4`). Вероятности рассчитаны по `LevelSelection.DetermineLevelRollResult`, **без кастомных уровней рейда/немезиса/внешних спавнеров**:

| Звёзд | Normal Combat (×1) | Very Hard Combat (×1.4) |
|---|---:|---:|
| 0★ | 90% | **86%** |
| 1★ | 9% | **12.6%** |
| 2★ | 0.95% | **1.33%** |
| 3★ | 0.05% (1/2000) | **0.07%** (1/1429) |

В текущем мире пользователь выбирал Very Hard. Это настройка мира, не SLS: Valheim повышает `EnemyLevelUpRate` до 140%; SLS умножает на это число пороги. Отдельные рейдовые/боссовые `LevelupGenerators`, прямые `CreatureConfiguration` и модовые спавнеры могут переопределять эти вероятности. Точность долей проверяется в игре; статистическая выборка на 10–20 монстрах нерепрезентативна.

## Оставлено без изменений

- `MaxLevel=3`, `MaxBossLevel=3`; отдельная кривая боссов сохранена.
- `OverlevedCreaturesGetRerolledOnLoad=true` корректирует существ **только выше потолка**; существ с 0–3★, уже записанных в мир, автоматически не перебрасывает. Для питомцев `OverLevelTamesGetRerolledOnLoad=false`, чтобы не лишать заработанных при разведении звёзд.
- `OffspringGainExtraLevelChance=0.05` и `OffspringCanBeStrongerThanParents=true`.
- `EnableCreatureScalingPerLevel`, цвета, Nemesis, рейд `RaidSettings.yaml`, `LocationReset` (выключен), прочие лут-таблицы.
- `PerLevelLootScale=1` и `LootDropCalculationType=PerLevel`: SLS продолжает давать дополнительный обычный лут за звёзды, но **без бонуса расстояния**. `EpicLoot` `Legendary` / ×0.3 и три JSON не менялись.
- Механика вражды разных NPC и `SolidHitboxes.EnableFriendlyFire=true` **не менялись**. Мобы продолжат убивать друг друга и могут оставлять магические предметы — SLS-патч устраняет причины аномальных звёзд и бонуса расстояния, но **не запрещает магический дроп при NPC-vs-NPC**.
- Многословные неиспользуемые словари `DistanceLevelBonus` и `ConditionalCreatureLevelupChance` оставлены в YAML намеренно как **отключённые данные**, чтобы сохранить возможность отката и не затронуть другие ссылки. Сами системы выключены соответствующими флагами.

## Проверка и применение

1. **Перед изменением реального мира** завершить Valheim, сделать резервные копии мира (`.db` и `.fwl` или Steam Cloud-эквивалента), файлов `MidnightsFX.StarLevelSystem.cfg`, `StarLevelSystem/LevelSettings.yaml` и `StarLevelSystem/LootSettings.yaml`. На игровом ПК эти файлы могут быть новее Git.
2. Перенести **только** эти три файла с Git или вручную сверить ключи; не заменять целиком `BepInEx/config/`, не трогать `RaidSettings.yaml` и SavedData. Изменение `dhack_companion` и наследования звёзд учтено в Git, чтобы при переносе не потерять локальные успехи.
3. Запустить копию мира, пройти несколько зон от центра до дальних равнин/туманных земель, сравнить новые спавны. Убедиться, что не появляется большое число существ со звёздами, а 3★ остаются крайне редкими. Отдельно проверить сохранность и внешний вид компаньона, приручённых животных, рейдов и дропа EpicLoot.
4. Существующие 1–3★ останутся в мире до обычного исчезновения/убийства: флаг автоматической корректировки действует только на уровни **выше 3★**. Не удалять всех существ через глобальные команды в действующем мире ради статистики.
5. Если магических предметов от сражений NPC по-прежнему много, расследовать отдельно параметры **EpicLoot** и включённый дружественный огонь **SolidHitboxes**. Не отключать последний без пользовательского решения.

[Основная таблица модов](README.md) · [предыдущее состояние SLS](STAR_LEVEL_SYSTEM_2026-10-21.md)
