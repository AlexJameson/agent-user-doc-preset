# Style

schema: docs-preset.style.v1
validated_at: unknown
confidence: detected | inferred | user | mixed
primary_language: ru | en | mixed | unknown
voice: concise, user-facing
reader_address: direct | neutral | unknown
heading_style: sentence-case | title-case | mixed | unknown
filename_style: kebab-case | snake_case | mixed | unknown

## Product Terminology

### Term: Product name

value: unknown
source: unknown

### Term: Primary domain term

value: unknown
source: unknown

## Audience

### Audience: Primary reader

value: unknown
source: unknown

### Audience: Secondary reader

value: unknown
source: unknown

## Voice Rules

### Rule: Procedural voice

value: Use direct, task-oriented instructions in guides.

### Rule: Unsupported claims

value: Avoid unsupported performance, reliability, security, pricing, availability, or roadmap claims.

## Terminology Source: Existing Docs

source: existing docs

## Preserve Syntax: Frontmatter

syntax: frontmatter
source: detected | inferred | unknown

## Preserve Syntax: Includes

syntax: includes
source: detected | inferred | unknown

## Example Policy

### Rule: Example source of truth

value: unknown
source: unknown

### Rule: Preferred example languages

value: unknown
source: unknown

## Review Criterion: Completeness

question: Does the page contain enough information for its stated purpose?

## Review Criterion: Accuracy

question: Are product claims supported by code, existing docs, schemas, or supplied materials?

## Review Criterion: Product-specific accuracy

question: Which source should be used to verify product-specific accuracy for this repo?
guidance: unknown
source: detected | inferred | user | unknown

## Questions For Maintainers

### Question: Primary reader

question: Who is the primary reader: developer, operator, admin, product evaluator, end user, or another role?
why: Helps choose examples, assumptions, and level of detail.

### Question: Preferred terminology

question: Which product/domain terms must be used consistently, and what spellings should be avoided?
why: Prevents inconsistent naming across pages.

### Question: Example policy

question: Which source should examples match: code, OpenAPI schema, CLI help, tests, UI, or supplied materials?
why: Prevents examples from drifting away from product behavior.

### Question: Team quality bar

question: What would make a page unacceptable for this team?
why: Lets the team define quality criteria beyond universal defaults.
