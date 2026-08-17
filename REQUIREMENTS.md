# Agent Users Doc Preset Requirements

Status: v0.1.1 implementation-aligned reference. Current implementation is the
source of truth for v1.

Scope: v1 ships two standard Agent Skills, one optional OpenCode primary agent,
and two optional OpenCode commands.

## Product Thesis

The preset does not replace docs platforms or invent a new documentation source
format. It lowers the entry barrier for docs-as-code work by giving agents a
small, repo-local contract system and portable documentation guidance.

Primary users:

- Solo founder or product owner who wants useful docs from rough inputs without
  maintaining hidden agent memory.
- Small writing team that needs safe assistance in an existing docs repo without
  a redesign.

## V1 Principles

- **Agent Skills standard first.** `scan-user-docs` and `maintain-user-docs`
  work as normal skill folders and are not tied to one agent product.
- **Self-contained components.** Each bundled skill and the OpenCode agent are
  useful on their own.
- **Docs-as-code first.** Preserve repo source files and detected markup
  formats: Markdown, MDX, reST, AsciiDoc, or mixed.
- **Four required contracts.** The default contract set is always
  `MANIFEST.md`, `TOOLING.md`, `STYLE.md`, and `STRUCTURE.md`.
- **Manifest first.** `MANIFEST.md` is the registry of active contract files and
  is mandatory for every contract write or update.
- **Automatic agent activation.** Contract writes also create or update
  `AGENTS.md` so downstream agents can read all four contract paths directly.
- **Contracts over hidden memory.** Repo-specific facts live in editable
  Markdown-KV files under `.agents/docs-preset/`.
- **Minimal activation.** Scan on demand only. No background audits or full
  page inventory in v1.
- **Preserve existing repos.** Keep structure, navigation, frontmatter,
  includes, conditions, links, table syntax, generated-output boundaries, and
  local rules.
- **Verification over confidence.** Do not invent product claims. Mark gaps when
  facts, commands, links, or examples cannot be verified.
- **User-facing docs only.** Agent workflow files, OpenSpec, assistant
  commands, and agent config are not documentation surfaces unless explicitly
  requested.
- **Practical readability overlays.** V1 includes English STE100-inspired
  technical writing basics and Russian controlled technical writing basics.
  Russian guidance must not be presented as STE100.
- **Diataxis as guidance.** Use standard doc types when useful, but allow
  custom types.

## V1 Contents

### Scan Skill

`skills/scan-user-docs/SKILL.md`

Requirements:

- ✓ Creates or updates the required four-file contract set.
- ✓ Creates `MANIFEST.md` from `templates/MANIFEST.md`.
- ✓ Uses `templates/TOOLING.md`, `templates/STYLE.md`, and
  `templates/STRUCTURE.md` as shapes and adapts content to the repo.
- ✓ Creates `AGENTS.md` from `templates/AGENTS.md` when it is missing.
- ✓ Patches only the `Documentation Contracts` section when `AGENTS.md` already
  exists.
- ✓ Lists `.agents/docs-preset/MANIFEST.md`, `.agents/docs-preset/TOOLING.md`,
  `.agents/docs-preset/STYLE.md`, and `.agents/docs-preset/STRUCTURE.md`
  inline in `AGENTS.md`.
- ✓ Detects cheap, high-confidence facts only.
- ✓ Uses provenance labels such as `detected`, `inferred`, `user`, or
  `unknown` only when they add real value.
- ✓ If a manifest exists, discovers contracts from active manifest entries.
- ✓ If no manifest exists, prepares the required default four-file set.
- ✓ Before writing, summarizes findings and explicitly lists all four contract
  files plus `AGENTS.md` when it will be created or updated.
- ✓ Writes only after confirmation unless the user explicitly asks for defaults.
- ✓ Asks follow-up maintainer questions in chat only when the answers would
  materially improve future docs work.
- ✓ Preserves unknown keys, extension records, and manifest entries.
- ✓ Keeps `STRUCTURE.md` compact and partial.

Detected facts include:

- ✓ Source format.
- ✓ Tooling or platform: MkDocs, Docusaurus, Zensical, Mintlify-style config,
  plain Markdown, custom static generator, mixed, or unknown.
- ✓ Docs root or user-facing surfaces.
- ✓ Navigation source.
- ✓ Build, preview, and lint commands.
- ✓ Generated or locked outputs.
- ✓ User-facing surfaces.
- ✓ Lightweight zones.
- ✓ Style signals.

### Writing And Review Skill

`skills/maintain-user-docs/SKILL.md`

Requirements:

- ✓ Stateless reference only; no file writes and no project facts.
- ✓ Defines doc types: tutorial, how-to, reference, explanation.
- ✓ Defines custom types: quickstart, FAQ, changelog, overview,
  troubleshooting, knowledge-base article.
- ✓ Provides review checklist: completeness, clarity, structure, links,
  factual support, and team quality bar.
