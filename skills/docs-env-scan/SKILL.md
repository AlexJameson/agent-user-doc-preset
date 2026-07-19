---
name: docs-env-scan
description: >-
  Use when documentation tooling, structure, or conventions are unknown; when
  contracts in .agents/docs-preset/ are missing, contradicted, or stale; or when
  the user asks to scan the docs environment. Detects docs-as-code tooling,
  user-facing documentation surfaces, lightweight zones, edit-safety boundaries,
  and style conventions; then writes user-validated Markdown-KV contracts.
---

# Docs Environment Scan

This skill creates or updates `.agents/docs-preset/TOOLING.md`, `STYLE.md`, and
`STRUCTURE.md`. It runs on demand only. Do not perform background scans or
exhaustive audits.

## Modes

### Mode: Codify Existing Repo
Use when the repo already has user-facing documentation.

Workflow:

1. Detect cheap, high-confidence facts.
2. Classify facts as `detected`, `inferred`, `user`, or `unknown`.
3. Propose findings in one compact message.
4. Write contracts only after confirmation, unless the user explicitly asked to
   write defaults.
5. Continue the user's original docs task.

### Mode: Bootstrap Empty Or Messy Repo
Use when no clear user-facing docs structure exists.

Ask at most three questions:

1. What is the product or project?
2. Who is the primary reader?
3. What should we create first: overview, quickstart, FAQ, guide, reference, or
   knowledge base?

If the user says to proceed with defaults, write contracts with
`validated_by: skipped` and mark uncertain facts as `unknown`.

## Detection Checklist

Detect only cheap, obvious facts:

- Documentation source format: `markdown`, `mdx`, `rst`, `asciidoc`, `mixed`, or
  `unknown`.
- Tooling/platform: MkDocs, Docusaurus, Zensical, Mintlify-style config,
  plain Markdown, custom static generator, mixed, or unknown.
- Docs root or user-facing surfaces.
- Navigation source: `mkdocs.yml`, `sidebars.*`, `zensical.toml`, implicit
  README links, or unknown.
- Build, preview, and lint commands from README, package scripts, Makefile,
  pyproject, CI, or config files.
- Generated or locked outputs: `site/`, `build/`, `dist/`, `_build/`,
  `.docusaurus/`, generated API refs, files marked non-editable.
- User-facing surfaces: `README.md`, `docs/`, examples, tutorials, changelog,
  release notes, API samples/reference, and user-facing developer notes.
- Lightweight zones from nav labels and top-level docs directories.
- Style signals: language, tone, heading style, filename style, terminology,
  frontmatter, includes, admonitions, diagrams, code block conventions.

For `STYLE.md`, generate concrete rules and decisions, not scaffold-like
templates. Keep prompts only in a separate open-questions section. Do not attach
`prompt:` fields to records with `status: detected`, `status: inferred`, or
`status: user`.

Always include these sections when useful:

- Product terminology: detected product names and important domain terms, plus
  explicit preferred spellings when known.
- Audience: detected or inferred reader groups as decisions, not questions.
- Voice rules: detected/default voice conventions and warnings about unsupported
  claims.
- Example policy: preferred example languages, API/example source of truth, and
  syntax preservation rules.
- Review criteria: default criteria plus product-specific criteria inferred from
  surfaces such as API schemas, quickstarts, or tutorials.
- Questions for maintainers: only unresolved choices that would materially
  improve future docs work.

Do not classify agent workflow files, OpenSpec, assistant commands, or agent
configuration as user-facing documentation surfaces unless the user explicitly
asks to document agent workflows. You may read local rules/agent files as safety
constraints when relevant.

## Confidence Values

### Confidence: detected
meaning: Directly observed in files or commands.

### Confidence: inferred
meaning: Likely based on naming, structure, or repeated conventions.

### Confidence: user
meaning: Confirmed or supplied by the user.

### Confidence: unknown
meaning: Not known. Do not guess.

## Validation Message

Keep validation compact. Example:

```md
I found an existing documentation setup:

- platform: zensical (`zensical.toml`)
- source format: markdown
- editable docs source: `docs/`
- generated output: `site/` — I will not edit it
- navigation source: `zensical.toml`
- likely build command: `zensical build`
- likely preview command: `zensical serve`
- language: English

Should I save these conventions to `.agents/docs-preset/` and continue?
Reply `yes`, edit the list, or say `skip`.
```

## Contract Rules

- Contracts are Markdown-KV documents.
- Do not use YAML frontmatter.
- Headings define records.
- `key: value` lines define fields.
- Preserve unknown keys and extension records.
- On re-run, update only changed detected facts.
- Ask before replacing user-confirmed facts.

