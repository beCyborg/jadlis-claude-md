# Tool routing (one line per intent; details live in the named skill body)

- Vault semantic search (`Знания/`) → MCP `qmd` `query`, payload form only — exact payload and rules in `Jadlis/CLAUDE.md § Semantic search`. Exact string/path → `rg -uu -F` (`-uul` for file names).
- Library/SDK docs → Context7 MCP.
- PDF → `pdf-fetch.sh` from jadlis-search, then Read (path and escalation → /jadlis-search:search body); its hook blocks Firecrawl on PDF URLs (billed per page).
- Scrape one page / site map / multi-URL extract → Firecrawl scrape / map / extract (via local key rotator; details → /jadlis-search:search body).
- GitHub → `gh` / `gh api`: commit/push/PR → `/commit-commands:*`; PR review → `/code-review` (ultra for cloud). Never scrape GitHub via Brave.
- Logged-in browser / interactive web UI → /jadlis-browser:browser (Playwright MCP). Not for public scraping (→ Firecrawl).
- Native macOS apps, cross-app desktop → /jadlis-computer-use:computer-use, LAST resort: app MCP/CLI/API → /jadlis-browser:browser (web) → computer-use. Web tasks never via computer-use; terminal → Bash.
