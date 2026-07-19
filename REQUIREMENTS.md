# Docs Preset — Requirements

Status: **DRAFT for review** — every requirement has an ID; veto or amend by ID.
Scope: **v1 = OpenCode only**: 1 primary agent + 2 skills.

## Product Thesis

Documentation does not need a new source format. Markdown and docs-as-code are
already the portable source of truth for most product docs. The gap is lower in
the workflow: non-expert users need an agent preset that can turn messy inputs
into coherent documentation, preserve existing repo conventions, maintain links
and structure, and verify what it writes without forcing users into a hosted
platform.

The preset starts as a copyable OpenCode configuration, not a separate platform.
It should be useful to two first users:

- **Persona 1: solo founder/product owner.** Has little time, rough materials,
  code, screenshots, or prompts, and wants a useful docs/knowledge base without
  configuring agents.
- **Persona 2: small writing team.** Three writers, little agent expertise, an
  existing multi-product MkDocs/Docusaurus/plain Markdown repo, and a need for
  safe daily assistance without a documentation redesign.

## Design Principles

| ID | Principle |
|---|---|
| P1 | **Docs-as-code first.** Repository source files remain the source of truth. Markdown is the default, but the preset preserves detected MDX, reST, AsciiDoc, or mixed-format conventions. The preset may use project build tooling, but it must not make users dependent on a hosted docs platform. |
| P2 | **Minimal activation.** Do not scaffold, export, map, integrate, or audit unless the repo already does it or the user asks. |
| P3 | **Founder path first.** Empty, messy, or underspecified repos must still work with a compact first-run interaction. |
| P4 | **Existing repo safety.** In mature repos, preserve current structure, navigation, frontmatter, include syntax, conditions, and generated/locked-source boundaries unless explicitly asked to change them. |
| P5 | **Contracts over hidden memory.** Durable project facts live in `.agents/docs-preset/` as editable files: `TOOLING.md`, `STYLE.md`, and `STRUCTURE.md`. |
| P6 | **Defaults over configuration.** Infer cheap, obvious facts; mark uncertain facts as `unknown`; ask only when blocked or before persisting durable assumptions. |
| P7 | **Diataxis as guidance, not law.** Use Diataxis for usage docs when helpful. Non-Diataxis pages become lightweight custom content types instead of violations. |
| P8 | **Verification over confidence.** Product claims must trace to provided materials, existing docs, code, or user confirmation. Mark or ask about unverifiable claims. |
| P9 | **No external side effects.** Do not post comments, update trackers, publish docs, or contact external systems unless the user explicitly requests that exact action. |
| P10 | **LLM-friendly contracts.** Prefer Markdown-KV records over Markdown tables for contract bodies. Tables are allowed only when the target docs style already requires them or when the data is genuinely easier to read as a table. |

## V1 — Minimal Docs Preset

Goal: make a solo founder productive in one session and make a small writing
team safer in an existing repo without requiring agent expertise.

### V1 Scope

V1 supports:

- OpenCode only.
- One primary `docs` agent.
- One stateless `good-docs` skill.
- One on-demand `docs-env-scan` skill.
- Plain Markdown, MkDocs, Docusaurus, and custom/static docs generators as
  detection targets. Known tools such as Zensical may be recorded by name; other
  generators fall back to `custom-static` with detected config and commands.
- Existing Mintlify-style config as a detection signal only, not a platform
  integration.
- Multi-product docs under one docs toolchain, represented as lightweight zones.
- Non-standard user-facing documentation surfaces, such as root `README.md`,
  `docs/`, `examples/`, tutorials, changelogs, and release notes, recorded as
  surfaces instead of forced into one docs site model.
- Markdown as the default authoring format for bootstrap; detected MDX, reST,
  AsciiDoc, or mixed-format conventions are preserved in existing repos.
- Build/lint commands only when detected in repo contracts.

V1 does not support:

