# Craft reference: techniques, defaults, budgets

Loaded by `design-craft` when building or polishing. Code for every pattern: `recipes.md`. Evidence and sources: `research-2026-10.md`.

## 1. Choose the ambition by mode (impeccable's modes)

| Mode | Examples | Motion / 3D budget |
|---|---|---|
| **Experience** | portfolio, Relay-style landing, showcase | Full: smooth scroll, scroll-driven scenes, one 3D hero, glass nav, preloader if assets need it |
| **Persuade** | client landing page, gig demo | High but readable: smooth scroll, text reveals, sticky scroll story, 1 signature effect, bento, glass nav/CTA |
| **Operate** | dashboard, chat app, admin | Low: micro-interactions, view transitions, skeletons. No scroll-jacking, no 3D, glass only on the floating toolbar/modal |
| **Read** | docs, textbook (Docusaurus) | Minimal: typography, progress bar, subtle reveals. Glass at most on the navbar |

**One signature idea per site.** Winners commit to one concept (one object, one world, one interaction) and build everything around it. Pick it in the direction sentence. Everything else supports it and stays quiet.

## 2. Defaults (use these unless the design says otherwise)

| Thing | Default |
|---|---|
| Smooth scroll | Lenis `lerp: 0.1` (or `duration: 1.2`), `smoothWheel`, `syncTouch: false`. Only on Experience/Persuade pages, never in app UIs |
| Scroll animations (simple reveals, progress bars, parallax) | CSS `animation-timeline: view()` / `scroll()`: Chrome/Edge 115, Firefox 159, Safari 26. Wrap in `@supports (animation-timeline: view())` and show the end state otherwise |
| Scroll animations (pinning, scenes, sequencing, with 3D) | GSAP + ScrollTrigger (free, incl. SplitText). Sync with Lenis exactly as in `recipes.md` |
| React component motion (enter/exit, layout, gestures) | `motion` (Framer Motion). `whileInView` + `viewport={{ once: true }}` |
| Page transitions | View Transitions API, 300 to 500 ms. Same-doc is cross-browser; cross-document (`@view-transition { navigation: auto }`) is not in Firefox, so enhancement only |
| Easing UI | `cubic-bezier(0.22, 1, 0.36, 1)` (ease-out expo-ish) or `cubic-bezier(0.16, 1, 0.3, 1)`; springs via CSS `linear()` or Motion `type: "spring"` (stiffness 300, damping 30) |
| Easing scroll-scrubbed | `linear` (the scroll is the easing) plus smoothing |
| Hover/press | 120 to 200 ms; press `scale(0.97)`; hover only inside `@media (hover: hover) and (pointer: fine)` |
| Entrance stagger | 40 to 80 ms per item, total under 600 ms for lists, up to 900 ms for hero lines |
| 3D | R3F + drei for React/Next; plain Three.js for single static pages. New projects: `three/webgpu` + TSL only if you need compute/many draw calls; otherwise WebGL is fine. Always lazy-load |
| Pre-rendered "3D" | If the content is fixed (a product spin, a camera flythrough) use video or a WebP frame sequence on `<canvas>` scrubbed by scroll (the Apple pattern). Cheaper, more reliable on phones than live 3D |
| Glass | Layered CSS base for every browser; SVG-refraction enhancement for Chromium behind `@supports`; see section 6 |
| Type | A deliberate pairing, not Inter. Free options seen in 2026: Geist, Instrument Sans/Serif, Hanken Grotesk, Funnel Display, Satoshi/General Sans (Fontshare). Display tracking `-0.02em` to `-0.04em`, `text-wrap: balance` on headings, `pretty` on paragraphs, line length 60 to 75 ch |
| Colour | OKLCH tinted neutrals, no `#000`/`#fff`. Dark premium: base about `oklch(0.14 0.01 270)`, surfaces step up in lightness 0.03 each, borders = white at 6 to 10% alpha, text = white at 92% / 64% / 44%, ONE accent |
| Radius | One system. Nested radii concentric: `inner = outer - padding` |
| Spacing | One scale (4/8 px base). Section padding `clamp(4rem, 10vw, 9rem)` |
| Images/video | Real, credited assets. `next/image`/AVIF/WebP; hero video 720p H.264 under about 3 MB with a poster; preload only the LCP image |

