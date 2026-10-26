# Modern web UI/UX in 2026: what the best sites and developers do

Date: 2026-10-26. Public web only, no logins. Method: I fetched primary sources where they loaded (Apple WWDC25 session, MDN browser-compat data, Chrome docs, Lenis and GSAP docs, Motion docs, Awwwards pages, 21st.dev listing pages) and used search write-ups for the rest. Every claim is tagged:

- **[V]** verified in a page I opened.
- **[S]** from a search result or secondary write-up (blog, tutorial). Treat as likely, check before relying on it.
- **[K]** my own general knowledge, not checked in this session.

Honest gaps (see section 12): Apple's own HIG page is JavaScript-rendered and came back empty, so Liquid Glass rules come from Apple's WWDC25 session transcript plus secondary guides. godly.website, siteinspire, land-book, One Page Love, Framer and Webflow showcases would not load or returned nothing useful. X, Threads and Instagram are not reachable without logins, so section 11 is thin and says so.

This is the evidence behind the design-craft skill (`SKILL.md`, `craft.md`, `recipes.md`).

---

## 1. What "2026-level" means (the pattern across all sources)

1. **One hard idea per site.** The strongest 3D sites commit to a single concept and build everything around it: Oryzo sells one cork coaster, Hubtown has one lit monolith, Cartier gives each watch its own room. [S: Utsubo, section 5]
2. **Scroll is the narrative device.** Four of eight showcased Three.js sites (Cartier, Shopify Editions, Sleep Well, Primland) use scroll to drive camera or sequence scenes. Each section is a beat: entrance, hold, exit. [S]
3. **Smooth scroll underneath, native scroll semantics kept.** Lenis wraps native scroll, so sticky, anchors and accessibility keep working. [V]
4. **Real depth, not decoration.** Inertia, weighted easing, true parallax, depth of field. Flat fades everywhere read as template. [S]
5. **Performance and accessibility are part of the craft.** Awwwards scores developers on animation, accessibility, WPO (performance), responsive design, semantics and markup. Even the 2025 Site of the Year scored only 7.0 on accessibility and 7.6 on WPO, so there is easy credit to win. [V: awwwards.com/sites/lando-norris]
6. **The platform now does a lot of it natively.** Scroll-driven animations, view transitions, `linear()` springs, `@starting-style`, anchor positioning and `text-wrap: balance` mean less JavaScript. [V/S, section 4]

## 2. Award winners (Awwwards)