- ✓ Provides portable style defaults.
- ✓ Provides language-specific readability overlays for English and Russian.
- ✓ Includes English STE100-inspired writing basics for technical docs.
- ✓ Includes Russian controlled technical writing basics that adapt the same
  clarity goals without calling them STE100.
- ✓ Provides markup cautions for Markdown, MDX, reST, and AsciiDoc.
- ✓ Provides contract extension guidance: when to split style, tooling, or
  structure contracts and how to register them in `MANIFEST.md`.

### OpenCode Primary Agent

`agent/documentation-writer.md`

Requirements:

- ✓ Installed as `.opencode/agent/documentation-writer.md`.
- ✓ Reads `.agents/docs-preset/MANIFEST.md` first, then active contracts.
- ✓ Falls back to legacy `TOOLING.md`, `STYLE.md`, and `STRUCTURE.md` for
  read-only compatibility, but the next contract write or update must create
  `MANIFEST.md`.
- ✓ Applies precedence: user request, local repo rules, most specific active
  contract, default active contract, portable defaults.
- ✓ Routes create, edit, review, restructure, and scan or update tasks.
- ✓ Uses `scan-user-docs` when contracts are missing, stale, or contradicted.
- ✓ Uses `maintain-user-docs` for doc types, checklists, style defaults,
  markup cautions, readability profiles, and contract extension guidance.
- ✓ Updates the active structure contract when user-facing docs are created,
  moved, renamed, split, or when a new surface or zone is confirmed.

### OpenCode Commands

`command/scan-docs.md`

- ✓ Runs the scan flow.
- ✓ Calls `scan-user-docs`.
- ✓ Requires the four-file contract set.
- ✓ Requires `MANIFEST.md` whenever contracts are written or updated.
- ✓ Creates or updates `AGENTS.md` with the four contract paths inline.

`command/check-docs.md`

- ✓ Reviews a target file or directory against active contracts and
  `maintain-user-docs`.
- ✓ Reports findings only unless the user asks for fixes.

### Release Packaging

Repo automation requirements:

- ✓ Tagged GitHub releases can publish a curated zip archive for manual
  download.
- ✓ The release archive includes `README.md`, `REQUIREMENTS.md`, `LICENSE`,
  `skills/`, `agent/`, and `command/`.

## Contract Format

Contracts are Markdown-KV:

- ✓ Headings are records.
- ✓ `key: value` lines are fields.
- ✓ No YAML frontmatter.
- ✓ Preserve unknown keys and extension records.
- ✓ Avoid template-only metadata that does not affect edits, review,
  placement, or verification.
- ✓ Keep generic review heuristics in `maintain-user-docs`, not in generated
  repo contracts.
- ✓ Keep unresolved maintainer questions in chat, not in generated contract
  files.

Default layout:

```text
AGENTS.md
.agents/docs-preset/
  MANIFEST.md
  TOOLING.md
  STYLE.md
  STRUCTURE.md
```

Bundled templates:

```text
skills/scan-user-docs/templates/
  AGENTS.md
  MANIFEST.md
  TOOLING.md
  STYLE.md
  STRUCTURE.md
```

`MANIFEST.md` lists contract files only. It must not contain style, tooling, or
structure rules.

## Future Direction

- PDF, MS Word, wiki, or hosted-platform export beyond existing project
  tooling.
- Full link graph, orphan detection, stale-page detection, or exhaustive IA
  audit.
- Background scans or scheduled audits.
- Publishing or external workflow automation beyond release packaging.
- Treating agent workflow or spec files as user-facing documentation surfaces
  by default.
- Richer contract splitting by product, language, audience, content type, or
  docs environment.
- Seven-Action Documentation Model inspired guidance for reader action,
  outcome framing, content planning, audits, and success metrics.
- STE100-style readability scoring for English, with room to iterate on what
  should be measured and how strongly it should affect review output.
- On-demand link graph and stale or orphan detection.
- Quality dimensions and optional scoring after users define their quality
  model.
- Deeper MkDocs, Docusaurus, VitePress, and Mintlify navigation and
  frontmatter operations.
- `npx` or `skills add` distribution for the standard skills.
- Simpler packaged install flows across supported agent products.
- Product-type template packs.
- Reviewer subagent and coverage analysis.
- Export pipelines for PDF, Word, HTML bundles, wiki formats, and other
  targets.
- Hosted-platform integrations.
- RAG or knowledge-base optimization.

## Implementation Gaps To Watch

- Agents may still follow stale session context after files are updated.
  Restart or reload the agent before testing contract-generation behavior.
- `MANIFEST.md` must be repeatedly framed as part of the required contract set,
  not an optional registry.
- `AGENTS.md` must contain all four contract paths inline; do not rely on
  nested manifest discovery alone for activation.
- `STYLE.md` should avoid scaffold-like prompts on detected facts. Unresolved
  maintainer questions should stay in chat until the user answers them.