- PDF, MS Word, wiki, or hosted-platform export beyond existing project tooling.
- Multi-docset repos with separate toolchains.
- Full link graph, orphan detection, stale-page detection, or exhaustive IA audit.
- Dedicated reviewer subagent or numeric quality scoring.
- Product-type template packs.
- Background scans or scheduled audits.
- Publishing or external workflow automation.
- Agent workflow/specification docs such as `AGENTS.md`, `openspec/`, `.cursor/`,
  `.amazonq/`, `.agent/`, or similar assistant configuration. The preset may
  read them for safety constraints, but they are not documentation surfaces.

### RS-V1-1 — `good-docs` Skill

`good-docs` is pure reference material. It never writes files and never stores
project-specific facts.

| ID | Requirement |
|---|---|
| V1-GD-1 | Define Diataxis quadrants with practical classification criteria: tutorial = learning path, how-to = task path, reference = lookup surface, explanation = conceptual understanding. |
| V1-GD-2 | Provide checkable constraints per quadrant. Example: tutorials avoid branches; how-tos assume a goal; reference pages avoid narrative instruction; explanations avoid step-by-step procedures. |
| V1-GD-3 | Provide short self-check and review checklists for completeness, clarity, structure, links, and factual support. |
| V1-GD-4 | Define default custom content types: `quickstart`, `faq`, `changelog`, `overview`, `troubleshooting`, and `knowledge-base-article`. Each type has purpose, common structure, and tone notes. |
| V1-GD-5 | Provide default style rules that are safe across repos and languages. Project `STYLE.md` overrides these defaults. Prefer Markdown-KV over Markdown tables for generated contract data. |
| V1-GD-6 | Provide minimal page skeletons inline for core Diataxis quadrants and default custom types. Resource files are optional in v1. |
| V1-GD-7 | Document API/SDK docs as dormant content types: use only when detected in the repo or explicitly requested. |
| V1-GD-C1 | Constraint: zero state, zero filesystem writes, no project-specific assumptions. |

### V1 Default Style Rules

These defaults are derived from broadly reusable parts of the Sourcecraft docs
rules and general technical-writing practice. They apply only when the project
does not define a stronger convention.

| ID | Rule |
|---|---|
| V1-ST-1 | Prefer clear, concise, user-facing prose. Use active voice where natural. |
| V1-ST-2 | Address the reader directly in procedural docs when the language and repo style allow it. |
| V1-ST-3 | State assumptions explicitly when they affect the task. |
| V1-ST-4 | If multiple interpretations are plausible, present them and ask instead of choosing silently. |
| V1-ST-5 | If a simpler documentation approach exists, mention it. |
| V1-ST-6 | Preserve existing include syntax, templating syntax, conditional blocks, frontmatter, admonitions, anchors, and nav rules. Do not modify conditions unless explicitly asked. |
| V1-ST-7 | Do not edit files marked as non-editable, generated, or locked by repo rules. If a generated source appears wrong, report the source boundary instead. |
| V1-ST-8 | Match existing heading style, filename style, frontmatter shape, admonition style, and code-block conventions before applying defaults. |
| V1-ST-9 | Use consistent terms for the same product concepts. Prefer terminology found in existing docs and UI/code labels. |
| V1-ST-10 | Do not invent product capabilities, limits, pricing, availability, or roadmap facts. |
| V1-ST-11 | Verify commands, paths, flags, examples, and links when feasible. If not feasible, label the verification gap. |
| V1-ST-12 | Keep cross-product links deliberate. In multi-product repos, link inside the same product zone by default and mention cross-product links in the summary. |
| V1-ST-13 | For preset contracts, write repeated structured data as Markdown-KV records under headings. Avoid Markdown tables by default. |

### RS-V1-2 — `docs-env-scan` Skill

`docs-env-scan` is the only state-producing skill. It runs on demand, usually
inside the user's first real task.

