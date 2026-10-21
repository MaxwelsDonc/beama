# Beama

A warm, editorial-style Beamer theme for academic talks — 16:9, XeLaTeX,
CJK fonts bundled — plus an **agent-native workflow**: tell your coding agent
"make me a talk about X" and it scaffolds, builds, and overflow-checks the deck.
The agent playbook is [AGENTS.md](AGENTS.md), the repo's entry document.

Anthropic 风格学术汇报 beamer 主题：暖米白底 + 陶土橙单强调，衬线标题 +
无衬线正文，断言式帧标题。对 agent 说一句"帮我做个关于 X 的汇报"即可走完全流程。

## Quick start

```bash
./scripts/new_talk.sh 2026-11-my-talk        # scaffold talks/2026-11-my-talk/
# edit talks/2026-11-my-talk/main.tex: replace metadata, write frames
./scripts/build.sh talks/2026-11-my-talk     # build + text-overflow check
./scripts/preview.sh talks/2026-11-my-talk   # render per-page preview PNGs
```

Dependencies: TeX Live (`xelatex` + `latexmk`) and `python3` + PyMuPDF
(`pip install pymupdf`).

Regression build (no args, builds the skeleton):

```bash
./scripts/build.sh
```

## Layout

| path | what |
|---|---|
| `theme/` | the Beamer theme — `\usetheme{beama}` |
| `fonts/` | bundled CJK fonts (Source Han Sans/Serif SC, SIL OFL 1.1) |
| `talks/_template/` | scaffold skeleton: every page type + writing notes |
| `scripts/` | `new_talk.sh` / `build.sh` / `preview.sh` / `check_overflow.py` |
| `docs/design-spec.md` | design rationale |
| `docs/reference/findings.md` | design-pattern teardown of 6 benchmark decks |
| `AGENTS.md` | the agent-facing playbook (repo entry point) |

## Design

Warm ivory background (`#FAF9F5`), a single clay-orange accent (`#D97757`,
at most one per page), serif headlines + sans body, assertion-style frame
titles, one takeaway per page. The visual language itself is named **Clay**
— inspired by Anthropic's brand style, unofficial and not affiliated.
Component cheatsheet (`\card`, `\stepmark`,
`aacallout`, `\fullfig`, `\figpair`, frozen TikZ styles, …): see AGENTS.md.

## License

- Theme, scripts, docs: [MIT](LICENSE) © 2026 Zenghui Zhou
- Bundled fonts (Source Han Sans/Serif SC): [SIL OFL 1.1](fonts/LICENSE) © Adobe
