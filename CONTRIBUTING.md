# Contributing

Thanks for helping make AI-built interfaces better.

## Good contributions
- A new or better recipe in `skills/design-craft/references/recipes.md` (tested in a real browser, with reduced-motion handling).
- Sharper rules for a surface in `surfaces.md` (with the reason).
- Fixes to companion install commands in `companions.md` and `scripts/setup.sh`.
- Sourced corrections to `references/research-2026-10.md` (link the source; mark unverified claims).

Changes to `taste-profile.md` are personal: keep them in your fork rather than a PR.

## Before you open a PR
1. Keep `SKILL.md` under about 500 lines; long material goes in `references/`.
2. Run `claude plugin validate .` from the repo root.
3. If you touched `scripts/setup.sh`, run it twice (the second run must skip everything) and run `bash -n scripts/setup.sh`.
4. Add a line to `CHANGELOG.md` and bump `version` in `.claude-plugin/plugin.json` for user-visible changes.
5. Never commit API keys, tokens or personal data.
