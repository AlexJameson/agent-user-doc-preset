---
name: scan-user-docs
description: >-
  Use when docs-preset contracts are missing, stale, contradicted, or when the
  user asks to scan docs. Detects docs tooling, user-facing surfaces, style, and
  structure, then writes Markdown-KV contracts and updates AGENTS.md.
---

# Scan User Docs

This skill creates or updates the required default contract set in
`.agents/docs-preset/`:

- `MANIFEST.md`
- `TOOLING.md`
- `STYLE.md`
- `STRUCTURE.md`

It also creates or updates a root `AGENTS.md` section that lists all four
contract paths inline for downstream agents.

This keeps the scan usable even when the bundled documentation agent or
`maintain-user-docs` skill is not installed.

`MANIFEST.md` is mandatory for every contract write/update. Create it from
`templates/MANIFEST.md`. Use `templates/TOOLING.md`, `templates/STYLE.md`, and
`templates/STRUCTURE.md` as shapes, but adapt their content to repo findings.
Create or patch `AGENTS.md` from `templates/AGENTS.md`.

Run on demand only. Do not run background scans or exhaustive audits.

Start with a cheap repo fingerprint before reading deeply. Do not treat the
context window as the scan budget. Use repo shape, docs roots, generated/source
splits, and cheap file-pattern counts to choose a scan mode.

## Workflow

1. Build a cheap fingerprint from top-level layout, obvious docs/config files, and cheap file-pattern counts.
2. Check `llms.txt` and `llms-full.txt` early when present. Treat them as high-value hints about repo structure, docs surfaces, and local guidance, but verify important claims against the repo before writing contracts.
3. Classify the repo type and choose a scan mode.
4. Detect cheap, high-confidence facts within that scan mode.
5. Classify each fact as `detected`, `inferred`, `user`, or `unknown` when that distinction helps downstream work.
6. If `MANIFEST.md` exists, use active entries to discover contract files.
7. If `MANIFEST.md` is missing, prepare the required default four-file set.
8. If `AGENTS.md` exists, prepare a minimal patch to its documentation-contract section only.
9. If `AGENTS.md` is missing, prepare it from the template.
10. Summarize findings in one compact message and list all files to write.
11. Write only after confirmation unless the user explicitly asked to write defaults.
12. After the write finishes, ask up to three maintainer questions in chat if the answers would materially improve future docs work. Do not write unanswered maintainer questions into contract files.

For empty or messy repos, ask at most three bootstrap questions: product/project,
primary reader, and first desired docs outcome.

## Scan Guardrails

Classify the repo before deeper reads. Useful repo types include:

- Code repo with light docs.
- Docs-first project with one primary docs root.
- Knowledge base or note vault.
- Large or enterprise multi-product docs repo.
- Source plus generated-docs mirror.

Choose one scan mode:

- `normal`: Use for small or medium repos with a few obvious docs roots. Reading dozens of files is acceptable when they are likely to change the contract.
- `bounded`: Use for structured repos with many docs files or several major subtrees. Sample representative files by subtree instead of reading broadly.
- `control-plane-only`: Use for very large docs repos, translated repos, or generated/source split repos. Read root control docs, build/config files, language roots, nav markers, and a few representative subtree markers only.

Escalate from `normal` to `bounded` or `control-plane-only` when cheap signals show that a full content scan would be wasteful. Signals include many docs-like files, multiple language roots, generated bundles, translation trees, many top-level docs roots, or obvious enterprise structure.

For large repos, write a partial contract on purpose. Capture edit boundaries, canonical surfaces, generated outputs, placement rules, and dominant structure. Do not attempt page inventory or exhaustive sampling.

## Detect

- Source format: Markdown, MDX, reST, AsciiDoc, mixed, or unknown.
- Tooling/platform: MkDocs, Docusaurus, Zensical, Mintlify-style config, plain Markdown, custom static generator, mixed, or unknown.
- Repo type and scan mode.
- Docs root or user-facing surfaces.
- Navigation source: `llms.txt`, `llms-full.txt`, `mkdocs.yml`, `sidebars.*`, `zensical.toml`, README links, or unknown.
- Build, preview, and lint commands from README, package scripts, Makefile, pyproject, CI, or config.
- Generated/locked outputs: `site/`, `build/`, `dist/`, `_build/`, `.docusaurus/`, generated API refs, non-editable files.
- User-facing surfaces: `README.md`, `docs/`, examples, tutorials, changelog, release notes, API samples/reference, user-facing developer notes.
- Lightweight zones from nav labels and top-level docs directories.
- Style signals: language, tone, heading style, filename style, terminology, frontmatter, includes, admonitions, diagrams, code blocks.

Agent workflow files, OpenSpec, assistant commands, and agent config are not
user-facing documentation surfaces unless explicitly requested. You may read
local rules/agent files only as safety constraints.

## AGENTS.md Rules

- `AGENTS.md` is an activation aid, not a contract. Keep contract facts in `.agents/docs-preset/`.
- Preserve unrelated `AGENTS.md` content.
- If `AGENTS.md` exists, update only one dedicated section named `Documentation Contracts`.
- If `AGENTS.md` is missing, create it from `templates/AGENTS.md`.
- Keep the section pointer-only. Do not copy repo-specific tooling, style, structure, or review content into `AGENTS.md`.
- The section must list these exact paths inline:
  - `.agents/docs-preset/MANIFEST.md`
  - `.agents/docs-preset/TOOLING.md`
  - `.agents/docs-preset/STYLE.md`
  - `.agents/docs-preset/STRUCTURE.md`
- Do not replace local agent rules unless they directly conflict with the contract paths above.

## Contract Rules

- Contracts are Markdown-KV documents: headings are records, `key: value` lines are fields.
- Do not use YAML frontmatter.
- Keep fields lean. Do not add template-only metadata that does not affect edits, review, placement, or verification.
- Put generic review heuristics in `maintain-user-docs`, not in generated repo contracts.
- Put unresolved maintainer prompts in chat, not in generated contract files.
- Preserve unknown keys, extension records, and manifest entries.
- On re-run, update changed detected facts only.
- Ask before replacing user-confirmed facts.
- `MANIFEST.md` lists contract files only; never put style, tooling, or structure rules in it.

Validation message must explicitly list the four required default files and
`AGENTS.md` when it will be created or updated:

```md
I will write these contracts:
- `.agents/docs-preset/MANIFEST.md`
- `.agents/docs-preset/TOOLING.md`
- `.agents/docs-preset/STYLE.md`
- `.agents/docs-preset/STRUCTURE.md`

I will also create or update:
- `AGENTS.md`
```

## STYLE.md Output

Generate concrete decisions, not a form:

- Do not attach `prompt:` to detected, inferred, or user-confirmed records.
- Do not add placeholder `scoring`, `status`, `scope`, or similar fields unless they carry concrete repo-specific meaning.
- Prefer `source:` only when it materially helps later verification.
- Avoid `source:` and `confidence:` on routine structure records such as obvious surfaces and zones.
- Include useful sections when supported by evidence: product terminology, audience, voice rules, example policy, syntax preservation, and repo-specific verification rules.
