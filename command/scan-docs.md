---
description: Scan docs environment and write docs-preset contracts
agent: documentation-writer
---

Scope: $ARGUMENTS

If scope is empty, scan the current repository.

# Scan Docs Environment

Use `docs-env-scan` to create or update the required default contract set:

- `.agents/docs-preset/MANIFEST.md`
- `.agents/docs-preset/TOOLING.md`
- `.agents/docs-preset/STYLE.md`
- `.agents/docs-preset/STRUCTURE.md`

Rules:

- `MANIFEST.md` is required whenever contracts are written or updated.
- If `MANIFEST.md` exists, use it to discover active contracts and preserve unknown entries.
- If `MANIFEST.md` is missing, create it from the skill template before or with the other contracts.
- Detect cheap, high-confidence facts only.
- Preserve user edits, unknown keys, and extension records.
- Ask before replacing user-confirmed facts.
- Keep `STRUCTURE.md` compact; do not create a full page inventory.
- Do not treat agent workflow files, OpenSpec, assistant commands, or agent config as user-facing docs unless explicitly asked.

Before writing, summarize findings and explicitly list all files to be written.
