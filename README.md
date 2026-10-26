# design-craft

Personal Claude Code plugin of Muhammad Ahsan. One skill, `design-craft`, that makes every interface he builds look 2026-level: responsive on every screen, premium, smooth, with scroll effects, tasteful 3D and Apple Liquid Glass where it fits, and none of the generic AI-made look.

It covers every surface (landing page, chatbot window, login/signup, forms, buttons, dashboards, docs) and orchestrates companion skills (`frontend-design`, `emil-design-eng`, `apple-design`, `ui-ux-pro-max`, `web-design-guidelines`, `impeccable`, GSAP and Three.js skills), installing any that are missing.

## Use

In any project, tell Claude:

> use design-craft and polish this UI/UX

or just "design this" / "make it look modern". It audits all screens, shows a plan, builds in passes with before/after screenshots, and reports.

## Install (new machine)

Needs Claude Code, Node 20+, Git Bash on Windows, and `gh auth login` (the repo is private).

```bash
claude plugin marketplace add Ahsuu27488/design-craft
claude plugin install design-craft@design-craft --scope user
bash ~/.claude/plugins/marketplaces/design-craft/scripts/setup.sh
```

The setup script installs the core companion skills user-wide (the skill also runs it by itself on first use). Restart Claude Code afterwards.

On this PC the marketplace points at the local folder `C:\dev\design-craft`, so edits apply after `claude plugin marketplace update design-craft`.

## Layout

```
.claude-plugin/        plugin.json, marketplace.json
skills/design-craft/
  SKILL.md             workflow, which skill does what, rules, checklist
  taste-profile.md     what the owner likes and dislikes (edit this as taste evolves)
  surfaces.md          rules per screen type + mandatory responsive rules
  companions.md        companion skills, when to use, install commands
  references/          craft.md (techniques), recipes.md (code), research-2026-10.md (sources)
scripts/setup.sh       installs core companions, idempotent
```

## Updating taste

Add new feedback to `skills/design-craft/taste-profile.md`, new research to `references/`, bump the version in `.claude-plugin/plugin.json`, note it in `CHANGELOG.md`, commit and push.
