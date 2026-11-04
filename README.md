Русский · [English](README.en.md)

# Jadlis — глобальный CLAUDE.md

Глобальные инструкции для Claude Code: как агент понимает задачу, делает минимум нужного, проверяет результат и пишет для людей. Это мой рабочий файл, выложенный почти как есть. Из него вырезаны только личные разделы.

```
git clone https://github.com/becyb-org/jadlis-claude-md.git
sh jadlis-claude-md/install.sh --plan
sh jadlis-claude-md/install.sh
```

Если у тебя уже есть свой `~/.claude/CLAUDE.md`, скрипт его не тронет и напишет `DIFFERS`. Сравни дифф из `--plan`. Затем либо перенеси нужные части руками, либо запусти `install.sh --force`: старый файл уйдёт в `.bak-<дата>`.

## Что внутри

| Файл | Куда ложится | Что это |
|---|---|---|
| `CLAUDE.md` | `~/.claude/CLAUDE.md` | глобальные инструкции, читаются в каждой сессии |
| `rules/routing.md` | `~/.claude/rules/routing.md` | какой инструмент брать под какую задачу |
| `rules/bash-gotchas.md` | `~/.claude/rules/bash-gotchas.md` | ловушки, которые срабатывают при сборке команды Bash на macOS |
| `scripts/ste-ru-lint.py` | `~/.claude/scripts/ste-ru-lint.py` | проверка русского текста по правилам письма |

## Какие части тебе нужны

`CLAUDE.md` состоит из частей. Их можно брать по отдельности.

- **Ядро — подходит всем.** Раздел `## Common`, пункты 1–5 и 8: понять задачу и действовать, не усложнять, не выходить за рамки задачи, проверять результат, отвечать коротко и по делу, не останавливаться на очевидном следующем шаге.
- **Язык — поправь под себя.** Пункт 6 требует отвечать по-русски, а код и конфиги писать по-английски.
- **Правила письма — для тех, кто пишет по-русски.** Пункт 7 и раздел «Writing integration»: результат первым, одна мысль в предложении, действительный залог, без канцелярита. Линтеру `ste-ru-lint.py` нужны `uv` и `pymorphy3`: `uv run -q --with pymorphy3 python ~/.claude/scripts/ste-ru-lint.py <файл.md>`.
- **Формат планов — только с `/verif`.** Раздел «Change plans» задаёт заголовки плана, которые разбирает скилл `/verif`. Без него раздел можно убрать.
- **Под мои плагины.** Разделы «Tool routing», «Subagents, Workflow» и файл `rules/routing.md` ссылаются на плагины Jadlis (`/jadlis-search:search`, `/jadlis-browser:browser`) и на Opus 5.5. Без этих плагинов `routing.md` можно не ставить: `install.sh --no-routing`.

Автоматическую проверку текста после каждой записи заметки включает плагин [jadlis-claudecode](https://github.com/becyb-org/jadlis-claudecode): он добавляет хук `ste-ru-lint.py`, если в `CLAUDE.md` есть раздел «Writing for people».

## Установка

`install.sh` копирует файлы в `~/.claude/`. Если задана переменная `CLAUDE_CONFIG_DIR`, скрипт пишет туда.

- `--plan` показывает, что изменится, и ничего не пишет.
- Если файл уже есть и отличается, скрипт его не трогает и печатает `DIFFERS`.
- `--force` заменяет отличающиеся файлы. Старый файл скрипт сначала копирует в `<файл>.bak-<дата>`.
- `--no-routing` пропускает `rules/routing.md`.
- Повторный запуск печатает `UNCHANGED` и ничего не пишет.

Обновить: `git -C jadlis-claude-md pull`, затем `install.sh --plan` и `install.sh --force`.

## Что рядом

- [jadlis-output-styles](https://github.com/becyb-org/jadlis-output-styles) — стили ответа Jadlis и Jadlis Voice. Инструкции из этого файла ссылаются на них.
- [jadlis-claudecode](https://github.com/becyb-org/jadlis-claudecode) — плагин, который собирает Claude Code и терминал: настройки, хуки, строка состояния, tmux, `cld`. Он может поставить этот репо одним шагом.

## Лицензия

Apache-2.0, см. [LICENSE](LICENSE).
