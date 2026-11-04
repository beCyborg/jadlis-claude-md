English · [Русский](README.md)

# Jadlis — global CLAUDE.md

Global instructions for Claude Code: how the agent understands a task, does the minimum needed, verifies the result and writes for people. This is my working file, published almost as is. Only the personal sections are cut out.

```
git clone https://github.com/becyb-org/jadlis-claude-md.git
sh jadlis-claude-md/install.sh --plan
sh jadlis-claude-md/install.sh
```

If you already have your own `~/.claude/CLAUDE.md`, the script leaves it alone and prints `DIFFERS`. Compare the diff from `--plan`. Then either move the parts you want by hand, or run `install.sh --force`: the old file goes to `.bak-<date>`.

## What is inside

| File | Goes to | What it is |
|---|---|---|
| `CLAUDE.md` | `~/.claude/CLAUDE.md` | global instructions, read in every session |
| `rules/routing.md` | `~/.claude/rules/routing.md` | which tool to use for which task |
| `rules/bash-gotchas.md` | `~/.claude/rules/bash-gotchas.md` | traps that fire while composing a Bash command on macOS |
| `scripts/ste-ru-lint.py` | `~/.claude/scripts/ste-ru-lint.py` | checks Russian text against the writing rules |

## Which parts you need

`CLAUDE.md` is made of parts. You can take them separately.

- **Core — fits everyone.** The `## Common` section, items 1–5 and 8: understand the task and act, keep it simple, stay inside the task, verify the result, answer short and to the point, don't stop on an obvious next step.
- **Language — adjust it.** Item 6 asks for answers in Russian and for code and config in English.
- **Writing rules — for those who write in Russian.** Item 7 and the «Writing integration» section: result first, one idea per sentence, active voice, no bureaucratese. The `ste-ru-lint.py` linter needs `uv` and `pymorphy3`: `uv run -q --with pymorphy3 python ~/.claude/scripts/ste-ru-lint.py <file.md>`.
- **Plan format — only with `/verif`.** The «Change plans» section sets the plan headings that the `/verif` skill parses. Without that skill you can drop the section.
- **Tied to my plugins.** The «Tool routing» and «Subagents, Workflow» sections and `rules/routing.md` point at Jadlis plugins (`/jadlis-search:search`, `/jadlis-browser:browser`) and at Opus 5.5. Without those plugins you can skip `routing.md`: `install.sh --no-routing`.

The automatic text check after every note write comes from the [jadlis-claudecode](https://github.com/becyb-org/jadlis-claudecode) plugin: it adds the `ste-ru-lint.py` hook when `CLAUDE.md` has a «Writing for people» section.

## Install

`install.sh` copies the files into `~/.claude/`. If `CLAUDE_CONFIG_DIR` is set, it writes there.

- `--plan` shows what would change and writes nothing.
- If a file already exists and differs, the script leaves it alone and prints `DIFFERS`.
- `--force` replaces the files that differ. The script first copies the old file to `<file>.bak-<date>`.
- `--no-routing` skips `rules/routing.md`.
- A second run prints `UNCHANGED` and writes nothing.

Update: `git -C jadlis-claude-md pull`, then `install.sh --plan` and `install.sh --force`.

## Related

- [jadlis-output-styles](https://github.com/becyb-org/jadlis-output-styles) — the Jadlis and Jadlis Voice answer styles. The instructions in this file refer to them.
- [jadlis-claudecode](https://github.com/becyb-org/jadlis-claudecode) — a plugin that sets up Claude Code and the terminal: settings, hooks, status line, tmux, `cld`. It can install this repo as one step.

## License

Apache-2.0, see [LICENSE](LICENSE).
