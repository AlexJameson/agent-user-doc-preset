---
name: maintain-user-docs
description: >-
  Use when writing, editing, reviewing, or restructuring user-facing docs.
  Provides doc type guidance, checklists, style defaults, markup cautions,
  readability profiles, and contract extension guidance.
---

# Maintain User Docs

Stateless reference only. Do not write files or store project facts. Project
facts come from `.agents/docs-preset/` contracts registered in `MANIFEST.md`.

## Doc Types

- **Tutorial**: learning path. One safe route; avoid branching and exhaustive options.
- **How-to**: task path. Goal, prerequisites, steps, expected result, troubleshooting.
- **Reference**: lookup surface. Accurate facts, fields, commands, APIs; avoid narrative teaching.
- **Explanation**: understanding. Concepts, architecture, tradeoffs; avoid step-by-step procedure.

If none fits, use or propose a custom type.

## Custom Types

### Type: quickstart
purpose: First success quickly.
structure: goal, prerequisites, shortest path, expected result, next links

### Type: faq
purpose: Answer common concrete questions.
structure: grouped questions, direct answers, links to deeper docs

### Type: changelog
purpose: Explain user-visible changes over time.
structure: version/date, added, changed, fixed, removed, migration notes

### Type: overview
purpose: Orient the reader to a product or area.
structure: what it is, who it is for, core concepts, next steps

### Type: troubleshooting
purpose: Diagnose and fix known problems.
structure: symptom, likely cause, fix, verification, escalation

### Type: knowledge-base-article
purpose: Capture reusable domain/product knowledge.
structure: context, answer, details, related material, source notes

## Review Checklist

- Completeness: enough information for the stated purpose.
- Clarity: intended reader can understand without hidden assumptions.
- Structure: page type matches headings and detail level.
- Links: prerequisites, next steps, and related pages are connected.
- Factual support: claims trace to supplied materials, docs, code, schemas, or user confirmation.
- Team quality bar: apply criteria from `STYLE.md` when present.

## Style Defaults

- Clear, concise, user-facing prose.
- Active voice where natural.
- Direct address in procedural docs when repo style allows it.
- Preserve existing terminology, headings, links, frontmatter, includes, admonitions, anchors, diagrams, and code-block conventions.
- Do not invent product facts.
- Use Markdown-KV for preset contracts.

`STYLE.md` should read like a compact local style guide. Put unresolved choices
under `Questions For Maintainers`, not as `prompt:` fields on detected facts.

## Readability Profiles

Use these as optional overlays when the repo language, audience, or explicit
user request calls for tighter technical prose. They are guidance, not a reason
to overwrite established local style without need.

### Profile: ste100-en-basics

Use for English technical docs when the team wants controlled, low-ambiguity
prose. This is STE100-inspired guidance, not a compliance claim.

- Keep instruction sentences short.
- Keep explanation sentences short.
- Use one instruction per sentence.
- Put the condition before the action.
- Prefer active voice and direct verbs.
- Keep one term for one concept across the page.
- Remove hedging and filler when the fact is known.

Reference: `references/ste100-en-basics.md`

### Profile: ru-technical-basics

Use for Russian technical docs when the team wants controlled, plain technical
Russian. Do not call this STE100. It is a Russian readability profile inspired
by the same controlled-language goals.

- Prefer direct verbs over noun-heavy official wording.
- Use one action or one point per sentence.
- Put the condition before the action.
- Prefer active voice when it makes responsibility and behavior clearer.
- Keep terminology stable; one term for one concept.
- Split stacked noun chains and long clauses.
- Replace vague modality with explicit conditions, values, files, commands, or outcomes.

Reference: `references/ru-technical-basics.md`

## Markup Cautions

### Format: Markdown
preserve: frontmatter, relative links, admonitions, Mermaid, tabs, snippets, anchors

### Format: MDX
preserve: imports, JSX components, props, frontmatter

### Format: reST
preserve: directives, roles, labels, toctrees, Sphinx/autodoc syntax

### Format: AsciiDoc
preserve: attributes, includes, conditionals, blocks, anchors, xrefs

## Contract Extension

Start with `MANIFEST.md`, `TOOLING.md`, `STYLE.md`, and `STRUCTURE.md`. Split
contracts only when files become hard to use or scopes genuinely differ.

### Split Style When
reason: Different languages, products, audiences, or content types need different rules.
examples: `style/ru.md`, `style/api-reference.md`, `style/product-a.md`

### Split Tooling When
reason: Different docs environments use different roots, generators, commands, or generated outputs.
examples: `tooling/public-docs.md`, `tooling/api-reference.md`

### Split Structure When
reason: Products or docsets have separate placement rules or navigation ownership.
examples: `structure/product-a.md`, `structure/public-docs.md`

Register every split contract in `MANIFEST.md`. Apply the most specific active
contract before the default one.
