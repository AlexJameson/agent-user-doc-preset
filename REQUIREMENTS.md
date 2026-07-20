# Docs Preset Requirements

Status: implementation-aligned reference. Current implementation is the source
of truth for v1.

Scope: v1 is OpenCode-only: one primary agent, two skills, and two slash
commands.

## Product Thesis

The preset does not replace docs platforms or invent a new documentation source
format. It lowers the entry barrier for docs-as-code work by giving agents a
small, repo-local contract system and portable documentation rules.

Primary users:

- Solo founder/product owner who wants useful docs from rough inputs without
  configuring agents.
- Small writing team that needs safe assistance in an existing docs repo without
  a redesign.

## V1 Principles

- **Docs-as-code first.** Preserve repo source files and detected markup formats:
  Markdown, MDX, reST, AsciiDoc, or mixed.
- **Four required contracts.** The default contract set is always
  `MANIFEST.md`, `TOOLING.md`, `STYLE.md`, and `STRUCTURE.md`.
- **Manifest first.** `MANIFEST.md` is the registry of active contract files and
  is mandatory for every contract write/update.
- **Contracts over hidden memory.** Repo-specific facts live in editable
  Markdown-KV files under `.agents/docs-preset/`.
- **Minimal activation.** Scan on demand only; no background audits or full page
  inventory.
- **Preserve existing repos.** Keep structure, navigation, frontmatter, includes,
  conditions, links, table syntax, generated-output boundaries, and local rules.
- **Verification over confidence.** Do not invent product claims. Mark gaps when
  facts, commands, links, or examples cannot be verified.
- **User-facing docs only.** Agent workflow files, OpenSpec, assistant commands,
  and agent config are not documentation surfaces unless explicitly requested.
- **Diataxis as guidance.** Use standard doc types when useful, but allow custom
  types.

## V1 Contents

### Primary Agent

`agent/documentation-writer.md`

Requirements:

- ✓ Installed as `.opencode/agent/documentation-writer.md`.
- ✓ Reads `.agents/docs-preset/MANIFEST.md` first, then active contracts.
- ✓ Falls back to legacy `TOOLING.md`, `STYLE.md`, `STRUCTURE.md` for read-only
  compatibility, but the next contract write/update must create `MANIFEST.md`.
- ✓ Applies precedence: user request, local repo rules, most specific active
  contract, default active contract, portable defaults.
- ✓ Routes create, edit, review, restructure, and scan/update tasks.
- ✓ Uses `docs-env-scan` when contracts are missing, stale, or contradicted.
- ✓ Uses `good-docs` for doc types, checklists, style defaults, markup cautions,
  and contract extension guidance.
- ✓ Updates the active structure contract when user-facing docs are created,
  moved, renamed, split, or when a new surface/zone is confirmed.

### Scan Skill

`skills/docs-env-scan/SKILL.md`

Requirements:

- ✓ Creates or updates the required four-file contract set.
- ✓ Creates `MANIFEST.md` from `templates/MANIFEST.md`.
- ✓ Uses `templates/TOOLING.md`, `templates/STYLE.md`, and
  `templates/STRUCTURE.md` as shapes and adapts content to the repo.
- ✓ Detects cheap, high-confidence facts only.
- ✓ Classifies facts as `detected`, `inferred`, `user`, or `unknown`.
- ✓ If a manifest exists, discovers contracts from active manifest entries.
- ✓ If no manifest exists, prepares the required default four-file set.
- ✓ Before writing, summarizes findings and explicitly lists all four files.
- ✓ Writes only after confirmation unless the user explicitly asks for defaults.
- ✓ Preserves unknown keys, extension records, manifest entries, types, scopes,
  and statuses.
- ✓ Keeps `STRUCTURE.md` compact and partial.

Detected facts include:

- ✓ Source format.
- ✓ Tooling/platform: MkDocs, Docusaurus, Zensical, Mintlify-style config, plain
  Markdown, custom static generator, mixed, or unknown.
- ✓ Docs root or user-facing surfaces.
- ✓ Navigation source.
- ✓ Build, preview, and lint commands.
- ✓ Generated/locked outputs.
- ✓ User-facing surfaces.
- ✓ Lightweight zones.
- ✓ Style signals.

### Good Docs Skill

`skills/good-docs/SKILL.md`

Requirements:

- ✓ Stateless reference only; no file writes and no project facts.
- ✓ Defines doc types: tutorial, how-to, reference, explanation.
- ✓ Defines custom types: quickstart, FAQ, changelog, overview, troubleshooting,
  knowledge-base article.
- ✓ Provides review checklist: completeness, clarity, structure, links, factual
  support, and team quality bar.
- ✓ Provides portable style defaults.
- ✓ Provides markup cautions for Markdown, MDX, reST, and AsciiDoc.
- ✓ Provides contract extension guidance: when to split style, tooling, or
  structure contracts and how to register them in `MANIFEST.md`.

### Slash Commands

`command/scan-docs.md`

- ✓ Runs the scan flow.
- ✓ Requires the four-file contract set.
- ✓ Requires `MANIFEST.md` whenever contracts are written or updated.

`command/check-docs.md`

- ✓ Reviews a target file or directory against active contracts and `good-docs`.
- ✓ Reports findings only unless the user asks for fixes.

## Contract Format

Contracts are Markdown-KV:

- ✓ Headings are records.
- ✓ `key: value` lines are fields.
- ✓ No YAML frontmatter.
- ✓ Preserve unknown keys and extension records.

Default layout:

```text
.agents/docs-preset/
  MANIFEST.md
  TOOLING.md
  STYLE.md
  STRUCTURE.md
```

Bundled templates:

```text
skills/docs-env-scan/templates/
  MANIFEST.md
  TOOLING.md
  STYLE.md
  STRUCTURE.md
```

`MANIFEST.md` lists contract files only. It must not contain style, tooling, or
structure rules.

## V1 Out Of Scope

- PDF, MS Word, wiki, or hosted-platform export beyond existing project tooling.
- Full link graph, orphan detection, stale-page detection, or exhaustive IA audit.
- Numeric quality scoring.
- Product-type template packs.
- Dedicated reviewer subagent.
- Background scans or scheduled audits.
- Publishing or external workflow automation.
- Treating agent workflow/spec files as user-facing documentation surfaces by
  default.

## V2 Direction

- Richer contract splitting by product, language, audience, content type, or docs
  environment.
- On-demand link graph and stale/orphan detection.
- Quality dimensions and optional scoring after users define their quality model.
- Deeper MkDocs/Docusaurus/VitePress/Mintlify navigation and frontmatter
  operations.
- Team workflows: ownership hints, release-docs workflow, review checklists,
  migration playbooks.

## V3 Direction

- Product-type template packs.
- Export pipelines for PDF, Word, HTML bundles, wiki formats, and other targets.
- Hosted-platform integrations.
- Reviewer subagent and coverage analysis.
- RAG/knowledge-base optimization.
- Multi-harness distribution and CLI/UI.

## Implementation Gaps To Watch

- Agents may still follow stale session context after files are updated. Restart
  or reload the agent before testing contract-generation behavior.
- `MANIFEST.md` must be repeatedly framed as part of the required contract set,
  not an optional registry.
- `STYLE.md` should avoid scaffold-like prompts on detected facts; open questions
  belong under `Questions For Maintainers`.