Source: [Awwwards Sites of the Year](https://www.awwwards.com/websites/sites_of_the_year/) [V]. Winners by year (agency):

| Year | Winners |
|---|---|
| 2025 | Lando Norris (OFF+BRAND), Messenger (abeto) |
| 2024 | Igloo Inc (abeto), Don't Board Me (The First The Last), Opal Tadpole (Claudio Guglieri) |
| 2023 | Lusion v3 (Lusion), Noomo Agency, Mana Yerba Mate (Louis Paquet) |
| 2022 | KPR (Resn), The Other Side of Truth (The First The Last), Persepolis Reimagined (Monks, Getty) |
| 2021 | Pangram Pangram Foundry (Locomotive), Star Atlas (Hello Monday), Prometheus Fuels (Active Theory), Umami Land (Monks), Chungi Folio |
| 2019 | Bruno Simon Portfolio (Bruno Simon) |

Notes:
- Lando Norris (landonorris.com, OFF+BRAND): Awwwards tags it WebGL, GSAP, Webflow, 3D, Gestures/Interaction. Site of the Day 17 Nov 2025, overall 8.18; Developer Award scores: Animations/Transitions 8.60, WPO 7.60, Responsive 7.40, Semantics/SEO 7.40, Markup 7.40, Accessibility 7.00. [V] Cursor-reactive blob-like overlays animate across the hero image. [S: DesignRush] **Lesson: a Webflow + GSAP + WebGL stack can win; it is not only custom engines.**
- Messenger (messenger.abeto.co): a multiplayer browser game on a small spherical planet, built with WebGL and Three.js (no game engine), models made in Houdini and Blender. [S] I could not confirm from a page I opened whether it won Site of the Year or Site of the Day; the Awwwards SOTY page lists it under 2025 [V].
- Lusion and Active Theory both use heavy custom WebGL. I could not find reliable public detail on their engines or mobile fallbacks, so I do not claim any. [S: nothing confirmed]
- Judging weights quoted by one third-party source: design 40%, usability 30%, creativity 15%, content 15%. Another source disagrees on weighting. Check Awwwards' own page before quoting. [S]

## 3. Three.js sites of 2026, technique by technique

Source: [Utsubo, "8 Best Three.js Websites of 2026"](https://www.utsubo.com/blog/best-threejs-websites-2026) [S, I opened it]:

| Site | Technique | Takeaway |
|---|---|---|
| Oryzo (Lusion) | Single product in 3D, weighted inertial easing, scroll moves camera on Z | Sell one object well |
| IVRESS (Utsubo) | WebGPU renderer with WebGL fallback, shaders written once in TSL, budgeted scene graph | Write TSL now so WebGPU later is a config change |
| Lacoste Ace Breaker | Tennis brick-breaker, one verb, leaderboard, real prizes | A tiny game can beat a hero video |
| Shopify Editions Spring '26 | Scroll-sequenced story, particle-dispersing type, depth-layered panels | Each section is a staged moment |
| Hubtown (Unseen Studio) | Glowing 3D monolith, mouse-reveal of geometry and light, Three.js + GSAP | One lit centerpiece + one interaction = premium B2B |
| Sleep Well Creative | Scroll-driven illustrated 3D world | Editorial pacing works in 3D |
| Explore Primland | Aerial flythrough of real terrain with fog, scroll-driven camera | Make a place explorable |
| Cartier Watches & Wonders (Immersive Garden) | Six 3D alcoves, Three.js + GLSL + GSAP + Lenis, Web Audio score | Give each product its own room |

Performance practices it names: instancing, baked lighting, byte budgets set before modelling, Draco/Meshopt for geometry, KTX2 for textures, meaningful HTML first for SEO and Core Web Vitals, test on mid-range phones and in-app browsers, lighter fallback for weak devices. It also suggests a single full-viewport GLSL fragment shader behind clean type as a high-impact first project.

Codrops (the best tutorial source) in 2026 [S, titles only; the site returns 403 to my fetcher]:
- "80s Business Tech and Seamless Scene Transitions: Inside Shader.se's Scroll-Driven WebGPU Pipeline": Next.js + Three.js + React Three Fiber + TSL, Lenis modified for page snapping between Hero and Work scenes, selective scene rendering.
- "WebGPU Gommage Effect" (Jan 2026): MSDF text dissolving with a noise-driven TSL shader and selective bloom.
- Aug 2026: "Run Rob Run" (music-reactive scroll-driven morphing in WebGPU), "Relighting Images with Depth Maps" (depth map + TSL for lighting and self-shadow on flat images).
- Sep 2026 (social post only): a liquid-glass grid built with Three.js, WebGPU and TSL.

### WebGPU status (Sept 2026) [S: Utsubo migration guide, opened]
- On by default in Chrome and Edge (Windows, macOS, ChromeOS); Chrome Android 12+ on ARM/Qualcomm/Intel; Firefox on Windows and Apple Silicon only; Safari on Apple 26 OS releases. About 87% global support (caniuse Aug 2026, per the guide).
- `WebGPURenderer` falls back to WebGL 2 automatically. Check `renderer.backend.isWebGPUBackend`, not `renderer.isWebGPURenderer` (true on both). Treat WebGL 2 as a supported mode.
- TSL compiles to WGSL (WebGPU) and GLSL (WebGL 2). `ShaderMaterial`, `RawShaderMaterial` and `onBeforeCompile` do not work on `WebGPURenderer`; they need TSL ports. Post-processing moves from `EffectComposer` to `RenderPipeline`.
- Gains are not guaranteed: best for many draw calls, compute (particles, simulations), post chains. Texture upload, asset size and shader compile time do not improve. Some scenes get slower, so profile.
- Migrate for new projects and compute-heavy work; stay on WebGL for working apps and heavy custom GLSL.

```js
import * as THREE from 'three/webgpu';
const renderer = new THREE.WebGPURenderer({ antialias: true });
await renderer.init();
renderer.setAnimationLoop(() => renderer.render(scene, camera));
```

**Warning for viral "3D scroll" tutorials:** a TikTok breakdown found that one popular "cinematic" site was pre-rendered video with parallax and only a small compass in live Three.js. [S] Many effects are cheaper than they look. Prefer video or image sequences when the content is fixed. Apple's AirPods-style pages use a pre-rendered frame sequence drawn to a `<canvas>` with scroll choosing the frame. WebP cut one hero sequence from 21 MB to about 4 MB, and a 147-frame grid crashed on iPhones. [S: GSAP forum]

## 4. Scroll, motion and the platform

### 4.1 Lenis (smooth scroll) [V: github.com/darkroomengineering/lenis, v1.3.27]
- Install `npm i lenis`; CSS from `lenis/dist/lenis.css` (recommended; required for `autoToggle`). React package is `lenis/react`.
- Options and defaults: `lerp` 0.1 (overrides duration/easing when set), `duration` 1.2 s, `smoothWheel` true, `syncTouch` false (can be unstable on iOS below 16), `syncTouchLerp` 0.075, `autoRaf` false (otherwise call `lenis.raf` yourself), `anchors` false by default (enable with `anchors: true`).
- Reduced motion: `respectReducedMotion` defaults to true, forcing lerp to 1 and instant programmatic scrolls. Do not turn it off.
- GSAP sync (exact official pattern):

```js
const lenis = new Lenis();
lenis.on('scroll', ScrollTrigger.update);
gsap.ticker.add((time) => { lenis.raf(time * 1000); });
gsap.ticker.lagSmoothing(0);
```
- Known gotcha: a GSAP forum thread reports a scroll-linked header fading late with this sync. [S]

### 4.2 GSAP + ScrollTrigger + SplitText [V/S]
- **GSAP is 100% free including commercial use, and the old paid "Club" plugins (SplitText, MorphSVG, etc.) are now free** after Webflow's acquisition; install from the public `gsap` npm package, no tokens. SplitText was rewritten (about 50% smaller). [S: Webflow announcement and gsap README via search; verify on gsap.com/pricing]
- ScrollTrigger [V: gsap.com docs]: `scrub: true|seconds` (a number, e.g. `scrub: 1`, adds catch-up smoothing), `pin`, `snap` (default ease `power3`), `toggleActions` default `"play none none none"`, `once`, start/end `"triggerPoint scrollerPoint"` with defaults start `top bottom` (or `top top` with pin), end `bottom top`; `clamp()` in start/end (v3.12+); use `gsap.matchMedia()` (the ScrollTrigger one is deprecated); `ScrollTrigger.batch()` for groups; `invalidateOnRefresh`.
- Pitfalls from the docs: create triggers top-to-bottom; do not put `transform` or `will-change` on ancestors of pinned elements; do not animate the pinned element itself, animate its children; avoid `content-visibility:auto` on measured elements; kill triggers in React cleanup (`useGSAP` from `@gsap/react` does it).

### 4.3 Motion (formerly Framer Motion) [V: motion.dev docs]
- `whileInView` with `viewport={{ once: true }}`, `useInView`, `useScroll` (returns `scrollYProgress` 0 to 1; takes `target` and `offset`), `useTransform`, `useSpring`, `useMotionValueEvent`.
- Scroll-linked animations use the browser's native `ScrollTimeline` when possible, JavaScript otherwise. Scroll-triggered use a pooled `IntersectionObserver`. The `Ticker` marquee is paid (Motion+).
- 21st.dev scroll components (below) depend on `framer-motion`, so the same code works with the `motion` package (import from `motion/react` [K]).

### 4.4 CSS scroll-driven animations [V: MDN BCD + Chrome docs]
- `animation-timeline`, `scroll()`, `view()`: **Chrome/Edge 115, Firefox 159, Safari 26**, no flags. So by Oct 2026 all three engines ship them (the Firefox row is from MDN's browser-compat-data; older search results saying Firefox lacked it are out of date).
- Rules: `animation-duration: auto` for timelines; declare `animation-timeline` after the `animation` shorthand (the shorthand resets it); `animation-range: entry 25% cover 50%`; animate `transform`/`opacity`; they can run off the main thread.

```css
@keyframes reveal { from { opacity: 0; translate: 0 2rem } to { opacity: 1; translate: 0 0 } }
.reveal { animation: reveal linear both; animation-timeline: view(); animation-range: entry 0% cover 30%; }
@media (prefers-reduced-motion: reduce) { .reveal { animation: none } }
```
- Scroll-**triggered** (time-based, fires at a scroll boundary) animations are Chrome/Edge 146 only. [V: Chrome I/O 2026 page] Do not rely on them.

### 4.5 View Transitions [V: MDN BCD, Chrome docs]
- Same-document `document.startViewTransition()`: Chrome 111, Safari 18, Firefox 144. `types` (typed transitions): Chrome 125, Safari 18.2, Firefox 147.
- Cross-document (MPA) via `@view-transition { navigation: auto; }` plus `view-transition-name`: Chrome/Edge 126, Safari 18.2, **not Firefox**. [S: Chrome docs; MDN BCD file I fetched did not cover it]. Treat as progressive enhancement.
- Element-scoped view transitions: Chrome 147 only. [V]
- Interop 2026 focus areas include scroll-driven animations, view transitions (incl. cross-document), anchor positioning, scroll snap, and `shape()`. [V: web.dev] So support will keep converging.

### 4.6 Other platform features worth using [V/S]
| Feature | Use | Support note |
|---|---|---|
| `linear()` easing | Spring and bounce curves in pure CSS | Chrome 113, Firefox 112, Safari 17.2 [S] |
| `@starting-style` + `transition-behavior: allow-discrete` | Enter/exit animations from `display:none`, popovers, dialogs | Listed in Chrome I/O 2026 [V]; versions not given there |
| `sibling-index()` / `sibling-count()` | Staggered delays in CSS | Listed in Chrome I/O 2026 [V]; Chromium-first, check |
| `text-wrap: balance` (headings), `pretty` (paragraphs) | Better line breaks, no JS | `balance` broadly supported; `pretty` not in Firefox [S] |
| Anchor positioning | Tooltips, dropdowns | Chrome/Edge 125, Safari 26, Firefox 147 [S] |
| `oklch()`, `color-mix()`, `@layer`, nesting, `:has()` | Colour and structure | Safe to ship [S] |
| `corner-shape` (squircle), `border-shape` | Apple-like corners | Experimental, Chromium only [V]; do not depend on it |
| HTML-in-Canvas | Real DOM inside canvas shaders | Origin trial [V]; do not use for clients yet |
| `field-sizing: content` | Auto-growing textareas | Progressive enhancement [S] |

## 5. 21st.dev (component marketplace) [V: 21st.dev/community/components]

Catalog counts: Heroes 1,152, Backgrounds 365, Texts 663, Features 318, Calls to Action 501, Navigation Menus 477, Galleries 272, Testimonials 161, Pricing 216, Footers 65, Buttons 2,043, Cards 1,780, Forms 1,522, Inputs 949, Dropdowns 506, Toggles 532, Spinner Loaders 480, **AI Chats 248**, Cursors 152, Dashboards 400, Globes 41. No explicit 3D category.

Most popular (install counts):

| Component | Author | Uses |
|---|---|---|
| Scroll media expansion hero | @arunachalam | 10.7k |
| Container Scroll Animation (3D-tilting laptop/screen that rotates flat as you scroll; Aceternity UI, MIT, `framer-motion`) | @manuarora700 | 10.2k |
| Spline Scene | @serafimcloud | 9.5k |
| Spotlight Card (cursor-following light on a card) | @jahed | 8.8k |
| Radial Orbital Timeline | @jatin-yadav05 | 7.4k |
| Testimonials Columns (vertically scrolling columns) | @efferd | 7.1k |
| Liquid Glass Button | @designali-in | 6.7k |
| Scroll Morph Hero | @prashantsom75 | 6.2k |
| Animated hero | @tommyjepsen | 5.8k |
| Background Paths (animated SVG paths) | @kokonutd | 5.7k |

Newest: Liquid Glass Navbar (@gughigug), Mac Style Floating Dock (@themeocean), Holo Vinyl, Web Shot Button, FAQ Drawer, and three preloaders by @kedhareswer (statue, Indian doorway scroll, pixel-art footer). So **liquid glass, dock navs and preloaders are the live trends on the marketplace**.

Practical facts: components install with `npx shadcn@latest add "https://21st.dev/r/<author>/<name>?api_key=$API_KEY_21ST"`; free accounts have a daily install limit; Scroll Expansion Hero needs `next` + `framer-motion`; `https://21st.dev/llms.txt` lists the directory for agents. [V] The pages do not show source, so read the installed code. Per Aceternity/21st licences, components are MIT.

How to use 21st.dev well: take a component as a starting skeleton, then replace its default fonts, colours and copy, because popular ones (Background Paths, Spotlight Card) are everywhere and read as template if left untouched. Count: ~10k installs of the same scroll hero means visitors have seen it.

## 6. Apple Liquid Glass

### 6.1 What Apple actually says [V: WWDC25 "Meet Liquid Glass", developer.apple.com/videos/play/wwdc2025/219]
- A "meta-material" that bends and shapes light in real time. It is a **functional layer for controls and navigation floating above content**.
- **Lensing** (light is bent and concentrated; defines edges while staying transparent), **materialization** (elements appear by modulating lensing, not a plain fade), **fluidity** (flexes and lights up on touch; menus open from the button that triggered them; elements can lift into glass only on touch so the resting state stays quiet).
- Adaptivity: tint, shadow and range shift with content behind; shadows strengthen over text; small elements (tab bars, glyphs) can flip light/dark, large ones (sidebars, menus) don't flip; larger glass reads as thicker, with deeper shadow and stronger lensing.
- **Scroll edge effect**: content dissolves into the background under a control; over dark content it dims subtly; a "hard style" exists for pinned headers.
- **Regular** = default, adapts to anything, any size. **Clear** = permanently more transparent, no adaptivity, needs a dimming layer. Use Clear only if all three: over media-rich content, a dimming layer does not hurt the content, and the content above the glass is bold and bright. Never mix the two.
- Rules: only the navigation layer, not content layers (not a table, not cards); **no glass on glass**; for things on top of glass use fills/transparency/vibrancy, not another glass layer; avoid steady-state overlap of content and glass.
- Concentricity: glass controls nest into rounded corners so radii stay concentric.
- Tinting: selective, for primary actions; "tinting everything makes nothing stand out"; app colour belongs in the content layer.
- Accessibility adaptations: Reduced Transparency makes glass frostier; Increased Contrast makes it mostly black or white with a contrasting border; Reduced Motion lowers effect intensity and removes elasticity.
- Secondary guide adds: interactive targets 44 pt minimum, text 11 pt minimum. [S: giorgio-a11y/liquid-glass-guide, third-party, SwiftUI only]

### 6.2 On the web [V: LogRocket article opened; S for the rest]
- CSS alone can blur and tint (`backdrop-filter: blur() saturate() brightness()`) but **cannot refract**. Real lensing needs an SVG filter (`feImage` displacement map + `feDisplacementMap`, scale about 55, R and G channels, neutral value 128) referenced as `backdrop-filter: url(#filter)`.
- **`backdrop-filter: url(#svg)` works in Chromium only**; Safari and Firefox accept only built-in filter functions there. [V: LogRocket]
- Costs: each SVG backdrop filter uses GPU and compositing; many or large instances cause jank; filter maps assume fixed element size, so dynamic sizes are hard. Use on a few floating elements only (nav pill, primary button, one card or modal).
- So the production recipe is: **layered-CSS glass as the base for all browsers** (blur + saturate + tinted translucent fill + 1 px inner highlight border + soft outer shadow + faint specular gradient), and **SVG refraction as a Chromium-only enhancement behind `@supports`**. Always add a solid-ish fallback and honour `prefers-reduced-transparency` and `prefers-contrast`.
- For WebGL: a refraction material in Three.js (drei `MeshTransmissionMaterial`) gives true lensing on a 3D object; Codrops has a Sept 2026 WebGPU/TSL liquid-glass grid. [S]
- Packages exist (e.g. `@real-human/liquid-glass`, with graceful fallback to plain blur) [S]; check licences and size before use.
- Read Apple's rule as a web rule: glass for the floating layer (nav, dock, toolbar, modal, CTA), flat solid surfaces for content, never glass-on-glass, never full-page glass. 

## 7. Performance and Core Web Vitals

Thresholds (unchanged in 2026; field data, 75th percentile, 28 days): **LCP <= 2.5 s, INP <= 200 ms, CLS <= 0.1**; poor above 4.0 s, 500 ms, 0.25. INP replaced FID on 12 March 2024. [S: several guides; a rumour that LCP "good" dropped to 2 s has no support]

Rules from the sources:
- Render real HTML first; hydrate 3D later (lazy). Defer the 3D payload; ship a static poster for mobile and reduced-motion. [S: Utsubo]
- Set byte budgets before modelling; Draco/Meshopt geometry, KTX2 textures; instancing; baked lighting.
- R3F: default DPR is `clamp(devicePixelRatio, 1, 2)`; cap with `dpr={[1, 1.5]}` on mobile; use `frameloop="demand"` and `invalidate()` for scenes that are not constantly animating; put animation in `useFrame`, never your own `requestAnimationFrame`; profile with `r3f-perf`. [S: R3F maintainer on discourse.threejs.org]
- Animate only `transform` and `opacity` (and `filter`/`clip-path` sparingly). Scroll-driven CSS can run off the main thread. [V: Chrome]
- Test on a mid-range Android and inside in-app browsers (Instagram, WhatsApp), not just desktop Chrome. Most small-business traffic is mobile.

## 8. Typography, colour, layout

- **Fonts**: Geist (Vercel; free, variable, on Google Fonts), Instrument Sans, Hanken Grotesk, Funnel Display/Sans are named as current free picks. [S] Satoshi, General Sans, Clash Grotesk are on Fontshare (free for commercial use [K], verify licence per font). Instrument Serif as a display accent is a very common 2026 choice [K]. Linear itself uses Inter Variable with OpenType alternates (`cv01`, `ss03`), weight 510 for UI text and tighter tracking at display sizes [S]; the point is the detail work, not the font. Avoid Inter-by-default: choose a deliberate pairing.
- **Dark-first palette (Linear style)** [S]: near-black base, hierarchy built from white at stepped opacities, borders at about 5 to 8% white, layered shadows with inset highlights, one chromatic accent (Linear: indigo-violet), status colour only on statuses. Use OKLCH tinted neutrals instead of `#000`/`#fff`, per the brief.
- **Bento grids**: CSS Grid, biggest tile for the most important content, vary spans, plan the mobile stack; poor fit for long editorial pages. [S]
- **Kinetic typography**: big type as the hero, headlines that animate on scroll, text that reacts to the cursor; keep it readable and honour reduced motion. [S]
- 2026 trend roundups (generic, vendor blogs; low weight): immersive 3D and motion, bolder type, more expressive minimalism, AI-assisted workflows, fast and accessible as the base. [S]

## 9. Micro-interactions and hover (the vocabulary)

These are patterns, with values from the existing design skills and the sources above:

- **Magnetic button**: element translates toward the pointer within about 80 px, max about 8 to 12 px, spring back on leave. Fine pointers only (`(hover:hover) and (pointer:fine)`).
- **Spotlight/glow card**: a radial gradient follows the pointer via CSS variables `--mx/--my` set on `pointermove` (21st.dev's Spotlight Card is the popular version).
- **Pointer tilt**: max 6 to 10 deg, perspective about 800 to 1200 px, no tilt on touch.
- **Text reveal**: split into lines (not characters, for long text), mask each line with `overflow: clip`, translate Y 100% to 0, stagger 40 to 80 ms, ease-out, 500 to 900 ms for hero (above Emil's 300 ms UI rule: hero choreography is the exception, UI feedback is not).
- **Image/clip reveal**: `clip-path: inset()` from 100% to 0, 800 to 1200 ms, `cubic-bezier(0.22, 1, 0.36, 1)`.
- **Marquee**: CSS `translateX` loop, pause on hover, off in reduced motion.
- **Custom cursor**: only on fine pointers, never hide the system cursor on text or form fields, 12 to 24 px follower with lerp about 0.15.
- **Preloader**: only when assets truly need loading; 1 to 2 s max; skip on repeat visits (sessionStorage). A trending 21st.dev category, but a slow gate costs LCP.
- **Dock nav (macOS)**: neighbours scale by distance to the pointer (1.0 to about 1.5), spring easing.
- **Page transitions**: View Transitions API with a 300 to 500 ms crossfade/slide; shared-element via `view-transition-name`.

## 10. Accessibility and reduced motion (non-negotiable)

- `prefers-reduced-motion: reduce` must remove parallax, scroll-jacking, auto-playing loops, large movement and cursor effects; keep opacity changes. Lenis does this for itself by default [V]; GSAP needs `gsap.matchMedia()` branches.
- Never lock scroll; never hijack wheel direction. Keep native scroll semantics (Lenis does).
- Contrast: body text 4.5:1, large text 3:1, tested on the glass over the worst background. A darker uniform base helps more than more blur. [S: LogRocket]
- `prefers-reduced-transparency` and `prefers-contrast: more` fallbacks for glass (Apple does the equivalent automatically). [V: WWDC25]
- Targets at least 44 px, visible focus rings, semantic `<button>`/`<a>`, text in real HTML (not only in canvas), 3D has a text alternative, canvas `aria-hidden` when decorative.
- Awwwards' own dev scoring includes Accessibility, so it is also an award criterion. [V]

## 11. What designers/devs are sharing on social (public traces only)

Coverage is thin and I will not invent names or posts.
- A cluster of **Claude Code skills for scroll-driven 3D sites** is circulating (GitHub: zyliu0/3d-frontend, freshtechbro/claudedesignskills, MengTo's "Build Three.js Scroll Worlds" with about 4.6k stars, updated Aug 2026), plus TikTok/YouTube tutorials with the same recipe: plan a cinematic scroll animation, install Three.js + GSAP + ScrollTrigger, drive zoom/scale/scene transitions with scroll, layered images for fake depth, refine until it feels like one continuous scene. [S] - Marketing advice seen in the same results: screen-record yourself scrolling the live site and post it, so people see it is real.
- Specific X/Threads/Instagram accounts and viral effects: **not found via public search**. Add posts you trust by link.

## 12. Gaps and how to close them

| Gap | Why | To close |
|---|---|---|
| Apple HIG Materials page text | JS-rendered, empty to my fetchers | Paste the page text, or rely on the WWDC25 transcript (already used) |
| godly, siteinspire, land-book, One Page Love, Framer/Webflow showcases | Not reachable or no useful result | Open in the browser pane and note 10 sites each (names + what stands out) |
| Linear/Vercel/Stripe/Apple product page internals | Only third-party write-ups | Inspect live with DevTools in a later session |
| Lusion/Active Theory engines | No reliable public detail | Do not claim anything about them |
| Codrops articles | 403 to fetcher | Read in the browser pane when needed |
| X/Threads/Instagram | Login-gated | Share links manually |
| Your own research | — | Add a dated file in `references/` and link it from `SKILL.md` |

## 13. Sources

Opened and used:
- [Awwwards: Sites of the Year](https://www.awwwards.com/websites/sites_of_the_year/) and [Lando Norris page](https://www.awwwards.com/sites/lando-norris)
- [Lenis README](https://github.com/darkroomengineering/lenis)
- [GSAP ScrollTrigger docs](https://gsap.com/docs/v3/Plugins/ScrollTrigger/); [Webflow: GSAP becomes free](https://webflow.com/blog/gsap-becomes-free)
- [Motion scroll docs](https://motion.dev/docs/react-scroll-animations)
- [Chrome: scroll-driven animations](https://developer.chrome.com/docs/css-ui/scroll-driven-animations); [Chrome: what's new in web UI, I/O 2026](https://developer.chrome.com/blog/new-in-web-ui-io26?hl=en); [Chrome: View Transitions](https://developer.chrome.com/docs/web-platform/view-transitions)
- [MDN browser-compat-data: animation-timeline](https://github.com/mdn/browser-compat-data/blob/main/css/properties/animation-timeline.json), [ViewTransition](https://github.com/mdn/browser-compat-data/blob/main/api/ViewTransition.json)
- [web.dev: Interop 2026](https://web.dev/blog/interop-2026)
- [Apple WWDC25: Meet Liquid Glass](https://developer.apple.com/videos/play/wwdc2025/219/); [Apple HIG: Materials](https://developer.apple.com/design/human-interface-guidelines/materials) (page did not render for me)
- [21st.dev components](https://21st.dev/community/components), [Container Scroll Animation](https://21st.dev/community/components/manuarora700/container-scroll-animation/default), [Scroll Expansion Hero](https://21st.dev/community/components/arunachalam/scroll-expansion-hero/default)
- [LogRocket: Liquid Glass with CSS and SVG](https://blog.logrocket.com/how-create-liquid-glass-effects-css-and-svg/)
- [Utsubo: 8 best Three.js websites of 2026](https://www.utsubo.com/blog/best-threejs-websites-2026); [Utsubo: WebGPU + Three.js migration guide](https://www.utsubo.com/blog/webgpu-threejs-migration-guide)
- [Modern CSS in 2026 (alexcloudstar)](https://alexcloudstar.com/blog/modern-css-2026-features/)
- [giorgio-a11y Liquid Glass guide](https://github.com/giorgio-a11y/liquid-glass-guide/blob/main/LIQUID-GLASS-GUIDE.md) (third-party)

Seen only as search results (not opened):
- [Codrops: Shader.se scroll-driven WebGPU pipeline](https://tympanus.net/codrops/?p=115509), [Codrops 2026/01](https://tympanus.net/codrops/2026/01/)
- [Linear design-system write-up](https://cdn.jsdelivr.net/npm/oh-my-opencode@4.18.2/dist/skills/frontend/references/design/linear.app.md) (scraped, third-party)
- [Cross-document view transitions](https://developer.chrome.com/docs/web-platform/view-transitions/cross-document)
- [R3F frameloop/DPR discussion](https://discourse.threejs.org/t/requestanimationframe-in-react-three-fiber/41967.md)
- [GSAP forum: AirPods image sequence](https://gsap.com/community/forums/topic/25188-airpods-image-sequence-animation-using-scrolltrigger/)
- [Claude Code 3D scroll skills: zyliu0/3d-frontend](https://github.com/zyliu0/3d-frontend), [freshtechbro/claudedesignskills](https://github.com/freshtechbro/claudedesignskills)
- Trend roundups: [Figma web design trends](https://www.figma.com/resource-library/web-design-trends/), [Line25 2026](https://line25.com/articles/web-design-trends-2026/), [TinyFrog](https://tinyfrog.com/web-design-trends-2026/)
