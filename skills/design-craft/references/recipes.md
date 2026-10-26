# Recipes: copy-paste patterns for modern-web-craft

Companion to `SKILL.md`. Every snippet respects reduced motion. Values come from the sources in `research-2026-10.md`; items I could not verify there are marked **(unverified, test)**. Adjust names to the project.

Contents: 1 Lenis+GSAP, 2 CSS scroll-driven, 3 Motion, 4 text reveal, 5 hover systems, 6 view transitions, 7 glass, 8 R3F hero, 9 frame sequence, 10 bento, 11 Playwright scroll check.

---

## 1. Lenis + GSAP ScrollTrigger (Next.js App Router)

```bash
npm i lenis gsap @gsap/react
```

```tsx
// components/SmoothScroll.tsx
'use client';
import { useEffect } from 'react';
import Lenis from 'lenis';
import gsap from 'gsap';
import { ScrollTrigger } from 'gsap/ScrollTrigger';
import 'lenis/dist/lenis.css';

gsap.registerPlugin(ScrollTrigger);

export default function SmoothScroll({ children }: { children: React.ReactNode }) {
  useEffect(() => {
    const lenis = new Lenis({ lerp: 0.1, smoothWheel: true, anchors: true }); // syncTouch stays false
    lenis.on('scroll', ScrollTrigger.update);                 // official pattern
    const tick = (time: number) => lenis.raf(time * 1000);    // GSAP seconds -> Lenis ms
    gsap.ticker.add(tick);
    gsap.ticker.lagSmoothing(0);
    return () => { gsap.ticker.remove(tick); lenis.destroy(); };
  }, []);
  return <>{children}</>;
}
```

Lenis handles `prefers-reduced-motion` itself (`respectReducedMotion` defaults to true). Wrap GSAP effects in `gsap.matchMedia()`:

```ts
const mm = gsap.matchMedia();
mm.add('(prefers-reduced-motion: no-preference)', () => {
  gsap.from('.hero-line', { yPercent: 110, duration: 0.9, ease: 'expo.out', stagger: 0.07 });
});
mm.add('(prefers-reduced-motion: reduce)', () => { gsap.set('.hero-line', { clearProps: 'all' }); });
```

Pinned scroll story (animate children, not the pinned node; no `transform` on its ancestors):

```ts
gsap.timeline({
  scrollTrigger: { trigger: '.story', start: 'top top', end: '+=300%', pin: true, scrub: 1 },
})
  .from('.story .a', { opacity: 0, y: 40 })
  .to('.story .a', { opacity: 0, y: -40 }, '+=0.5')
  .from('.story .b', { opacity: 0, y: 40 });
```

In React use `useGSAP(() => {...}, { scope: ref })` from `@gsap/react` so triggers are cleaned up. Create triggers top to bottom of the page; call `ScrollTrigger.refresh()` after images/fonts change layout.

## 2. CSS scroll-driven animations (no JS)

Support: Chrome/Edge 115, Firefox 159, Safari 26. Duration must be `auto`; put `animation-timeline` after the shorthand.

```css
@keyframes rise { from { opacity: 0; translate: 0 2rem; } to { opacity: 1; translate: 0 0; } }

@supports (animation-timeline: view()) {
  .reveal {
    animation: rise linear both;
    animation-timeline: view();
    animation-range: entry 0% cover 30%;
  }
}
@media (prefers-reduced-motion: reduce) { .reveal { animation: none; } }

/* reading progress bar */
@keyframes grow { from { transform: scaleX(0); } to { transform: scaleX(1); } }
.progress {
  position: fixed; inset: 0 0 auto 0; height: 3px; transform-origin: 0 50%;
  background: var(--accent);
  animation: grow linear; animation-timeline: scroll();
}

/* parallax layer */
@keyframes drift { from { translate: 0 -8vh; } to { translate: 0 8vh; } }
.parallax { animation: drift linear both; animation-timeline: view(); }
```

Stagger without JS (Chromium first; verify): `animation-delay: calc(sibling-index() * 60ms)` **(unverified, test)**; otherwise set `--i` inline.

## 3. Motion (React)