## 3. Which tool for which effect

| Effect | Use | Notes |
|---|---|---|
| Smooth inertia scroll | Lenis | Keeps native scroll, sticky, anchors. Honours reduced motion by itself |
| Fade/slide-in on scroll | CSS `view()` or Motion `whileInView` | Do not use GSAP for this alone |
| Reading progress bar | CSS `animation-timeline: scroll()` | 5 lines |
| Horizontal scroll section, pinned story, scene sequencing | GSAP ScrollTrigger (`pin`, `scrub`) | Animate children, not the pinned element; no `transform` on pinned ancestors |
| Split-text reveals | GSAP SplitText (free now) or Motion + manual `span` split | Split by lines for paragraphs; keep real text for screen readers (`aria-label` on the parent) |
| Marquee/ticker | CSS `translateX` loop | Pause on hover, off for reduced motion |
| Magnetic button, spotlight card, tilt | Pointer events + CSS variables / GSAP `quickTo` | Fine pointers only |
| Custom cursor | Pointer events + `quickTo`/lerp | Fine pointers only; never on text inputs |
| Page/route transitions | View Transitions API (Next: use `document.startViewTransition` around `router.push`, or Motion `AnimatePresence`) | Keep under 500 ms |
| Particle/hero field, product viewer | R3F + drei, instancing, GPU shaders | Cap DPR, lazy, static fallback |
| Shader background (gradient mesh, noise, ripple) | One full-viewport fragment shader (plain Three.js or `ogl`) behind real HTML | Best effort-to-impact ratio for a first 3D piece |
| Refraction/liquid glass in 3D | drei `MeshTransmissionMaterial` | Heavy; one object only |
| Product spin / flythrough | Frame sequence on canvas, or `<video>` scrubbed with `currentTime` | Compress hard; test an iPhone |
| Bento grid | CSS Grid with `grid-template-areas`, spans 1 to 3 | Most important tile largest; plan the mobile stack |
| Number counters, charts | Motion `animate` / `useSpring` | `tabular-nums` |
| Tooltips/menus | Anchor positioning (Chromium, Safari 26, Firefox 147) with a JS fallback, or Radix | |
| Starting from a component | 21st.dev (see section 3 below) | Customise fonts, colour, copy so it does not read as template |

### 21st.dev (use it as a source of skeletons)
Catalog: Heroes 1,152, Backgrounds 365, Texts 663, Navigation 477, Cards 1,780, AI Chats 248, Cursors 152. Popular picks worth knowing: **Scroll media expansion hero** (@arunachalam), **Container Scroll Animation** (@manuarora700, Aceternity: a tilted screen that flattens as you scroll), **Spline Scene** (@serafimcloud), **Spotlight Card** (@jahed), **Radial Orbital Timeline**, **Testimonials Columns** (@efferd), **Liquid Glass Button / Navbar**, **Scroll Morph Hero**, **Background Paths** (@kokonutd), **Mac-style Floating Dock**. Install with `npx shadcn@latest add "https://21st.dev/r/<author>/<name>?api_key=$API_KEY_21ST"` (key in env, never in files; free tier has a daily limit). They depend on `framer-motion`/`motion`. Because the same ones are installed 5 to 10 thousand times, always restyle: new type, new palette, new copy, new easing. For chat UIs see its "AI Chats" category.

## 4. Motion system (one set of tokens per project)

Define once in CSS variables and reuse:

```css
:root {
  --ease-out: cubic-bezier(0.22, 1, 0.36, 1);
  --ease-in-out: cubic-bezier(0.65, 0, 0.35, 1);
  --dur-fast: 150ms;   /* hover, press */
  --dur-ui: 240ms;     /* menus, toggles, tooltips */
  --dur-enter: 700ms;  /* section/hero entrances, once */
  --stagger: 60ms;
}
@media (prefers-reduced-motion: reduce) {
  :root { --dur-enter: 1ms; --stagger: 0ms; }
}
```

