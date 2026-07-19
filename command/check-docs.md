---
description: Check documentation files against docs-preset contracts and writing rules
agent: documentation-writer
---

Target: $ARGUMENTS

If target is empty, ask the user for a relative file or directory path.

# Check Documentation

Review the target against the project contracts in `.agents/docs-preset/` and
the `good-docs` skill. If contracts are missing or clearly stale, ask whether to
run `/scan-docs` first.

Check for:

- Completeness for the declared page type and reader goal.
- Clarity, structure, headings, and information order.
- Consistency with `STYLE.md`: voice, terminology, reader address, examples,
  syntax conventions, and review criteria.
- Placement and linking consistency with `STRUCTURE.md`.
- Tooling and edit-safety constraints from `TOOLING.md`, including generated or
  locked outputs.
- Factual support for product claims, API behavior, commands, paths, examples,
  limits, security claims, pricing, availability, and roadmap statements.
- Source-format preservation for Markdown, MDX, reST, AsciiDoc, or mixed-format
  repos.

Output:

- If the user asked for a review, report findings only. Do not edit.
- If the user asked to fix, make safe edits and summarize what changed.
- For uncertain product facts, mark the verification gap or ask if it blocks the
  edit.
- Do not rewrite scope, restructure pages, or update navigation unless the user
  asked for that explicitly.
