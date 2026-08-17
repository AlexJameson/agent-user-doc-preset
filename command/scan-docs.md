---
description: Scan docs environment and write docs-preset contracts
agent: documentation-writer
---

Scope: $ARGUMENTS

If scope is empty, scan the current repository.

# Scan Docs Environment

Use `scan-user-docs` to create or update the required default contract set:

- `.agents/docs-preset/MANIFEST.md`
- `.agents/docs-preset/TOOLING.md`
- `.agents/docs-preset/STYLE.md`
- `.agents/docs-preset/STRUCTURE.md`

Also create or update `AGENTS.md` so it explicitly lists all four contract
paths for downstream agents.

Rules:

- `MANIFEST.md` is required whenever contracts are written or updated.
- If `MANIFEST.md` exists, use it to discover active contracts and preserve unknown entries.
- If `MANIFEST.md` is missing, create it from the skill template before or with the other contracts.
- If `AGENTS.md` exists, preserve unrelated content and update only the documentation-contract section.
- If `AGENTS.md` is missing, create it from the skill template.
- `AGENTS.md` must list these exact paths inline: `.agents/docs-preset/MANIFEST.md`, `.agents/docs-preset/TOOLING.md`, `.agents/docs-preset/STYLE.md`, `.agents/docs-preset/STRUCTURE.md`.
- Detect cheap, high-confidence facts only.
- Preserve user edits, unknown keys, and extension records.
- Ask before replacing user-confirmed facts.
- Keep `STRUCTURE.md` compact; do not create a full page inventory.
- Do not treat agent workflow files, OpenSpec, assistant commands, or agent config as user-facing docs unless explicitly asked.

Before writing, summarize findings and explicitly list all files to be written,
including `AGENTS.md` when it will be created or updated.
