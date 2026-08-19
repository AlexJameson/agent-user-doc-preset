# Agent User Doc Preset

![Version](https://img.shields.io/badge/version-0.1.2-blue)

A portable bundle to make agents write good user docs. It ships two standard Agent Skills and one optional agent definition. Agent and skill definitions require about `3500` tokens. Typical output size for the whole generated contract set is about `2,000` to `5,000` tokens, depending on repo complexity.

To get started, install the preset and ask your agent to scan the docs with the `scan-user-docs` skill. Then you can use the `maintain-user-docs` skill to create new docs or update the existing ones, optionally with the `documentation-writer` agent.

`scan-user-docs` is the most important part of the preset. It is the self-contained skill that discovers the repo shape, writes the local documentation contracts, and makes the rest of the preset repo-aware. `maintain-user-docs` is the lightweight writing and review guide used after the scan when you want better edits and reviews. `agent/documentation-writer.md` is the optional OpenCode primary agent definition that ties those two skills together for day-to-day docs work.

## TOC

- [Install With An Agent](#install-with-an-agent)
- [Install Manually](#install-manually)
- [Preset Structure](#preset-structure)
- [`scan-user-docs` Skill](#scan-user-docs-skill)
- [`maintain-user-docs` Skill](#maintain-user-docs-skill)
- [Agent Definition](#agent-definition)
- [Contract Format and Vocabulary](#contract-format-and-vocabulary)

## Install With An Agent

This is the fastest path.

1. Open your documentation repo in your agent.
2. Ask agent to install the preset by copying the prompt below:

```text
Install the documentation preset from https://github.com/AlexJameson/agent-user-doc-preset into this repo.

Required:
- Install `skills/scan-user-docs` at `.agents/skills/scan-user-docs`
- Install `skills/maintain-user-docs` at `.agents/skills/maintain-user-docs`

Harness-specific:
- If you are using OpenCode, install `agent/documentation-writer.md` at `.opencode/agent/documentation-writer.md`
- If you are using OpenCode, install `command/scan-docs.md` and `command/check-docs.md` under `.opencode/command/`
- If you are using another harness, do not skip the agent layer silently. Suggest how to adapt `agent/documentation-writer.md` into that harness's repo-local agent, prompt, or rules format

Report what you installed and where. Do not run the scan yet.
```

3. Run the scan skill (you can use the command in OpenCode):

```text
Use `scan-user-docs` to scan this repo and write documentation contracts.
```

## Install Manually

You can download a zip or tar.gz archive from [GitHub Releases page](https://github.com/AlexJameson/agent-user-doc-preset/releases) or clone this repo.

## Preset Structure

- `skills/scan-user-docs/`: scans a docs repo, writes readable Markdown-KV contracts under `.agents/docs-preset/`, and creates or updates `AGENTS.md` so downstream agents can find all four contract files. Run after you install the preset or this skill alone.
- `skills/maintain-user-docs/`: stateless guidance for writing, editing, reviewing, and restructuring user-facing docs. Includes English and Russian STE100-inspired basics. It does not write or discover repo facts on its own, so for repo-aware work it should be used after `scan-user-docs` has written contracts.
- `agent/documentation-writer.md`: OpenCode agent definition focused on day-to-day docs work. Use it directly in OpenCode or adapt it to another harness. It is contract-driven: it depends on `scan-user-docs` for repo facts and uses `maintain-user-docs` for doc types, defaults, checklists, readability profiles, and markup cautions.

Optional wrappers to trigger skills using slash commands:

- `command/scan-docs.md`
- `command/check-docs.md`

### Skills

Place these folders in your project:

- `skills/scan-user-docs/` -> `.agents/skills/scan-user-docs/`
- `skills/maintain-user-docs/` -> `.agents/skills/maintain-user-docs/`

Commands (if needed):

- `command/scan-docs.md` -> `.opencode/command/scan-docs.md`
- `command/check-docs.md` -> `.opencode/command/check-docs.md`

#### `scan-user-docs` Skill

`scan-user-docs` is self-contained. It writes the contracts and patches `AGENTS.md` so generic agents can consume them without extra setup.

After the scan writes contracts, it can ask a few maintainer follow-up questions in chat. Those questions should not be written into contract files unless the maintainer answers them and wants the contracts updated.

What `scan-user-docs` writes:

- `AGENTS.md`
- `.agents/docs-preset/MANIFEST.md`
- `.agents/docs-preset/TOOLING.md`
- `.agents/docs-preset/STYLE.md`
- `.agents/docs-preset/STRUCTURE.md`

`MANIFEST.md` is mandatory. `AGENTS.md` is an activation aid only. Contract facts stay in `.agents/docs-preset/`. The generated `AGENTS.md` section should stay minimal and point to contracts rather than repeating their content.

`skills/scan-user-docs/templates/` contains the contract and `AGENTS.md` template shapes used by the scan skill.

##### Scan Strategy

`scan-user-docs` should not spend its whole budget trying to read every page in a large repo.

It starts with a cheap fingerprint:

- top-level layout
- obvious docs and config files
- docs-like file patterns
- generated versus editable directory splits
- existing guidance such as `README.md`, `AGENTS.md`, `llms.txt`, or `llms-full.txt`

Then it classifies the repo and picks a scan mode:

- `normal`: small or medium repos with a few obvious docs roots
- `bounded`: structured repos that need representative subtree sampling
- `control-plane-only`: very large docs repos, translated repos, or source-plus-generated repos

Large repos should produce partial contracts by design. The scan should capture canonical surfaces, edit boundaries, generated outputs, structure markers, and placement rules without attempting an exhaustive page inventory.

#### `maintain-user-docs` Skill

`maintain-user-docs` is a minimal stateless writing and review skill. It does not scan repos, discover project facts, or write contracts.

Use it after `scan-user-docs` when you want repo-aware editing or review. It depends on the contracts written by `scan-user-docs` for local facts, and the OpenCode agent definition depends on it for doc types, checklists, readability profiles, and markup cautions.

#### Agent Definition

It is a primary agent designed for OpenCode and can be used in this harness as is. You need to adapt this agent to your harness format on your own if you want to use it.

OpenCode path:

- `agent/documentation-writer.md` -> `.opencode/agent/documentation-writer.md`

## Contract Format and Vocabulary

Contracts use Markdown-KV.

Markdown-KV is plain Markdown with information organized in a consistent record-and-field shape. It is meant to stay human-readable first, while still being easy for agents to scan, compare, and update safely.

- Headings define records.
- `key: value` lines define fields inside those records. Values are not hardcoded, you can replace them with any values you need.
- Normal Markdown prose can still appear where it helps readability.

Common terms:

- `surface`: a concrete documentation file or directory with a defined purpose, audience, and edit boundary.
- `zone`: a logical documentation area that may span multiple surfaces and helps agents place or move content.
- `rule`: a repo-specific instruction about placement, editing, or avoidance.
- `safety`: the expected side-effect level of running a documented command.
- `edit_safety`: the expected caution level for editing a documented file or directory.
