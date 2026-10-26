# Companion skills

design-craft orchestrates these. **Core** ones are installed by `scripts/setup.sh` on first run. **On-demand** ones are installed the moment a task needs them: install, then use, then tell the user in one line. Never skip a needed companion because it is missing.

All were checked on GitHub on 2026-10-27 (stars, licence, last push). Stars are GitHub API numbers on that date; social-media star claims are unreliable.

Install tool for plain skills: the `skills` CLI (`npx -y skills add <repo> -s <skill> -g -a claude-code -y --copy`). `-g` = user-wide, `--copy` avoids Windows symlink trouble. Plugins: `claude plugin marketplace add <repo>` then `claude plugin install <plugin>@<marketplace> --scope user` (the CLI works from a shell; in-chat `/plugin` commands are the same thing for a person).

## Core (setup.sh installs these)

| Skill | Repo (licence, stars) | Use for | Install |
|---|---|---|---|
| `frontend-design` | anthropics/claude-plugins-official (Anthropic) | Direction, typography, avoiding AI tells, one orchestrated moment | `claude plugin install frontend-design@claude-plugins-official --scope user` |
| `emil-design-eng` | emilkowalski/skills (MIT, ~50k) | UI motion and polish rules | `npx -y skills add emilkowalski/skills -s emil-design-eng -g -a claude-code -y --copy` |
| `apple-design` | emilkowalski/skills | Springs, gestures, sheets, interruptible motion, materials (WWDC talks for the web) | same repo, `-s apple-design` |
| `review-animations` | emilkowalski/skills | Reviewing existing animations | same repo, `-s review-animations` |
| `web-design-guidelines` | vercel-labs/agent-skills (~33k) | Final review: fetches Vercel's live rules, reports `file:line` | `npx -y skills add vercel-labs/agent-skills -s web-design-guidelines -g -a claude-code -y --copy` |
| `impeccable` | pbakaus/impeccable (Apache-2.0, ~89k) | audit, critique, polish, bolder/quieter, DESIGN.md | `npx -y skills add pbakaus/impeccable -s impeccable -g -a claude-code -y --copy` |
| `ui-ux-pro-max` | nextlevelbuilder/ui-ux-pro-max-skill (MIT, ~141k) | Search 79 styles, 192 palettes, 74 font pairings, 119 UX rules, GSAP presets. Suggestions, not orders | `claude plugin marketplace add nextlevelbuilder/ui-ux-pro-max-skill` then `claude plugin install ui-ux-pro-max@ui-ux-pro-max-skill --scope user` |

## On-demand (install when the task needs it)

| Need | Skill(s) | Install |
|---|---|---|
| Pinned scroll stories, scrub, SplitText, GSAP in React | `gsap-scrolltrigger`, `gsap-react`, `gsap-performance`, `gsap-plugins` (greensock/gsap-skills, MIT, official) | `npx -y skills add greensock/gsap-skills -s gsap-scrolltrigger -s gsap-react -s gsap-performance -s gsap-plugins -g -a claude-code -y --copy` |
| 3D hero, R3F, shaders | `threejs-react-three-fiber`, `threejs-performance`, `threejs-shaders`, `threejs-postprocessing` (CloudAI-X/threejs-skills, MIT) | `npx -y skills add CloudAI-X/threejs-skills -s threejs-react-three-fiber -s threejs-performance -s threejs-shaders -s threejs-postprocessing -g -a claude-code -y --copy` |
| Janky animation, memory leaks, offscreen loops | `optimize-web-animations` (MengTo/Skills, MIT) | `npx -y skills add MengTo/Skills -s optimize-web-animations -g -a claude-code -y --copy` |
| Exact polish values (radius, optical alignment, colour, type) | `better-ui`, `better-typography`, `better-colors` (jakubkrehel/skills, MIT) | `npx -y skills add jakubkrehel/skills -s better-ui -s better-typography -s better-colors -g -a claude-code -y --copy` |
| React View Transitions in Next.js | `react-view-transitions` (vercel-labs/agent-skills) | `npx -y skills add vercel-labs/agent-skills -s react-view-transitions -g -a claude-code -y --copy` |
| Motion (Framer Motion) current docs + MCP | Motion AI Kit (`motion-ai` npm) | `npx -y motion-ai` (also configures Motion's hosted MCP servers: tell the user first) |
| Ready components from 21st.dev | 21st plugin (skill + 21st MCP; free tier ~2 components/day) | `claude plugin marketplace add 21st-dev/claude-code-plugin` then `claude plugin install 21st@21st --scope user` (needs your 21st account key in an environment variable, never in files) |
| "Make it look like <brand>" | awesome-design-md (VoltAgent, MIT, ~124k): DESIGN.md files of Apple, Linear, Stripe, Airbnb... | No install: fetch the brand's DESIGN.md from the repo and use it as a reference, adapted, never copied 1:1 |
| Editorial flat minimal look | `design-taste-frontend` (Leonxlnx/taste-skill) | **Only when the user explicitly asks for that look.** `npx -y skills add Leonxlnx/taste-skill -s design-taste-frontend -g -a claude-code -y --copy` |

## Checked and not used (and why)

- ConardLi/garden-skills `web-design-engineer`: generic, overlaps frontend-design + this skill.
- elayadesign/ai-design-skills `landing-page-design`: good structure/copy ideas (already folded into `surfaces.md`), but its strict visual rules push the flat minimal look.
- Owl-Listener/designer-skills: design-process skills (personas, research, sprints), not interface building.
- MengTo 3D material skills: very specific scenes; take only when a task matches one.

## Updating

`npx -y skills update -g -y` updates CLI-installed skills; `claude plugin marketplace update` then reinstall updates plugins. Re-run `scripts/setup.sh --force` after changing the core list here.