| ID | Requirement |
|---|---|
| V1-SC-1 | Detect cheap, high-confidence facts: docs root or user-facing surfaces, platform/tooling, nav config, markup flavor, build/lint commands, frontmatter conventions, languages, and obvious non-editable/generated-source rules. |
| V1-SC-2 | Detect MkDocs via `mkdocs.yml`, Docusaurus via `docusaurus.config.*`/`sidebars.*`, Zensical via `zensical.toml`, plain Markdown by directory patterns, custom/static generators by obvious docs config files, and Mintlify-style config as a signal only. |
| V1-SC-3 | Classify each durable fact as `detected`, `inferred`, `user`, or `unknown`. Unknowns are not guessed. |
| V1-SC-4 | Existing repo path: preserve current structure and ask one compact validation question before writing contracts. |
| V1-SC-5 | Founder path: if no docs structure exists, ask at most three bootstrap questions: product, primary reader, and first desired docs outcome. |
| V1-SC-6 | Write `TOOLING.md`, `STYLE.md`, and compact `STRUCTURE.md` only after user confirmation, unless the user explicitly asks to bootstrap with defaults. |
| V1-SC-7 | Detect obvious product zones from top-level docs directories and nav labels. Record only zone name, path, source, and confidence. |
| V1-SC-8 | Detect user-facing documentation surfaces even when there is no single docs site: README, docs directory, examples, changelog, release notes, API samples, tutorials, generated outputs, and developer notes that are intended for users. Record purpose and edit safety at directory/file-group level. |
| V1-SC-9 | Infer style from cheap samples: language, heading style, tone, terminology, filename pattern, frontmatter, admonitions, and code-block conventions. |
| V1-SC-10 | Re-run idempotently: preserve user edits, update only changed detected facts, and ask before replacing user-validated facts. |
| V1-SC-11 | Constraint: no automation, no scheduled scans, no exhaustive page-by-page audit in v1. |
| V1-SC-12 | Read local agent/rules files only as safety constraints when relevant. Do not classify agent workflow docs, planning specs, or assistant command files as documentation surfaces unless the user explicitly asks to document the agent workflow itself. |
| V1-SC-13 | Contracts must be forward-extensible: unknown keys are preserved, optional `extensions` records may describe repo/tool-specific capabilities, and agents must not delete unrecognized fields. |

### RS-V1-3 — `documentation-writer` OpenCode Primary Agent

| ID | Requirement |
|---|---|
| V1-AG-1 | Primary agent (`mode: primary`) installed as `.opencode/agent/documentation-writer.md`; users tab into it and ask normal docs tasks. |
| V1-AG-2 | Route tasks as: create, edit, review, restructure, scan/update contracts. Missing contracts trigger `docs-env-scan` inside the current task, not as a separate wizard. |
| V1-AG-3 | Create docs from prompts, pasted notes, existing files, code, images when available, and user-provided materials. |
| V1-AG-4 | For new pages, choose Diataxis quadrant or known custom type; if no type fits, propose a lightweight custom type instead of inventing silently. |
| V1-AG-5 | For edits, match existing conventions and make requested improvements. Flag risky structural/content violations in the summary; do not silently rewrite scope or product facts. |
| V1-AG-6 | For reviews, return a checklist-based report unless the user asks for edits. Focus on completeness, clarity, structure, links, and factual support. |
| V1-AG-7 | Placement respects `STRUCTURE.md` zones. In product zones, create/link inside the same product by default; cross-product links are deliberate and reported. |
| V1-AG-8 | Update `STRUCTURE.md` only for create, move, rename, split, or newly confirmed zone conventions. Do not try to maintain an exhaustive page inventory. |
| V1-AG-9 | Verify product claims against provided materials, existing docs, code, or feasible commands. Mark unverifiable claims or ask when they affect correctness. |
| V1-AG-10 | Output the source format listed in `TOOLING.md`. Markdown is the default; preserve detected MDX, reST, AsciiDoc, or mixed-format conventions. Run build/lint only when listed in `TOOLING.md` and relevant to the task. |
| V1-AG-11 | If repo reality contradicts contracts, fix trivial detected facts with a note; ask on ambiguous facts; suggest re-scan only for structural changes or repeated contradictions. |

### V1 Contract Formats

Contracts are Markdown-KV documents: headings define records and plain
`key: value` lines define fields. Do not use YAML frontmatter for preset
contracts. This keeps contracts readable for non-technical users and easier for
agents to edit reliably.

Unknown keys and extension records must be preserved. Do not delete unrecognized
fields during re-scan or contract updates.

