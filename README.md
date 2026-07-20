# agent-doc-preset

A portable documentation preset for AI coding agents. It helps a founder or a
small writing team create and maintain user-facing docs without configuring
agents by hand: repo tooling is discovered, writing conventions are recorded as
editable contracts, and the primary agent does the day-to-day work.

**v1 scope: OpenCode only.** One primary agent, two skills, and two slash
commands.

## Quick Start

### Option A: Copy Files Manually

1. Clone this preset repo:

```sh
git clone https://github.com/AlexJameson/agent-doc-preset.git
```

2. Open a terminal in your documentation project root.

3. Copy the preset files:

```sh
PRESET=/Users/alexjameson92/Desktop/repos/agent-doc-preset
mkdir -p .opencode/agent .opencode/command .agents/skills
cp "$PRESET/agent/documentation-writer.md" .opencode/agent/documentation-writer.md
cp "$PRESET/command/scan-docs.md" "$PRESET/command/check-docs.md" .opencode/command/
cp -r "$PRESET/skills/good-docs" "$PRESET/skills/docs-env-scan" .agents/skills/
```

4. Open OpenCode, switch to the **documentation-writer** agent, and run:

```text
/scan-docs
```

5. Confirm the detected setup. The scan creates `.agents/docs-preset/` contracts
that future docs tasks will use.

### Option B: Ask An Agent To Install

1. Open your documentation project in OpenCode.

2. Ask the agent:

```text
Install the documentation preset from https://github.com/AlexJameson/agent-doc-preset into this repo.
Clone the preset if needed, copy the OpenCode agent, commands, and skills, then tell me when it is ready. Do not run the scan yet.
```

3. Switch to the **documentation-writer** agent.

4. Run:

```text
/scan-docs
```

5. Confirm the detected setup.

## Preset Files

- `agent/documentation-writer.md` is the OpenCode primary agent. It reads repo
  contracts, writes/reviews user-facing docs, preserves local conventions, and
  calls the skills when it needs docs knowledge or environment scanning.
- `command/scan-docs.md` is the `/scan-docs` command. It runs the environment
  scan and requires the four-file contract set: `MANIFEST.md`, `TOOLING.md`,
  `STYLE.md`, and `STRUCTURE.md`.
- `command/check-docs.md` is the `/check-docs` command. It reviews a file or
  directory against the active contracts and writing rules without editing unless
  the user asks for fixes.
- `skills/docs-env-scan/` is the state-producing scan skill. It detects docs
  tooling, user-facing surfaces, style signals, generated outputs, and compact
  structure, then writes Markdown-KV contracts.
- `skills/docs-env-scan/templates/` contains the contract shapes used by the
  scanner. `MANIFEST.md` is mandatory; the other templates are adapted to the
  target repo.
- `skills/good-docs/` is the stateless documentation knowledge skill. It provides
  doc type guidance, review checklists, style defaults, markup cautions, and
  contract-extension guidance.
- `REQUIREMENTS.md` is the implementation-aligned reference for this preset repo.
  It is not copied into target documentation repos.

## Manual Install

```sh
# from your project root
mkdir -p .opencode/agent .agents/skills
cp agent/documentation-writer.md .opencode/agent/documentation-writer.md
cp -r skills/good-docs skills/docs-env-scan .agents/skills/
mkdir -p .opencode/command
cp command/scan-docs.md command/check-docs.md .opencode/command/
```

## First run

Open OpenCode, switch to the **documentation-writer** agent (Tab), and ask for a
docs task or run `/scan-docs`. On first run the agent proposes what it found and,
once you confirm, writes the required Markdown-KV contract set:

- `MANIFEST.md` — registry of active contract files.
- `TOOLING.md` — how we build and what is safe to edit.
- `STYLE.md` — how we write, including placeholders for team-specific rules.
- `STRUCTURE.md` — user-facing documentation surfaces, lightweight zones, and
  placement rules.

From then on, just ask for doc work. The agent reads the contracts, follows
them, and tells you when reality drifts from them. It treats Markdown as the
default source format but preserves detected MDX, reST, AsciiDoc, or mixed-format
conventions.

You can also use slash commands:

- `/scan-docs` — scan or re-scan docs contracts.
- `/check-docs path/to/file.md` — review a file or directory against existing
  contracts.

## Status

v1 portable preset. V2/V3 items such as scoring, export pipelines, product-type
template packs, reviewer subagents, and platform integrations are intentionally
absent.
