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