#### `TOOLING.md`

```md
# Tooling

schema: docs-preset.tooling.v1
validated_at: 2026-07-19T00:00:00Z
validated_by: user | skipped | unknown
confidence: detected | inferred | user | mixed
platform: mkdocs | docusaurus | zensical | mintlify | plain-markdown | custom-static | mixed | unknown
source_format: markdown | mdx | rst | asciidoc | mixed | unknown
primary_docs_root: docs | null | unknown
frontmatter: required | optional | absent | unknown
external_side_effects: explicit-user-request-only

## Navigation

source: mkdocs.yml | sidebars.js | zensical.toml | implicit | unknown
format: yaml | js | toml | implicit | unknown
editable: true | false | unknown
confidence: detected | inferred | user | unknown

## Command: Build

command: mkdocs build
source: detected
safety: local

## Command: Preview

command: mkdocs serve
source: detected
safety: local

## Generated Or Locked: API Reference

path: docs/api/
reason: generated API reference
edit_safety: generated
source: inferred

## Product: Product A

name: Product A
path: docs/product-a/
source: detected
confidence: detected

## Shared Path: Shared Docs

path: docs/shared/
source: inferred

## Documentation Surface: User README

path: README.md
type: primary-user-entry
audience: users
purpose: Primary user-facing entry point
edit_safety: editable
source: detected

## Extension: zensical

scope: tooling
status: optional
purpose: Store Zensical-specific configuration facts without changing the v1 schema.

Short human-readable notes about how docs are built, which files should not be
edited, and which commands are safe to run.
```

#### `STYLE.md`

```md
# Style

schema: docs-preset.style.v1
validated_at: 2026-07-19T00:00:00Z
validated_by: user | skipped | unknown
confidence: detected | inferred | user | mixed
primary_language: ru | en | mixed | unknown
voice: concise, user-facing
reader_address: direct | neutral | unknown
heading_style: sentence-case | title-case | unknown
filename_style: kebab-case | snake_case | unknown

## Terminology Source: Existing Docs

source: existing docs
status: detected

## Terminology Source: Product UI

source: product UI
status: placeholder
prompt: What source should be authoritative for UI terms?

## Preserve Syntax: Frontmatter

syntax: frontmatter
status: detected | inferred | unknown

## Preserve Syntax: Includes

syntax: includes
status: detected | inferred | unknown

## Preserve Syntax: Template Conditions

syntax: template conditions
status: detected | inferred | unknown

## Review Criterion: Completeness

status: default
question: Does the page contain enough information for its stated purpose?
scoring: not configured

## Review Criterion: Accuracy

status: default
question: Are product claims supported by code, existing docs, specs, or supplied materials?
scoring: not configured

## Review Criterion: Team-specific quality bar

status: placeholder
question: What would make a page unacceptable for this team?
scoring: not configured

Short human-readable writing conventions, terminology notes, and repo-specific
exceptions. If this file is silent, use the v1 default style rules.
```

#### `STRUCTURE.md`

```md
# Structure

schema: docs-preset.structure.v1
validated_at: 2026-07-19T00:00:00Z
validated_by: user | skipped | unknown
confidence: detected | inferred | user | mixed
mode: surfaces-and-zones
inventory: partial

## Zones

### Zone: Product A
path: docs/product-a/
product: Product A
purpose: Product-specific user docs
source: nav + path
confidence: detected

### Zone: Shared
path: docs/shared/
product: shared
purpose: Shared concepts and reusable pages
source: path
confidence: inferred

## Documentation Surfaces

Use surfaces when a repo has useful documentation outside a single published docs
site. Surfaces explain where user-facing documentation lives without turning v1
into a full inventory. Agent workflow docs and planning specs are not surfaces by
default.

### Surface: User README
path: README.md
purpose: Primary user-facing entry point
edit_safety: editable
source: path
confidence: detected

### Surface: Examples
path: examples/
purpose: Sample-driven user guidance
edit_safety: ask before editing generated samples
source: path
confidence: inferred

### Surface: Developer notes
path: dev/docs/
purpose: Internal notes that may contain source material for user docs
edit_safety: ask before promoting to user docs
source: path
confidence: inferred

## Placement Rules

### Rule: Product-specific placement
rule: New product-specific pages go into the matching product zone.
status: inferred

### Rule: Shared concepts
rule: Shared concepts go into `docs/shared/` when present.
status: inferred

### Rule: Cross-product links
rule: Cross-product links must be deliberate and mentioned in the summary.
status: default

## Known Pages

Only record pages created, moved, renamed, split, or explicitly validated while
using the preset. Do not maintain a full repo inventory in v1.

### Page: docs/product-a/getting-started.md
zone: Product A
type: quickstart
purpose: First successful setup path
status: user-validated

## Extensions

### Extension: zensical
scope: tooling
status: optional
purpose: Store Zensical-specific configuration facts without changing the v1 schema.
```

