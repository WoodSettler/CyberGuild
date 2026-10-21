# CyberGuild

**English** | [简体中文](README.zh-CN.md)

A lightweight AI agent guild for Claude Code, Codex, and DeepSeek Harness. Assign persistent identities across tools, collaborate through a project QuestBoard, and load context only when needed.

## Install

```sh
npx skills add WoodSettler/CyberGuild --skill guild-appoint -a claude-code codex -g
```

Choose **Symlink** to share one installed package. The skills installer places the shared copy in `~/.agents/skills/guild-appoint`; Claude Code links to it. Installation is not an appointment.

For DeepSeek Harness on Windows, connect its native skills directory to that same copy:

```powershell
& "$HOME\.agents\skills\guild-appoint\scripts\connect-dsh.ps1"
python -X utf8 "$HOME\.agents\skills\guild-appoint\scripts\check-install.py"
```

The adapter is idempotent. An existing different installation is preserved outside the skills directory, under `skill-backups`; a failed link creation attempts restoration. Use `-Source` and `-SkillsDirectory` for custom paths. This adapter targets Windows. We do not claim that the upstream installer supports an `-a dsh` option.

## Appoint a member

> Use guild-appoint. I appoint you as Aster in this project.

The user chooses the identity, not the harness or model. Only the entrypoint, roster summary and project membership are loaded initially. Profiles, messages and protocol details are opened on demand. Responses can follow the user's language.

| Member | Default specialty |
| --- | --- |
| Claire — Chief Thought Officer | Problem framing, valuable ideas and consequential decisions |
| Aster — Chief Realization Officer | Sustainable implementation plans, staged assignments and goal alignment |
| Seek — Chief Exploration Officer & Execution Officer | Precise execution, intelligence gathering and synthesis |

These public profiles describe defaults, not capability restrictions or a hierarchy. Users may explicitly supply a custom roster. User instructions override peer assignments within their stated scope; affected colleagues must be informed.

## Self-contained package

All runtime resources live in [skills/guild-appoint](skills/guild-appoint): the entrypoint, public roster and profiles, QuestBoard protocol, templates, and optional installation helpers. Copying this directory does not require the source repository. Project appointments and messages stay in the target workspace, outside the installed package.

QuestBoard uses a message index and one Markdown file per message. Its membership rules are behavioral conventions, not filesystem access controls. There is no background daemon, automatic wake-up or task scheduler. OrKi can remain a separate execution tool.

## Verify, update and remove

The checker validates package completeness, internal links and identical content across all three installations, and reports whether they resolve to one shared target. It does **not** prove native harness discovery or model behavior.

Run `npx skills update`, then rerun the checker. Before removing the shared package, unlink DSH to avoid a dangling link. On Windows, after confirming the DSH path is a junction, `[IO.Directory]::Delete("$HOME\.dsh\skills\guild-appoint")` removes the junction only. Never recursively delete its target to uninstall a link.

Live-session acceptance remains separate: explicitly invoke the skill in a temporary project; inspect actual tool reads; verify minimal context, no unsolicited colleague appointments, and scoped user overrides with notification. These behaviors are not yet certified across all three harnesses.

## Languages and scope

English and Chinese project guides link to each other. Runtime instructions remain a single Chinese source to avoid conflicting translated protocols. This release provides bilingual documentation, not a localized UI or a second runtime rule set.

Source: [skills installer](https://github.com/vercel-labs/skills). DSH uses the local `~/.dsh/skills` convention supplied by its user; native discovery still requires live verification.