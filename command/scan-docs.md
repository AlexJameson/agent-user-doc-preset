---
description: Scan documentation tooling, style, and structure into docs-preset contracts
agent: documentation-writer
---

Scope: $ARGUMENTS

If scope is empty, scan the current repository. If scope names a directory or
file, focus the scan there but still detect repo-level docs tooling when needed.

# Scan Docs Environment

Use the `docs-env-scan` skill to inspect the documentation environment and create
or update `.agents/docs-preset/TOOLING.md`, `STYLE.md`, and `STRUCTURE.md`.

Rules:

- Run on demand only. Do not start background scans or exhaustive audits.
- Detect cheap, high-confidence facts first: docs source format, platform,
  navigation source, user-facing documentation surfaces, generated outputs,
  build/preview commands, style signals, and lightweight zones.
- If contracts already exist, preserve user edits and unknown extension records.
- Update only changed detected facts.
- Ask before replacing user-confirmed facts.
- Keep `STRUCTURE.md` compact and partial; do not create a full page inventory.
- Do not treat agent workflow files, OpenSpec, assistant commands, or agent
  configuration as user-facing documentation surfaces unless explicitly asked.
- Write contracts as Markdown-KV. Do not use YAML frontmatter.

Before writing contracts, summarize findings in one compact message and ask for
confirmation unless the user explicitly asked to write/update contracts without
confirmation.
