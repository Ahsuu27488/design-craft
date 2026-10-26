---
name: design-craft
description: A complete design system for Claude Code. Use it whenever you create, design, redesign, restyle, polish or review ANY user interface in any project: websites, landing pages, portfolios, demos, web apps, dashboards, chatbot/chat windows, login and signup screens, forms, buttons, settings, docs sites, tools, extensions, or when the user says "design", "polish this UI/UX", "make it look good/premium/modern/2026", "make it look like X", or a page looks generic, AI-made, flat or old. Covers direction, responsive layout (mandatory on every screen), typography, colour, components, motion, smooth scroll, scroll effects, tasteful 3D, Apple Liquid Glass, accessibility and performance, and orchestrates the companion skills (frontend-design, emil-design-eng, apple-design, ui-ux-pro-max, web-design-guidelines, impeccable, GSAP/Three.js skills), installing any that are missing.
---

# design-craft

Nobody should have to explain "make it modern" again. This skill knows the user's taste (`taste-profile.md`), what a 2026-level interface looks like, and which companion skill to call for each part. Follow it end to end; do not stop at the landing page.

Files next to this one (read only what the step needs):
- `taste-profile.md`: what the user likes and dislikes (ships with the author's taste; edit it to yours). **Read first, every time.**
- `surfaces.md`: rules per screen type (landing, chat window, auth, forms, buttons, app/dashboard, docs) and the **mandatory responsive rules**.
- `references/craft.md`: techniques, defaults, which library for which effect, 3D, Liquid Glass, performance and accessibility budgets.
- `references/recipes.md`: copy-paste code.
- `references/research-2026-10.md`: the evidence and sources.
- `companions.md`: the companion skills, when to use each, how to install them.

## Step 0: setup (first run on a machine, and whenever a companion is missing)

1. If `~/.claude/design-craft/setup-v1.done` does not exist, run the setup script once:
   `bash "${CLAUDE_PLUGIN_ROOT}/scripts/setup.sh"`. If that variable is empty, the script is two folders up from this file: `<this skill's directory>/../../scripts/setup.sh`. On Windows it runs in Git Bash. It installs the core companions globally and writes the marker. Tell the user in one line what it installed.
2. During any task, if you need a companion that is not installed (for example GSAP skills for a pinned scroll story, Three.js skills for a 3D hero), **install it, then use it**. Never skip a needed companion because it is missing, and never fall back to guessing. Commands are in `companions.md`. Afterwards tell the user in one line what you installed.
3. If an install fails (no network, needs a slash command), continue with this skill's own references and tell the user the exact one-line command to run.

## Step 1: understand the project

- Read the project's own CLAUDE.md / AGENTS.md / DESIGN.md / PRODUCT.md and any design tokens or theme files first. **The project's brief and an existing brand always win** over defaults here.
- Find every user-facing surface, not just the home page: list routes/pages, the chat widget, auth pages, modals, forms, empty/error/loading states, emails if any. Write the list.
- Classify each surface by mode (see `surfaces.md`): **Experience / Persuade** (landing, portfolio), **Operate** (app, dashboard, chat, auth, settings), **Read** (docs, articles).
- Take **"before" screenshots** of each main surface at 375, 768 and 1440 px (Playwright or the browser pane) and save them (e.g. `design-craft/before/`), so the result can be compared.

## Step 2: audit and plan (show it, get a yes)

- Audit each surface against `taste-profile.md`, `surfaces.md` and the checklist below. For a quick systematic pass also run `web-design-guidelines` on the main files.
- Write a short plan: the one-sentence direction (who it is for, the feeling, the **one signature idea**), the token decisions (type pairing, palette, radius, spacing, motion tokens), and per surface the top fixes. Use `frontend-design` for the direction and `ui-ux-pro-max` to search palettes and font pairings for the product type (treat its results as suggestions, not orders).
- Show the plan to the user and wait for approval before large changes. Small polish can go straight ahead.

## Step 3: build in passes (screenshot after each pass)

1. **Tokens and typography**: CSS variables / Tailwind theme for colour (OKLCH), type scale (fluid `clamp()`), spacing scale, radius, shadows, motion tokens. Replace hard-coded values.
2. **Layout and responsive**: every surface works at 320 to 1920 px per `surfaces.md`. Fix this before anything decorative.
3. **Components**: buttons, inputs, forms, cards, nav, chat window, modals, toasts, empty/loading/error states, all in one consistent system with every state (hover, focus-visible, active, disabled, loading).
4. **Motion**: UI feedback with `emil-design-eng` rules; springs and gestures with `apple-design`; scroll and smooth-scroll from `references/craft.md` (+ GSAP skills when pinning or sequencing).
5. **Signature moment** (landing/Experience only): one hero idea: shader, 3D, scroll story or kinetic type. Lazy, with a static fallback.
6. **Polish**: optical alignment, concentric radii, tabular numbers, copy (verbs on buttons, helpful errors), dark mode if the project has one.

After each pass: screenshots at 375 / 768 / 1440, look at them yourself, fix the top 3 problems, max 3 rounds per pass. For scroll pages, step through 0/25/50/75/100% of the scroll (`references/recipes.md` section 11). Reuse the project's components and libraries; do not add a new UI framework without asking.

## Step 4: verify and report

- `web-design-guidelines` review on changed files and `impeccable audit` (or `/impeccable audit`) if installed; fix or explain each finding.
- Lighthouse mobile (LCP <= 2.5 s, INP <= 200 ms, CLS <= 0.1), keyboard-only pass, `prefers-reduced-motion` emulation, dark mode if present, console clean.
- Report: what changed per surface, before/after screenshots side by side, checklist pass/fail, numbers, what was skipped and why, and which companions were used or installed.
- Follow the project's own rules for branches, commits and docs.

## Which skill does what (call them by name; installing is not enough)

| Need | Use |
|---|---|
| Direction, typography choice, avoiding AI "tells" | `frontend-design` |
| Palettes, font pairings, product-type style, UX rule lookup | `ui-ux-pro-max` (search script) |
| UI motion rules, polish details | `emil-design-eng` |
| Springs, gestures, sheets, drag, fluid Apple-style motion, materials | `apple-design` |
| Techniques: Lenis, ScrollTrigger, CSS scroll-driven, View Transitions, 3D, Liquid Glass, budgets | this skill: `references/craft.md` + `recipes.md` |
| GSAP details (pin, scrub, SplitText, React cleanup) | `gsap-scrolltrigger`, `gsap-react`, `gsap-performance` |
| Three.js / R3F details | `threejs-react-three-fiber`, `threejs-performance`, `threejs-shaders` |
| Janky animation, memory leaks, offscreen loops | `optimize-web-animations` |
| Final review with file:line findings | `web-design-guidelines` |
| Audit, critique, bolder/quieter, design-system docs | `impeccable` |
| Ready components (hero, nav, chat, bento) | 21st.dev (MCP/plugin) or Aceternity / Magic UI, always restyled |
| Editorial, flat, minimal art direction | `design-taste-frontend` **only if the user asks for that look** |

If two skills disagree: the project brief wins, then `taste-profile.md`, then this file, then the companion.

## Rules that never bend

- **Responsive is mandatory on every surface** (`surfaces.md`): no horizontal scroll at 320 px, readable type, 44 px targets, layouts that reflow, not just shrink.
- UI feedback under 300 ms; entrances 500 to 1200 ms once; scroll-linked motion scrubbed. Only transform/opacity (plus clip-path and small filters). `prefers-reduced-motion` always honoured.
- Glass only on the floating layer (nav, dock, toolbar, modal, chat composer, primary CTA), never glass-on-glass, never behind long text; solid fallback for reduced transparency.
- Real text in HTML, visible focus, contrast 4.5:1 body / 3:1 large, labels on every input.
- No invented testimonials, logos, numbers or reviews; demo content is labelled as a demo.
- No secrets or API keys in files or screenshots.

## Pre-ship checklist (paste into the report, mark honestly)

- [ ] Every surface listed in Step 1 was polished, not only the landing page
- [ ] 320 / 375 / 768 / 1024 / 1440 / 1920 checked; no horizontal scroll; nav, chat window, forms and tables reflow
- [ ] One direction and one signature idea; matches `taste-profile.md`; none of the AI tells in `frontend-design`
- [ ] Tokens: type scale, OKLCH palette with one accent, spacing scale, radius system, motion tokens
- [ ] All component states: hover, focus-visible, active, disabled, loading, error, empty
- [ ] Motion rules met; reduced motion handled; no scroll hijacking; smooth scroll only on Experience/Persuade pages
- [ ] Glass rules met; contrast checked on the worst background
- [ ] 3D/heavy effects lazy-loaded, DPR capped, static fallback on mobile and reduced motion
- [ ] Lighthouse mobile numbers recorded and within budget; keyboard pass done; console clean
- [ ] Before/after screenshots delivered side by side
