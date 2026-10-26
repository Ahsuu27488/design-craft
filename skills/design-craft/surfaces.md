# Surfaces: rules per screen type

Every project has several kinds of screens. Polish all of them, each by its own rules. Responsive rules (section 0) apply to every surface without exception.

## 0. Responsive: mandatory everywhere

**Test widths**: 320, 375 (phones), 768 (tablet portrait), 1024 (tablet landscape / small laptop), 1440 (laptop), 1920 (desktop). Screenshot at least 375 / 768 / 1440; spot-check 320 and 1920.

Rules:
- **Mobile first.** Base styles are the phone layout; `min-width` breakpoints add columns. Breakpoints come from the content (where it breaks), typically 640 / 768 / 1024 / 1280.
- **No horizontal scroll at 320 px.** Long words and URLs: `overflow-wrap: anywhere`; tables scroll inside their own container; code blocks scroll inside.
- **Fluid type and space**: `font-size: clamp(2.25rem, 1.2rem + 4.5vw, 5.5rem)` for display, body 16 to 18 px (never below 16 px on inputs, or iOS zooms), section padding `clamp(4rem, 10vw, 9rem)`, container `min(100% - 2rem, 1280px)`, reading width 60 to 75ch.
- **Reflow, do not shrink**: multi-column becomes stacked; bento spans change; side-by-side hero becomes media under text; nav becomes a menu sheet; tables become cards or scroll.
- **Component-level responsiveness** with container queries (`@container`) for cards, chat panels and widgets that live in different widths.
- **Touch**: targets >= 44 x 44 px, 8 px apart; no hover-only actions (hover effects only inside `@media (hover:hover) and (pointer:fine)`); swipe areas do not fight page scroll.
- **Viewport units**: use `dvh`/`svh` for full-height sections and mobile sheets (not `100vh`, which breaks with the iOS address bar); respect `env(safe-area-inset-*)` for fixed bars and the chat composer.
- **Images**: `srcset`/`sizes` or `next/image`, art-directed crops for phones, `aspect-ratio` reserved to avoid CLS.
- **Heavy effects scale down**: 3D, big shaders, pinned scroll stories and custom cursors are reduced or replaced below 768 px or on touch; smooth scroll stays native on touch.
- **Landscape phones and zoom**: works at 200% browser zoom and in landscape (short heights): sticky headers and chat windows do not cover the content.

## 1. Landing page / marketing (Experience, Persuade)

- Structure: hero (one clear promise + one primary CTA + proof), the signature moment, features as bento or a scroll story, real proof (screens, demo, numbers that are true), pricing/CTA, FAQ, footer (a giant wordmark footer works well).
- Hero: headline 2 to 8 words, sub-line under 25 words, primary CTA + secondary link, real product visual in a frame (screenshot, live demo, 3D/shader). LCP element is HTML text or an optimized image, never the canvas.
- Motion: Lenis smooth scroll, line text reveal on the hero, reveals on scroll (CSS `view()` or Motion), one pinned scroll story at most, magnetic primary CTA, spotlight cards. Details in `references/craft.md`.
- Nav: glass pill that shrinks or gains background after scrolling 40 to 80 px; mobile: menu button opening a full sheet; active section highlighted.

## 2. Chatbot / chat window (Operate) — floating widget or full page

- **Launcher**: 56 px round (or pill with label) bottom-right, 16 to 24 px from edges (+ safe-area), clear icon (SVG, not emoji), `aria-label="Open chat"`, subtle attention cue once (no endless bounce).
- **Open animation**: grows from the launcher (`transform-origin` at the launcher), `scale(0.96)->1` + opacity + small translate, 200 to 280 ms ease-out; close is faster (~160 ms). Focus moves into the input on open; `Esc` closes; focus returns to the launcher.
- **Size**: desktop 380 to 420 px wide, up to `min(680px, 80dvh)` tall, radius 20 to 24 px; **phones (<640 px): full screen sheet** (`100dvh`), header with close button, composer pinned above the keyboard with `env(safe-area-inset-bottom)`.
- **Header**: bot name + avatar, status ("Online" / "Answers from the textbook"), actions (new chat, close). Glass is fine here or on the composer, not both (no glass-on-glass).
- **Messages**: user bubbles right with the accent colour; bot messages left as a quiet surface or no bubble with full-width rich text (markdown: headings, lists, code blocks with copy button, links); max width ~80% of the panel; 8 to 12 px between same-sender messages, 16 to 20 px between turns; timestamps quiet or on hover.
- **Streaming**: show tokens as they arrive; a typing indicator (three dots, opacity pulse, off in reduced motion) until the first token; a Stop button while generating; auto-scroll only if the user is already at the bottom, otherwise show a "New messages" pill.
- **Sources/citations** (RAG): small chips under the answer linking to the page/section; expandable.
- **Composer**: auto-growing textarea (`field-sizing: content` with a JS fallback), Enter sends / Shift+Enter new line, send button disabled when empty, character or attachment affordances only if real; placeholder that suggests a real question.
- **Empty state**: greeting + 3 or 4 suggested questions as chips taken from the real content.
- **Errors**: inline in the thread with a Retry button, plain words ("Couldn't reach the server. Retry"), never a silent failure or a raw stack trace. Rate limit and offline states handled.
- **Accessibility**: `role="log"` + `aria-live="polite"` on the message list, labelled input, visible focus, works by keyboard only.

