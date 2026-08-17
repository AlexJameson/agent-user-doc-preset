# Agent Users Doc Preset

![Version](https://img.shields.io/badge/version-0.1.1-blue)

A portable documentation bundle for AI agents. It ships two standard Agent
Skills and one optional agent definition. Each part is self-contained.

## Includes

- `skills/scan-user-docs/`: scans a docs repo, writes readable Markdown-KV
  contracts under `.agents/docs-preset/`, and creates or updates `AGENTS.md` so
  downstream agents can find all four contract files.
- `skills/maintain-user-docs/`: stateless guidance for writing, editing,
  reviewing, and restructuring user-facing docs. Includes English
  STE100-inspired basics and Russian controlled technical writing basics.
- `agent/documentation-writer.md`: optional agent definition focused on
  day-to-day docs work. Use it directly in OpenCode or adapt it to another
  harness.

Optional OpenCode wrappers:

- `command/scan-docs.md`
- `command/check-docs.md`

## Install With An Agent

This is the fastest path.

1. Open your documentation repo in your agent.
2. Ask it to install the preset:

```text
Install the documentation preset from https://github.com/AlexJameson/agent-users-doc-preset into this repo.

Required:
- Install `skills/scan-user-docs` at `.agents/skills/scan-user-docs`
- Install `skills/maintain-user-docs` at `.agents/skills/maintain-user-docs`

Optional:
- If this harness supports repo-local agent definitions, install or adapt `agent/documentation-writer.md`
- If this harness supports OpenCode-style commands, install `command/scan-docs.md` and `command/check-docs.md`

Report what you installed and where. Do not run the scan yet.
```

3. Run the scan skill:

```text
Use `scan-user-docs` to scan this repo and write documentation contracts.
```

4. For normal docs work, use the writing and review skill:

```text
Use `maintain-user-docs` to review or rewrite this page.
```

`scan-user-docs` is self-contained. It writes the contracts and patches
`AGENTS.md` so generic agents can consume them without extra setup.

## Install Manually

You can download a release zip from GitHub Releases or clone the repo.

Release page:

- `https://github.com/AlexJameson/agent-users-doc-preset/releases`

### Skills

Place these folders in your project:

- `skills/scan-user-docs/` -> `.agents/skills/scan-user-docs/`
- `skills/maintain-user-docs/` -> `.agents/skills/maintain-user-docs/`

You can do this with your file manager or by terminal.

File-manager approach:

- unpack the release zip or open the cloned repo
- drag `skills/scan-user-docs/` into `.agents/skills/`
- drag `skills/maintain-user-docs/` into `.agents/skills/`

Example:

```sh
PRESET=/path/to/agent-users-doc-preset
mkdir -p .agents/skills
cp -r "$PRESET/skills/scan-user-docs" "$PRESET/skills/maintain-user-docs" .agents/skills/
```

Then run:

```text
Use `scan-user-docs` to scan this repo and write documentation contracts.
```

### Optional Agent Definition

If your harness supports repository agent definitions, install the bundled agent
definition too.

OpenCode path:

- `agent/documentation-writer.md` -> `.opencode/agent/documentation-writer.md`

OpenCode command paths:

- `command/scan-docs.md` -> `.opencode/command/scan-docs.md`
- `command/check-docs.md` -> `.opencode/command/check-docs.md`

Terminal example:

```sh
PRESET=/path/to/agent-users-doc-preset
mkdir -p .opencode/agent .opencode/command
cp "$PRESET/agent/documentation-writer.md" .opencode/agent/documentation-writer.md
cp "$PRESET/command/scan-docs.md" "$PRESET/command/check-docs.md" .opencode/command/
```

For Claude Code, pi, or another harness, use `agent/documentation-writer.md` as
source material and ask an agent to rewrite it into that harness's repo-local
agent, prompt, or rules format.

## What `scan-user-docs` Writes

- `AGENTS.md`
- `.agents/docs-preset/MANIFEST.md`
- `.agents/docs-preset/TOOLING.md`
- `.agents/docs-preset/STYLE.md`
- `.agents/docs-preset/STRUCTURE.md`

`MANIFEST.md` is mandatory. `AGENTS.md` is an activation aid only. Contract
facts stay in `.agents/docs-preset/`.

## Components

- `skills/scan-user-docs/` is the state-producing scan skill. It detects docs
  tooling, user-facing surfaces, style signals, generated outputs, and compact
  structure, then writes Markdown-KV contracts and keeps `AGENTS.md` aligned.
- `skills/scan-user-docs/templates/` contains the contract and `AGENTS.md`
  template shapes used by the scan skill.
- `skills/maintain-user-docs/` is the stateless documentation guidance skill.
  It provides doc type guidance, review checklists, style defaults, markup
  cautions, readability profiles, and contract-extension guidance.
- `agent/documentation-writer.md` is the optional bundled agent definition.
- `command/scan-docs.md` and `command/check-docs.md` are optional OpenCode
  command wrappers.
- `REQUIREMENTS.md` is the implementation-aligned reference for this repo.

## Status

Current version: `0.1.1`

Current scope: v1 portable bundle. Standard Agent Skills come first. The
bundled agent definition and commands are optional integration layers.
