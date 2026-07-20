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
