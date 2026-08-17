# Agent User Doc Preset

![Version](https://img.shields.io/badge/version-0.1.2-blue)

A portable bundle to make agents write good user docs. It ships two standard Agent Skills and one optional agent definition. Only `scan-user-docs` is self-contained. Typical output size for the whole generated contract set is about `2,000` to `5,000` tokens, depending on repo complexity.

## Includes

- `skills/scan-user-docs/`: scans a docs repo, writes readable Markdown-KV contracts under `.agents/docs-preset/`, and creates or updates `AGENTS.md` so downstream agents can find all four contract files. Run after you install the preset or this skill alone.
- `skills/maintain-user-docs/`: stateless guidance for writing, editing, reviewing, and restructuring user-facing docs. Includes English STE100-inspired basics and Russian controlled technical writing basics. It does not write or discover repo facts on its own, so for repo-aware work it should be used after `scan-user-docs` has written contracts.
- `agent/documentation-writer.md`: optional agent definition focused on day-to-day docs work. Use it directly in OpenCode or adapt it to another harness. It is contract-driven: it depends on `scan-user-docs` for repo facts and uses `maintain-user-docs` for doc types, defaults, checklists, readability profiles, and markup cautions.
- `REQUIREMENTS.md`: implementation-aligned reference for this repo. Users can use it to recreate only the parts they consider important.

Optional wrappers:

- `command/scan-docs.md`
- `command/check-docs.md`

## Install With An Agent

This is the fastest path.

1. Open your documentation repo in your agent.
2. Ask it to install the preset:

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

3. Run the scan skill:

```text
Use `scan-user-docs` to scan this repo and write documentation contracts.
```

4. For normal docs work, use the writing and review skill:

```text
Use `maintain-user-docs` to review or rewrite this page.
```

## Install Manually

You can download a release zip or tar.gz from GitHub Releases or clone the repo.

Release page:

- `https://github.com/AlexJameson/agent-user-doc-preset/releases`

#### Skills

Place these folders in your project:

- `skills/scan-user-docs/` -> `.agents/skills/scan-user-docs/`
- `skills/maintain-user-docs/` -> `.agents/skills/maintain-user-docs/`

You can do this with your file manager or by terminal.

File-manager approach:

- unpack the release zip or tar.gz, or open the cloned repo
- drag `skills/scan-user-docs/` into `.agents/skills/`
- drag `skills/maintain-user-docs/` into `.agents/skills/`

Example:

```sh
PRESET=/path/to/agent-user-doc-preset
mkdir -p .agents/skills
cp -r "$PRESET/skills/scan-user-docs" "$PRESET/skills/maintain-user-docs" .agents/skills/
```

Then run:

```text
Use `scan-user-docs` to scan this repo and write documentation contracts.
```

#### Optional Agent Definition

If your harness supports repository agent definitions, install the bundled agent definition too.

OpenCode path:

- `agent/documentation-writer.md` -> `.opencode/agent/documentation-writer.md`

OpenCode command paths:

- `command/scan-docs.md` -> `.opencode/command/scan-docs.md`
- `command/check-docs.md` -> `.opencode/command/check-docs.md`

Terminal example:

```sh
PRESET=/path/to/agent-user-doc-preset
mkdir -p .opencode/agent .opencode/command
cp "$PRESET/agent/documentation-writer.md" .opencode/agent/documentation-writer.md
cp "$PRESET/command/scan-docs.md" "$PRESET/command/check-docs.md" .opencode/command/
```

For Claude Code, pi, or another harness, use `agent/documentation-writer.md` as source material and ask an agent to rewrite it into that harness's repo-local agent, prompt, or rules format.

## `scan-user-docs` Skill

`scan-user-docs` is self-contained. It writes the contracts and patches `AGENTS.md` so generic agents can consume them without extra setup.

After the scan writes contracts, it can ask a few maintainer follow-up questions in chat. Those questions should not be written into contract files unless the maintainer answers them and wants the contracts updated.

#### What `scan-user-docs` Writes

- `AGENTS.md`
- `.agents/docs-preset/MANIFEST.md`
- `.agents/docs-preset/TOOLING.md`
- `.agents/docs-preset/STYLE.md`
- `.agents/docs-preset/STRUCTURE.md`

`MANIFEST.md` is mandatory. `AGENTS.md` is an activation aid only. Contract facts stay in `.agents/docs-preset/`. The generated `AGENTS.md` section should stay minimal and point to contracts rather than repeating their content.

`skills/scan-user-docs/templates/` contains the contract and `AGENTS.md` template shapes used by the scan skill.

#### Scan Strategy

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

## Contract Format and Vocabulary

Contracts use Markdown-KV.

Markdown-KV is plain Markdown with information organized in a consistent record-and-field shape. It is meant to stay human-readable first, while still being easy for agents to scan, compare, and update safely.

- Headings define records.
- `key: value` lines define fields inside those records.
- Normal Markdown prose can still appear where it helps readability.

Common terms:

- `surface`: a concrete documentation file or directory with a defined purpose, audience, and edit boundary.
- `zone`: a logical documentation area that may span multiple surfaces and helps agents place or move content.
- `rule`: a repo-specific instruction about placement, editing, or avoidance.
- `safety`: the expected side-effect level of running a documented command.
- `edit_safety`: the expected caution level for editing a documented file or directory.

Current `safety` and `edit_safety` values are controlled vocabulary by convention, not a strict schema enum. The default templates use compact values such as `local`, `external-side-effect`, `unknown`, `editable`, `ask-first`, `generated`, and `locked`. Repos may extend them when a sharper distinction is useful.
