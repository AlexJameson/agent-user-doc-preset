---
description: Check docs against docs-preset contracts and writing rules
agent: documentation-writer
---

Target: $ARGUMENTS

If target is empty, ask for a relative file or directory path.

# Check Documentation

Review the target against active contracts in `.agents/docs-preset/` and the
`maintain-user-docs` skill. If contracts are missing or stale, ask whether to run
`/scan-docs` first.

Check:

- Completeness for the page type and reader goal.
- Clarity, structure, headings, and information order.
- Consistency with `STYLE.md`.
- Placement and links against `STRUCTURE.md`.
- Tooling and edit-safety constraints from `TOOLING.md`.
- Factual support for claims, examples, commands, paths, API behavior, limits, security, pricing, availability, and roadmap statements.
- Source-format preservation for Markdown, MDX, reST, AsciiDoc, or mixed repos.

If the user asked for review, report findings only. If the user asked to fix,
make safe edits and summarize changes. Do not restructure or update navigation
unless explicitly asked.