```tsx
import { motion, useScroll, useTransform, useSpring } from 'motion/react';

// reveal once
<motion.div
  initial={{ opacity: 0, y: 24 }}
  whileInView={{ opacity: 1, y: 0 }}
  viewport={{ once: true, margin: '-10% 0px' }}
  transition={{ duration: 0.7, ease: [0.22, 1, 0.36, 1] }}
/>

// scroll-linked scale (e.g. container scroll / media expansion)
const ref = useRef(null);
const { scrollYProgress } = useScroll({ target: ref, offset: ['start end', 'end start'] });
const scale = useSpring(useTransform(scrollYProgress, [0, 0.5], [0.85, 1]), { stiffness: 120, damping: 24 });
<motion.div ref={ref} style={{ scale }} />

// spring for UI
transition={{ type: 'spring', stiffness: 300, damping: 30 }}
```

Respect reduced motion globally: `<MotionConfig reducedMotion="user">`.

## 4. Text reveals (line mask)

```css
.line { display: block; overflow: clip; }          /* mask */
.line > span { display: block; transform: translateY(105%); }
.in .line > span { transform: none; transition: transform 800ms cubic-bezier(0.22,1,0.36,1); transition-delay: calc(var(--i) * 70ms); }
h1 { text-wrap: balance; letter-spacing: -0.03em; }
@media (prefers-reduced-motion: reduce) { .line > span { transform: none; transition: none; } }
```

GSAP SplitText (free): `SplitText.create(el, { type: 'lines', mask: 'lines', autoSplit: true, onSplit: (s) => gsap.from(s.lines, { yPercent: 110, duration: 0.9, ease: 'expo.out', stagger: 0.07 }) })` **(option names: check the current SplitText docs)**. Keep an `aria-label` with the full text on the parent. Split by **lines** for paragraphs; characters only for 1 to 3 word display text.

## 5. Hover and pointer systems (fine pointers only)

```css
@media (hover: hover) and (pointer: fine) { /* all hover effects live here */ }
```

**Magnetic button**
```ts
const el = btn.current!; const xTo = gsap.quickTo(el, 'x', { duration: 0.4, ease: 'power3.out' });
const yTo = gsap.quickTo(el, 'y', { duration: 0.4, ease: 'power3.out' });
el.addEventListener('pointermove', (e) => {
  const r = el.getBoundingClientRect();
  xTo((e.clientX - (r.left + r.width / 2)) * 0.25);   // max pull about 25% of offset
  yTo((e.clientY - (r.top + r.height / 2)) * 0.25);
});
el.addEventListener('pointerleave', () => { xTo(0); yTo(0); });
```

**Spotlight card** (the 21st.dev favourite, restyle it)
```css
.spot { position: relative; background: oklch(0.2 0.01 270); border: 1px solid oklch(1 0 0 / .08); }
.spot::before { content:''; position:absolute; inset:0; border-radius:inherit; pointer-events:none;
  background: radial-gradient(240px circle at var(--mx,50%) var(--my,50%), oklch(1 0 0 / .08), transparent 70%);
  opacity: 0; transition: opacity 200ms; }
.spot:hover::before { opacity: 1; }
```
```ts
card.addEventListener('pointermove', (e) => { const r = card.getBoundingClientRect();
  card.style.setProperty('--mx', `${e.clientX - r.left}px`); card.style.setProperty('--my', `${e.clientY - r.top}px`); });
```

**Press / hover feel**: `transition: transform 150ms var(--ease-out), background-color 150ms; :active { transform: scale(0.97); }`. Link underline draw: `background: linear-gradient(currentColor 0 0) 0 100%/0 1px no-repeat; transition: background-size 250ms; :hover { background-size: 100% 1px; }`.

**Tilt**: `rotateX/Y` max 8 deg, `perspective: 1000px`, lerp toward target, reset on leave; disable on touch.

**Cursor follower**: 16 to 24 px circle, `quickTo` x/y with `duration: 0.2`, `mix-blend-mode: difference` optional; scale up on links; never hide the native cursor over inputs.

## 6. View Transitions

```css
/* cross-document (Chrome/Edge 126, Safari 18.2; not Firefox): enhancement only */
@view-transition { navigation: auto; }
::view-transition-old(root) { animation: 250ms var(--ease-out) both fade-out; }
::view-transition-new(root) { animation: 350ms var(--ease-out) both fade-in; }
.card-img { view-transition-name: hero-img; }   /* unique per element on the page */
@media (prefers-reduced-motion: reduce) { ::view-transition-group(*), ::view-transition-old(*), ::view-transition-new(*) { animation: none !important; } }
```
```ts
// same-document (Chrome 111, Safari 18, Firefox 144)
if (document.startViewTransition) document.startViewTransition(() => setState(next));
else setState(next);
```

## 7. Liquid Glass