### V1 Unified Flow

```text
install preset
  -> user switches to documentation-writer agent
  -> user asks a real docs task
  -> missing contracts trigger lightweight scan inside the task
       founder path: ask up to 3 bootstrap questions
       existing repo path: detect tooling, style, zones; ask one compact validation question
  -> write contracts after confirmation
  -> complete original task
  -> summarize created/changed docs, verification gaps, and any contract updates
```

## V2 — Serious Docs Workflow

Goal: help small writing/product teams improve structure, consistency, coverage,
and quality in existing docs-as-code repos.

| ID | Requirement |
|---|---|
| V2-1 | More complete `STRUCTURE.md` with optional page inventory by zone and content type. |
| V2-2 | On-demand link graph for restructure/review tasks; computed when needed, not stored as durable truth. |
| V2-3 | Orphan, duplicate, stale-link, and missing-nav detection. |
| V2-4 | Dedicated quality review mode with explicit dimensions and optional scoring. |
| V2-5 | Deeper MkDocs/Docusaurus/VitePress/Mintlify nav and frontmatter operations. |
| V2-6 | Richer custom content type detection from recurring page patterns. |
| V2-7 | Product zones with per-product style or placement overrides under one toolchain. |
| V2-8 | Team conventions: ownership hints, review checklists, release-docs workflow, and migration playbooks. |
| V2-9 | Re-scan/update flow that shows diffs between old and new contracts before writing. |
| V2-10 | Export through existing project tooling when configured, still no platform lock-in. |

## V3 — Documentation Product Layer

Goal: approach an "Open Design for docs" product while keeping docs-as-code as
the source of truth.

| ID | Requirement |
|---|---|
| V3-1 | Product-type template packs: SaaS, desktop app, mobile/client app, data product, API, internal knowledge base, RAG corpus. |
| V3-2 | Export pipelines for PDF, MS Word, HTML bundles, wiki formats, and other target formats when requested. |
| V3-3 | Integrations with Mintlify, Notion, Confluence, GitHub/GitLab, Sourcecraft, and publishing providers. |
| V3-4 | Dedicated reviewer subagent with quality scoring, regression checks, and coverage analysis. |
| V3-5 | RAG/knowledge-base optimization: chunking, metadata, duplication control, source traceability, and retrieval evaluation. |
| V3-6 | Multi-harness distribution: OpenCode, Claude Code, Cursor, Codex, Roo Code, Cline, and others. |
| V3-7 | CLI/UI for install, upgrade, contract validation, audits, and publishing workflows. |

## Explicitly Out Of Scope For V1

- Replacing a docs platform.
- Publishing docs without explicit instruction.
- Editing generated, locked, or non-editable docs sources.
- Maintaining an exhaustive documentation graph.
- Inferring product facts without source material.
- Optimizing for ISO/GOST/regulated-document workflows.

## Open Questions

1. **Language defaults:** Should v1 ship bilingual EN/RU examples immediately, or keep examples language-neutral and let `STYLE.md` carry language-specific rules?
2. **Verification boundary:** Should v1 execute documented CLI commands by default when they are safe and local, or only when the user asks?
3. **Contract confirmation:** Should founder bootstrap allow writing contracts after three unanswered questions using `validated_by: skipped`, or should it always require explicit confirmation?