Rules: purpose first (does it explain, guide or delight once?); one choreographed moment per viewport, not five; things enter from small offsets (`translateY(16px to 32px)`, `scale(0.96)`), never from nothing and never from far away; exits are faster than entrances (about 60%); no motion on disabled elements; keep text readable while it moves (do not scrub text through low contrast).

## 5. 3D playbook (Three.js / R3F / WebGPU)

1. **State the 3D idea in one sentence** ("a single glowing object the cursor can bend"). If you cannot, do not add 3D.
2. HTML first: headline, copy and CTA are real DOM and render without WebGL. 3D is a progressive enhancement layered behind or beside it.
3. Lazy-load: `next/dynamic(() => import('./Scene'), { ssr: false })`, mounted after first paint or on intersection (`IntersectionObserver`), with a `poster` image or CSS gradient placeholder at the same size (no CLS).
4. Budgets: JS for 3D under about 250 KB gzipped (three tree-shaken + app), models under 1.5 MB (Draco/Meshopt), textures KTX2 or compressed WebP, total 3D payload under about 3 MB on mobile. Set the byte budget before modelling.
5. Renderer: `dpr={[1, 1.5]}` on mobile, `[1, 2]` desktop; `frameloop="demand"` when the scene is idle; all animation in `useFrame`; pause when off-screen or tab hidden; use `PerformanceMonitor`/adaptive quality to drop DPR if fps falls.
6. Instancing for repeated meshes, baked lighting, few lights, avoid real-time shadows and heavy post-processing on mobile. Bloom, vignette, noise, chromatic aberration: one or two passes, desktop only.
7. WebGPU: use only when needed. `three/webgpu` `WebGPURenderer` falls back to WebGL 2 automatically; write materials in **TSL** (not `ShaderMaterial` or `onBeforeCompile`, which break on that renderer). Check `renderer.backend.isWebGPUBackend`. About 87% support (Sept 2026). Profile before and after; it is not automatically faster.
8. Fallbacks: `prefers-reduced-motion` or low-power (`navigator.hardwareConcurrency <= 4` or `deviceMemory <= 4` or small viewport) shows the static poster or a reduced scene. Test on a mid-range Android and in the Instagram/WhatsApp in-app browser.
9. Interaction that feels premium: pointer-driven camera parallax with lerp 0.05 to 0.1, weighted inertia on hover, one click/press response (shockwave, ripple). Scroll drives the camera along a path; section = beat (entrance, hold, exit).
10. Prefer a shader or pre-rendered video over a 40 MB scene. Many viral "3D scroll" sites are video + parallax.

## 6. Apple Liquid Glass on the web

Apple's rules (WWDC25 "Meet Liquid Glass", and the Materials HIG) translate directly:

- **Glass is the functional layer floating above content**: nav bar/pill, dock, toolbar, floating CTA, modal/sheet, chat composer. **Content stays flat and solid**: cards, lists, articles, tables. One glass layer deep: **no glass on glass.**
- **Two variants, never mixed.** *Regular* (default): stronger blur, tinted, adaptive, readable anywhere. *Clear*: more transparent, only over bold media, with a dimming layer under it.
- **Lensing** is the signature: edges bend and concentrate light (bright thin rim, soft inner shadow). **Materialization**: appear by easing blur/opacity/scale together (`scale 0.96 to 1`, blur 8 to 0 px, 250 to 350 ms), not a plain fade. **Fluidity**: slight stretch/lift on press, menus open *from the button that triggered them* (`transform-origin` at the trigger).
- **Concentric corners**, large radii (16 to 28 px, pills 999px). Tint only the primary action; accent colour belongs in the content layer.
- Over content, add a **scroll-edge effect**: a gradient mask/fade so content dissolves under the glass (`mask-image: linear-gradient(to bottom, #000 calc(100% - 24px), transparent)` on the scroller edge, or a gradient overlay).