## 3. Login / signup / auth (Operate)

- Layout: centred card 360 to 440 px on a calm background, or split screen (form + brand visual) on >= 1024 px, stacked on phones. One primary action.
- Fields: visible labels (never placeholder-only), correct `type` and `autocomplete` (`email`, `current-password`, `new-password`, `one-time-code`), 44 to 48 px tall, 16 px text, show/hide password toggle with `aria-pressed`, caps-lock hint optional.
- Validation: on blur and on submit, not on every keystroke; error text under the field in plain words with `aria-describedby` and `aria-invalid`; an error summary at top for long forms; never clear what the user typed.
- Submit: button shows a spinner + "Signing in..." and is disabled while pending; success leads somewhere clear.
- Social/OAuth buttons: same height as the primary button, provider logo, secondary styling.
- Extras: "Forgot password?" next to the password label; sign-in/sign-up switch link; password rules shown as a checklist that ticks live on signup.
- Motion: card enter 300 to 400 ms once; error shake small (4 to 6 px, 300 ms, off in reduced motion).

## 4. Buttons and controls (everywhere)

- Variants: primary (one per view), secondary, ghost, destructive, link. Sizes sm 32 / md 40 / lg 48 px tall (44 px minimum touch area via padding or `::after` hit area).
- States: hover (120 to 200 ms colour/brightness), `:focus-visible` ring 2 px offset 2 px in the accent, active `scale(0.97)`, disabled (lower contrast, `cursor: not-allowed`, no hover/animation), loading (spinner replaces icon, width does not jump, `aria-busy`).
- Labels are verbs ("Start free trial", "Send message"), no `→` on every button, icons only where they help, icon-only buttons have `aria-label` and a tooltip.
- Toggles, checkboxes, radios, selects, sliders: native or Radix/shadcn-based, styled to the tokens, full keyboard support.

## 5. App UI / dashboard / settings (Operate)

- Density: comfortable, scannable; 14 to 16 px text; tabular numbers; consistent page header (title, actions).
- Navigation: sidebar on >= 1024 px (collapsible to icons), bottom bar or menu sheet on phones; breadcrumbs for depth.
- Loading: skeletons that match the final layout (no spinners for page loads); optimistic updates for quick actions; toasts for background results (bottom on phones).
- Empty states with one clear next action; errors with a fix.
- Tables: sticky header, horizontal scroll inside the container on phones or a card layout; row hover; sortable headers with `aria-sort`.
- Motion: view transitions between routes 200 to 300 ms; list item add/remove with layout animation; no smooth scroll, no 3D, no parallax.
- Modals/sheets: `scale(0.96)` + opacity enter, focus trap, `Esc`, return focus; on phones bottom sheets with drag-to-close (`apple-design`).

## 6. Docs / textbook / articles (Read)

- Reading first: 17 to 19 px body, line height 1.6 to 1.75, 60 to 75ch measure, clear heading scale, generous spacing, good code-block styling with copy buttons.
- Navigation: sticky sidebar (collapsible on phones into a sheet), on-page table of contents with scroll-spy, previous/next links, search prominent.
- Extras: reading progress bar (CSS `scroll()`), callouts with icons, images zoomable, dark mode with tuned contrast.
- Motion: minimal; glass at most on the top nav; no smooth-scroll library on docs (native anchor scrolling matters).
- Framework themes (Docusaurus, Nextra, Starlight): restyle through their theme tokens and swizzled components, not by fighting their CSS.

## 7. States everyone forgets

Loading, empty, error, offline, permission denied, 404/500 pages, long content (very long names, 3-line titles), no-JS first paint, slow network (throttle to Fast 3G and look), dark mode, RTL/Urdu text if the project has it.