## TOOLING.md Template

```md
# Tooling

schema: docs-preset.tooling.v1
validated_at: unknown
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

command: unknown
source: unknown
safety: local | unknown

## Command: Preview

command: unknown
source: unknown
safety: local | unknown

## Generated Or Locked: Site Output

path: site/
reason: generated static site output
edit_safety: generated
source: inferred

## Documentation Surface: User README

path: README.md
type: primary-user-entry
audience: users
purpose: Primary user-facing entry point
edit_safety: editable | ask-first | generated | locked | unknown
source: detected | inferred | user | unknown
```

## STYLE.md Template

```md
# Style

schema: docs-preset.style.v1
validated_at: unknown
validated_by: user | skipped | unknown
confidence: detected | inferred | user | mixed
primary_language: ru | en | mixed | unknown
voice: concise, user-facing
reader_address: direct | neutral | unknown
heading_style: sentence-case | title-case | mixed | unknown
filename_style: kebab-case | snake_case | mixed | unknown

## Product Terminology

### Term: Product name

value: unknown
status: detected | inferred | user | unknown
source: unknown

### Term: Primary domain term

value: unknown
status: unknown
source: unknown

## Audience

### Audience: Primary reader

value: unknown
status: detected | inferred | user | unknown
source: unknown

### Audience: Secondary reader

value: unknown
status: detected | inferred | user | unknown
source: unknown

## Voice Rules

### Rule: Procedural voice

value: Use direct, task-oriented instructions in guides.
status: default

### Rule: Unsupported claims

value: Avoid unsupported performance, reliability, security, pricing, availability, or roadmap claims.
status: default

## Terminology Source: Existing Docs

source: existing docs
status: detected

## Preserve Syntax: Frontmatter

syntax: frontmatter
status: detected | inferred | unknown

## Preserve Syntax: Includes

syntax: includes
status: detected | inferred | unknown

## Example Policy

### Rule: Example source of truth

value: unknown
status: detected | inferred | user | unknown
source: unknown

### Rule: Preferred example languages

value: unknown
status: detected | inferred | user | unknown
source: unknown

## Review Criterion: Completeness

status: default
question: Does the page contain enough information for its stated purpose?
scoring: not configured

## Review Criterion: Accuracy

status: default
question: Are product claims supported by code, existing docs, schemas, or supplied materials?
scoring: not configured

## Review Criterion: Team-specific quality bar

status: placeholder
question: What would make a page unacceptable for this team?
scoring: not configured

## Review Criterion: Product-specific accuracy

status: default | detected | inferred | user | unknown
question: Which source should be used to verify product-specific accuracy for this repo?
scoring: not configured

## Questions For Maintainers

### Question: Primary reader

status: open
question: Who is the primary reader: developer, operator, admin, product evaluator, end user, or another role?
why: Helps choose examples, assumptions, and level of detail.

### Question: Preferred terminology

status: open
question: Which product/domain terms must be used consistently, and what spellings should be avoided?
why: Prevents inconsistent naming across pages.

### Question: Example policy

status: open
question: Which source should examples match: code, OpenAPI schema, CLI help, tests, UI, or supplied materials?
why: Prevents examples from drifting away from product behavior.

### Question: Team quality bar

status: open
question: What would make a page unacceptable for this team?
why: Lets the team define quality criteria beyond universal defaults.
```

## STRUCTURE.md Template

```md
# Structure

schema: docs-preset.structure.v1
validated_at: unknown
validated_by: user | skipped | unknown
confidence: detected | inferred | user | mixed
mode: surfaces-and-zones
inventory: partial

## Documentation Surfaces

### Surface: Published Docs Source
path: docs/
type: published-site-source
audience: users
purpose: Source files for user-facing documentation
edit_safety: editable
source: detected | inferred | user | unknown
confidence: detected | inferred | user | unknown

### Surface: Generated Site
path: site/
type: generated-output
audience: users
purpose: Built site output
edit_safety: generated
source: detected | inferred | user | unknown
confidence: detected | inferred | user | unknown

## Zones

### Zone: Guides
path: docs/guides/
product: unknown
audience: users
purpose: Task-oriented guides
source: navigation | path | user | unknown
confidence: detected | inferred | user | unknown

## Placement Rules

### Rule: Edit source, not generated output
rule: Edit documentation source files, not generated output directories.
status: default | detected | inferred | user

## Known Pages

Only record pages created, moved, renamed, split, or explicitly validated while
using the preset. Do not maintain a full repo inventory in v1.
```