### Recipe tiers (see `recipes.md` for code)
1. **Base (all browsers):** `background: oklch(1 0 0 / 0.08 to 0.14)`; `backdrop-filter: blur(18px to 28px) saturate(160%) brightness(1.05)`; `border: 1px solid oklch(1 0 0 / 0.18)`; `box-shadow: inset 0 1px 0 oklch(1 0 0 / 0.35), 0 8px 32px oklch(0 0 0 / 0.25)`; faint diagonal specular gradient in a pseudo-element.
2. **Chromium enhancement:** SVG `feDisplacementMap` filter used as `backdrop-filter: url(#lens) blur(...)` behind `@supports (backdrop-filter: url(#x))` plus a UA check, because Safari and Firefox do **not** accept SVG filters in `backdrop-filter`. Fixed element size per filter (the map is sized to the element). Use on 1 to 3 elements only: each costs GPU.
3. **3D glass:** drei `MeshTransmissionMaterial` on a single object, desktop only.
4. **Fallbacks:** `@media (prefers-reduced-transparency: reduce)` and `(prefers-contrast: more)` switch to an opaque tinted surface with a visible border; `@supports not (backdrop-filter: blur(1px))` the same.
5. **Legibility test:** text on glass must reach 4.5:1 over the *worst* background that can scroll behind it; if not, darken the tint, do not add more blur.

## 7. Performance budget (hard gates)

- Core Web Vitals, field data: **LCP <= 2.5 s, INP <= 200 ms, CLS <= 0.1** (poor above 4 s, 500 ms, 0.25). Check with Lighthouse mobile and real-device scroll.
- LCP element is real HTML/image, never the canvas. `<link rel="preload">` for the LCP image and the one hero font; `font-display: swap`, subset, max 2 families / 3 files.
- No layout shift: reserve space for canvas, video, images, web fonts (`size-adjust` fallback).
- Main-thread discipline: no scroll listeners that read layout (`getBoundingClientRect` in a scroll handler); use CSS timelines, `IntersectionObserver` or GSAP. Debounce resize.
- `will-change` only on the few elements animating right now, removed after.
- Mobile first: the 3D/heavy effect may be reduced or replaced below 768 px; scroll-jacking never on touch (`syncTouch` stays false).
- Total JS for a landing page: aim under 200 KB gzipped excluding the lazy 3D chunk.

## 8. Accessibility (non-negotiable)

- `prefers-reduced-motion: reduce`: remove parallax, pinned scrolljacking, marquees, cursor effects, 3D camera movement and large transforms; keep short opacity fades. GSAP: wrap in `gsap.matchMedia()`; Lenis: leave `respectReducedMotion` on.
- Never lock the scroll position, never reverse wheel direction, always keep keyboard focus visible and not hidden behind sticky glass bars (`scroll-padding-top`).
- Text is real DOM text. Canvas is `aria-hidden="true"` when decorative and has an adjacent text alternative when it carries meaning.
- Targets at least 44 px. Contrast 4.5:1 body, 3:1 large. Do not rely on colour alone.
- Pause/stop control for anything auto-moving more than 5 s.
- Awwwards scores developers on accessibility too, so it is also part of looking "award level".

## 11. Things NOT to do

- Do not claim an effect "is like Lusion/Active Theory". Their engines are not public; reproduce the *principle* (one idea, weighted motion, real depth).
- Do not use `ShaderMaterial` with `WebGPURenderer`; do not use `renderer.isWebGPURenderer` to detect the backend.
- Do not rely on experimental CSS (`corner-shape`, scroll-triggered animations (Chrome 146 only), HTML-in-Canvas, element-scoped view transitions) for anything a client sees.
- Do not hide the system cursor over text/inputs; do not ship a custom cursor on touch.
- Do not install a 21st.dev component and ship it unchanged.
- Do not add a preloader to hide a slow page. Fix the page.
- Do not invent testimonials, awards or client logos; demo content is labelled as a demo.