**Base layer (all browsers)**
```css
.glass {
  --tint: oklch(1 0 0 / 0.10);
  position: relative; isolation: isolate;
  border-radius: 28px;
  background: linear-gradient(135deg, oklch(1 0 0 / 0.16), oklch(1 0 0 / 0.04)) , var(--tint);
  -webkit-backdrop-filter: blur(22px) saturate(170%) brightness(1.06);
          backdrop-filter: blur(22px) saturate(170%) brightness(1.06);
  border: 1px solid oklch(1 0 0 / 0.20);
  box-shadow:
    inset 0 1px 0 oklch(1 0 0 / 0.40),      /* top rim light */
    inset 0 -1px 0 oklch(0 0 0 / 0.10),
    0 10px 40px oklch(0 0 0 / 0.28);
}
.glass::after { /* specular streak */
  content:''; position:absolute; inset:0; border-radius:inherit; pointer-events:none; z-index:-1;
  background: radial-gradient(120% 80% at 20% 0%, oklch(1 0 0 / .28), transparent 55%);
  mix-blend-mode: soft-light;
}
.glass--tinted { --tint: oklch(0.7 0.15 250 / 0.22); }   /* primary action only */

@media (prefers-reduced-transparency: reduce), (prefers-contrast: more) {
  .glass { backdrop-filter: none; background: oklch(0.22 0.01 270); border-color: oklch(1 0 0 / .5); }
}
@supports not (backdrop-filter: blur(1px)) { .glass { background: oklch(0.22 0.01 270 / .92); } }
```
Rules: floating layer only (nav pill, dock, toolbar, modal, composer, CTA). Never glass inside glass. Add a scroll-edge fade under a glass header: `.page { mask-image: linear-gradient(to bottom, transparent 0, #000 72px); }` or a gradient overlay.

**Materialize in** (instead of a plain fade): `@keyframes mat { from { opacity:0; scale:.96; filter:blur(8px) } to { opacity:1; scale:1; filter:blur(0) } }` 300 ms ease-out. Open menus from the trigger: `transform-origin` = trigger position.

**Chromium refraction enhancement.** Shape: blur the backdrop, displace it with a map, add a specular rim. Safari and Firefox ignore `url()` in `backdrop-filter`, so the base layer above must already look good alone. Fixed element size per map.

```html
<svg width="0" height="0" style="position:absolute" aria-hidden="true">
  <filter id="lens" x="0" y="0" width="100%" height="100%" color-interpolation-filters="sRGB">
    <feImage href="/glass/disp-300x56.png" x="0" y="0" width="300" height="56" result="map"/>
    <feGaussianBlur in="SourceGraphic" stdDeviation="1" result="base"/>
    <feDisplacementMap in="base" in2="map" scale="55" xChannelSelector="R" yChannelSelector="G"/>
  </filter>
</svg>
```
```css
@supports (backdrop-filter: url(#lens)) {
  .glass--lens { backdrop-filter: url(#lens) blur(2px) saturate(160%) brightness(1.1); }
}
```
Displacement maps: neutral = rgb(128,128,128); red channel pushes x, green pushes y; edges push more than the centre to get the lens look; export from Figma or generate procedurally with a canvas script. The `@supports` test above passes in some non-Chromium engines for the syntax but still does nothing visual, which is acceptable because the base layer is the fallback **(unverified: test Safari/Firefox visually)**.

## 8. R3F hero (lazy, capped, with fallback)

```tsx
// app/page.tsx
import dynamic from 'next/dynamic';
const Hero3D = dynamic(() => import('@/components/Hero3D'), { ssr: false, loading: () => <HeroPoster /> });
```
```tsx
// components/Hero3D.tsx
'use client';
import { Canvas, useFrame } from '@react-three/fiber';
import { PerformanceMonitor, AdaptiveDpr } from '@react-three/drei';
import { useState, useRef } from 'react';

export default function Hero3D() {
  const [dpr, setDpr] = useState(1.5);
  const reduce = typeof window !== 'undefined' && matchMedia('(prefers-reduced-motion: reduce)').matches;
  if (reduce) return <HeroPoster />;
  return (
    <Canvas dpr={[1, dpr]} frameloop="always" gl={{ antialias: true, powerPreference: 'high-performance' }}
            camera={{ position: [0, 0, 6], fov: 40 }} aria-hidden="true">
      <PerformanceMonitor onDecline={() => setDpr(1)} onIncline={() => setDpr(1.5)} />
      <AdaptiveDpr pixelated />
      <Scene />
    </Canvas>
  );
}

function Scene() {
  const g = useRef<THREE.Group>(null!);
  useFrame(({ pointer }, dt) => {                 // lerped pointer parallax
    g.current.rotation.y += (pointer.x * 0.4 - g.current.rotation.y) * Math.min(1, dt * 4);
    g.current.rotation.x += (-pointer.y * 0.25 - g.current.rotation.x) * Math.min(1, dt * 4);
  });
  return <group ref={g}>{/* one signature object */}</group>;
}
```
Mount only when visible (wrap in an `IntersectionObserver` gate) and unmount or `frameloop="never"` when off-screen. Use `frameloop="demand"` + `invalidate()` for static scenes. Compress models with `gltf-transform` (Draco/Meshopt, KTX2). Disable on `navigator.hardwareConcurrency <= 4` or width < 768 if the scene is heavy.

