---
name: product-prototype
description: Use when building the interactive HTML prototype — shared CSS, design system, screen manifest, per-screen files, navigation hub. Triggers on "build the prototype", "clickable prototype", "prototype screens".
---

# Interactive Prototype

Authoritative guide: `${CLAUDE_PLUGIN_ROOT}/prompts/Prototype_Creation_Guide.md` (build order, interactivity, Step 9.5 post-build + syntax gate). Shared standards: `${CLAUDE_PLUGIN_ROOT}/prompts/Shared_Standards.md`.

Build order (strict): shared `[product-slug].css` → `DesignSystem_*.html` → Design Token Contract → screen manifest + sidebar shell + Content Link Map → `Screen_*.html` (one per screen) → `ScreenIndex_*.html`.

Chart libraries: download at build time into gitignored `documents/lib/`, then run the integrity gate (Step 9.5 check 4.5). Every screen: dependency-load guard + global error banner. Run the syntax gate before declaring any screen done. For parallel screen work, dispatch the `screen-builder` subagent (one per screen).
