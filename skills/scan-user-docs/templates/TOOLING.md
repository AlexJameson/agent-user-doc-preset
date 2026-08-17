# Tooling

schema: docs-preset.tooling.v1
validated_at: unknown
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
