#!/usr/bin/env bash
# design-craft setup: installs the core companion skills user-wide.
# Safe to re-run: anything already installed is skipped. --force re-checks even if the marker exists.
# Usage: bash scripts/setup.sh [--force]
set -u

MARKER_DIR="$HOME/.claude/design-craft"
MARKER="$MARKER_DIR/setup-v1.done"
SKILLS_DIR="$HOME/.claude/skills"
FORCE=0
[ "${1:-}" = "--force" ] && FORCE=1

if [ -f "$MARKER" ] && [ "$FORCE" -eq 0 ]; then
  echo "design-craft: setup already done ($MARKER). Use --force to re-check."
  exit 0
fi

installed=()
skipped=()
failed=()

have_skill() { [ -f "$SKILLS_DIR/$1/SKILL.md" ]; }

have_plugin() {
  command -v claude >/dev/null 2>&1 || return 1
  claude plugin list 2>/dev/null | grep -q "$1"
}

add_skill() { # repo skill
  local repo="$1" skill="$2"
  if have_skill "$skill"; then skipped+=("$skill"); return; fi
  echo "Installing skill $skill from $repo ..."
  if npx -y skills add "$repo" -s "$skill" -g -a claude-code -y --copy >/dev/null 2>&1 && have_skill "$skill"; then
    installed+=("$skill")
  else
    failed+=("$skill (npx -y skills add $repo -s $skill -g -a claude-code -y --copy)")
  fi
}

add_plugin() { # marketplace-repo-or-empty plugin@marketplace
  local mrepo="$1" id="$2"
  if have_plugin "$id"; then skipped+=("$id"); return; fi
  if ! command -v claude >/dev/null 2>&1; then
    failed+=("$id (claude CLI not on PATH; run in chat: /plugin install $id)"); return
  fi
  echo "Installing plugin $id ..."
  if [ -n "$mrepo" ]; then claude plugin marketplace add "$mrepo" >/dev/null 2>&1; fi
  if claude plugin install "$id" --scope user >/dev/null 2>&1; then
    installed+=("$id")
  else
    failed+=("$id (claude plugin install $id --scope user)")
  fi
}

if ! command -v npx >/dev/null 2>&1; then
  echo "design-craft: npx (Node.js) not found. Install Node 20+ and re-run."; exit 1
fi

add_plugin ""                                       "frontend-design@claude-plugins-official"
add_skill  emilkowalski/skills                      emil-design-eng
add_skill  emilkowalski/skills                      apple-design
add_skill  emilkowalski/skills                      review-animations
add_skill  vercel-labs/agent-skills                 web-design-guidelines
add_skill  pbakaus/impeccable                       impeccable
add_plugin nextlevelbuilder/ui-ux-pro-max-skill     "ui-ux-pro-max@ui-ux-pro-max-skill"

echo
echo "design-craft setup"
echo "  installed: ${installed[*]:-none}"
echo "  already there: ${skipped[*]:-none}"
if [ "${#failed[@]}" -gt 0 ]; then
  echo "  FAILED (run these yourself):"
  for f in "${failed[@]}"; do echo "    - $f"; done
  echo "Marker not written, so setup will run again next time."
  exit 2
fi

mkdir -p "$MARKER_DIR"
date -u +"%Y-%m-%dT%H:%M:%SZ" > "$MARKER"
echo "Done. New skills load in the next Claude session (or after /reload-plugins)."
