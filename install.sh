#!/bin/sh
# install.sh — copy the Jadlis global instructions into Claude Code.
#
# Copies into ${CLAUDE_CONFIG_DIR:-$HOME/.claude}:
#   CLAUDE.md, rules/routing.md, rules/bash-gotchas.md, scripts/ste-ru-lint.py (chmod +x).
# A file that already exists and differs is left alone and reported as DIFFERS;
# --force replaces it after a copy to <file>.bak-<date>. A second run prints UNCHANGED.
#
# Usage: sh install.sh [--plan] [--force] [--no-routing]
#   --plan        show what would change (with a diff), write nothing
#   --force       replace files that differ (old file → .bak-<date>)
#   --no-routing  skip rules/routing.md (it routes to Jadlis plugins)
set -eu

HERE=$(cd "$(dirname "$0")" && pwd)
DEST="${CLAUDE_CONFIG_DIR:-$HOME/.claude}"
MODE=apply
FORCE=0
ROUTING=1

while [ $# -gt 0 ]; do
	case "$1" in
		--plan)       MODE=plan; shift ;;
		--force)      FORCE=1; shift ;;
		--no-routing) ROUTING=0; shift ;;
		-h|--help) sed -n '2,13p' "$0" | sed 's/^# \{0,1\}//'; exit 0 ;;
		*) printf 'install.sh: unknown option %s\n' "$1" >&2; exit 2 ;;
	esac
done

DIFFERS=0

place() {   # $1 path relative to repo and to $DEST, $2 exec (1|0)
	src="$HERE/$1"
	dst="$DEST/$1"
	[ -f "$src" ] || { printf '%s=MISSING-SOURCE\n' "$1"; return 0; }
	if [ -f "$dst" ] && cmp -s "$src" "$dst"; then
		printf '%s=UNCHANGED\n' "$1"
	elif [ -f "$dst" ] && [ "$FORCE" = 0 ]; then
		printf '%s=DIFFERS (kept; --force replaces it)\n' "$1"
		[ "$MODE" = plan ] && { diff -u "$dst" "$src" | sed -e "1s|.*|--- installed $1|" -e "2s|.*|+++ new $1|" || true; }
		DIFFERS=$((DIFFERS + 1))
	elif [ "$MODE" = plan ]; then
		if [ -f "$dst" ]; then
			printf '%s=WOULD-REPLACE (old file → .bak)\n' "$1"
			diff -u "$dst" "$src" | sed -e "1s|.*|--- installed $1|" -e "2s|.*|+++ new $1|" || true
		else
			printf '%s=WOULD-WRITE\n' "$1"
		fi
	else
		mkdir -p "$(dirname "$dst")"
		if [ -f "$dst" ]; then
			bak="$dst.bak-$(date +%Y%m%d-%H%M%S)"
			cp "$dst" "$bak"
			printf '%s.backup=%s\n' "$1" "$bak"
		fi
		cp "$src" "$dst"
		printf '%s=WRITTEN\n' "$1"
	fi
	if [ "$2" = 1 ] && [ "$MODE" != plan ] && [ -f "$dst" ]; then chmod +x "$dst"; fi
	return 0
}

place CLAUDE.md 0
[ "$ROUTING" = 1 ] && place rules/routing.md 0
place rules/bash-gotchas.md 0
place scripts/ste-ru-lint.py 1

printf 'claude_md.path=%s\n' "$DEST"
printf 'claude_md.differs=%s\n' "$DIFFERS"
exit 0