**Scroll-driven camera (GSAP)**: put the camera position in a ref object, `gsap.to(cam, { z: 2, scrollTrigger: { trigger: '.sec', scrub: 1 } })`, and read it in `useFrame`. Do not set React state per scroll tick.

**Fragment-shader background (best effort-to-impact)**: a full-screen plane with a custom shader (noise-warped gradient, mouse ripple), 1 draw call, runs on phones. Put real HTML on top.

**WebGPU/TSL (only when justified)**
```js
import * as THREE from 'three/webgpu';
const renderer = new THREE.WebGPURenderer({ antialias: true });
await renderer.init();                                  // falls back to WebGL 2 automatically
const isGPU = renderer.backend.isWebGPUBackend;         // not renderer.isWebGPURenderer
```
Write materials in TSL (nodes), not `ShaderMaterial`. Post-processing uses `RenderPipeline` (not `EffectComposer`).

## 9. Scroll-scrubbed frame sequence (Apple-style, for fixed content)

```ts
const frames = 120, imgs: HTMLImageElement[] = [];
for (let i = 1; i <= frames; i++) { const im = new Image(); im.src = `/seq/${String(i).padStart(4,'0')}.webp`; imgs.push(im); }
const ctx = canvas.getContext('2d')!; const state = { f: 0 };
gsap.to(state, { f: frames - 1, snap: 'f', ease: 'none',
  scrollTrigger: { trigger: '.seq', start: 'top top', end: '+=250%', scrub: 0.5, pin: true },
  onUpdate: () => ctx.drawImage(imgs[state.f], 0, 0, canvas.width, canvas.height) });
```
Budget: WebP at about 1280 px wide, aim under about 4 MB total, fewer frames on mobile (60 to 80), preload the first frames only and the rest lazily; an iPhone crashed on a 147-frame grid in a reported case. For one smooth clip, a muted `<video>` with `currentTime = progress * duration` is lighter than frames if the file is encoded with frequent keyframes.

## 10. Bento grid

```css
.bento { display: grid; gap: 12px; grid-template-columns: repeat(4, 1fr); grid-auto-rows: minmax(160px, auto);
  grid-template-areas: "a a b c" "a a d d" "e f d d"; }
@media (max-width: 760px) { .bento { grid-template-columns: 1fr 1fr; grid-template-areas: "a a" "b c" "d d" "e f"; } }
.bento > :nth-child(1) { grid-area: a } /* ...assign the rest */
```
Largest tile = the main message. Tiles are flat solid surfaces (not glass), 1 px border at 6 to 8% white, radius one system value, a single accent. Each tile has one idea.

## 11. Playwright scroll check (before claiming a scroll page is done)

```ts
import { test } from '@playwright/test';
for (const [name, w, h] of [['m', 375, 812], ['t', 768, 1024], ['d', 1440, 900]] as const) {
  test(`scroll ${name}`, async ({ page }) => {
    await page.setViewportSize({ width: w, height: h });
    await page.goto('http://localhost:3000');
    const total = await page.evaluate(() => document.documentElement.scrollHeight - innerHeight);
    for (const p of [0, 0.25, 0.5, 0.75, 1]) {
      await page.evaluate((y) => scrollTo(0, y), total * p);
      await page.waitForTimeout(900);                       // let Lenis settle
      await page.screenshot({ path: `shots/${name}-${p * 100}.png` });
    }
  });
}
// also run with: test.use({ reducedMotion: 'reduce' }) and look at the same five frames
```
Review the screenshots yourself: clipped text, overlapping layers, jumps at section boundaries, glass text contrast on each frame, nothing blank where a reveal should have fired.
