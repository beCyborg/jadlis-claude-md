# Changelog — jadlis-claude-md

Формат: [Keep a Changelog](https://keepachangelog.com/ru/1.1.0/), версии — [SemVer](https://semver.org/lang/ru/).
История до 1.0.0 — в плагине `jadlis-claudecode` 1.0.0–1.3.0 (`assets/CLAUDE.md`, `assets/rules/`).

## [1.0.0] — 2026-11-04 — Отдельный репо / Own repo

### Для человека
- Глобальный `CLAUDE.md`, правила и линтер текста теперь живут в своём репо. Ставятся одной командой `sh install.sh`, без плагина.
- Свой `CLAUDE.md` скрипт не перезаписывает без `--force`. Старый файл уходит в `.bak-<дата>`.
- README объясняет, какие части файла подходят всем, а какие — только с плагинами Jadlis.

### For agents
- Added: `CLAUDE.md`, `rules/routing.md`, `rules/bash-gotchas.md`, `scripts/ste-ru-lint.py` (owner export by `jadlis-claudecode/tools/export-owner.py`).
- Added: `install.sh [--plan] [--force] [--no-routing]` → `${CLAUDE_CONFIG_DIR:-$HOME/.claude}`; DIFFERS without `--force`, backup on replace, `UNCHANGED` on a second run.
