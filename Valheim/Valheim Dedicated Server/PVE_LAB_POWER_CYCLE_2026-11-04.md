# PVE-LAB → Valheim Dedicated Server — цикл питания

**Зафиксировано:** 2026-11-04, пользовательский вывод терминала `vspadmin@pve-lab` (локальная отметка 03:42–03:43; часовой пояс терминала [Needs confirmation]).

## Подтверждённый снимок VM до запуска

```text
VMID  NAME                    STATUS   MEM(MB)  BOOTDISK(GB)  PID
9000  tpl-debian13-cloudinit  stopped  2048     11.00         0
9001  valheim-server          stopped  12288    20.00         0
```

Команда `sudo qm start 9001` выполнена. В ответе: `generating cloud-init ISO`, затем возвращено приглашение оболочки без показанной ошибки. **Результат `qm status 9001` после старта не предоставлен.** Запуск VM запрошен, но статус `running`, запуск Docker и готовность игры этим фрагментом не доказаны.

## Согласованный порядок ручного жизненного цикла

```text
ПУСК:
  1. Включить PVE-LAB (физический хост).
  2. Разблокировать PVE-LAB (способ разблокировки [Needs confirmation]).
  3. Запустить гостевую VM 9001 «valheim-server» на Proxmox.
  4. Проверить подключение /srv/valheim и запустить Docker/Compose
     с Valheim Dedicated Server — только если не запустились автоматически.
  5. Проверить загрузку игры и доступность для игроков.

ОСТАНОВКА:
  1. Уведомить игроков и дождаться выхода.
  2. Корректно остановить Valheim в Docker с ожиданием сохранения.
  3. Убедиться, что процессы игры завершены.
  4. Корректно выключить гостевую VM 9001 и дождаться stopped.
  5. Выключить PVE-LAB.
```

**Терминология:** пользователь назвал шаг 3 «запустить vsp-server», но в подтверждённом `qm list` VM называется `valheim-server` и имеет VMID `9001`. Отдельный объект `vsp-server` этим выводом не подтверждён.

## Проверки (без изменений)

На **PVE-LAB**:

```bash
sudo qm list
sudo qm status 9001
```

В **гостевой VM 9001**, после её запуска:

```bash
findmnt /srv/valheim
sudo systemctl is-active docker
sudo docker ps --format 'table {{.Names}}\t{{.Status}}'
sudo docker exec valheim-server supervisorctl status
```

Проверки Docker выполнять только при запущенном контейнере. Если `findmnt /srv/valheim` не подтверждает отдельный диск, **контейнер не запускать**: опасность записи данных на системный диск.

## Изменяющие действия (ручное выполнение после проверки)

На **PVE-LAB**, если VM ещё не запущена:

```bash
sudo qm start 9001
```

В **гостевой VM**, если Docker уже активен и контейнер не поднялся автоматически:

```bash
cd /srv/valheim/compose
sudo docker compose up -d valheim
```

Остановка игры в **гостевой VM** после выхода игроков:

```bash
cd /srv/valheim/compose
sudo docker compose stop -t 120 valheim
```

Затем на **PVE-LAB** выполнить штатную остановку гостя и **проверить stopped**, прежде чем выключать хост. Принудительное завершение `qm stop`, `docker kill` и выключение физического PVE во время работы игры не являются штатным путём. Конкретная команда физического питания/разблокировки PVE-LAB **[Needs confirmation]**.

## Acceptance и rollback

- **START PASS:** VM 9001 `running`; `/srv/valheim` смонтирован; Docker активен; supervisor показывает игровой процесс `RUNNING`; лог подтверждает Steam-сервер; игрок может войти.
- **STOP PASS:** контейнер завершил работу без ошибок сохранения; VM 9001 `stopped`; только потом PVE-LAB выключен.
- **При сбое пуска:** не повторять слепо `compose up`; сохранить логи, проверить диск/контейнер/состояние VM. Не менять миры/моды/Compose автоматически.
- **При сбое остановки:** не обрывать питание; выяснить состояние записи мира и сделать штатный shutdown.

См. [ADMIN_GUIDE.md](ADMIN_GUIDE.md) для Docker, данных мира, backup и rollback.
