# Sample Outputs (TeenFit example project)

This folder is the quality bar for the workflow's outputs. TeenFit is a fictional
fitness app for teenagers, taken through the full idea-to-prototype pipeline.

## Files

- **PRFAQ_TeenFit.html** — Amazon Working Backwards press release + skeptical FAQ. Demonstrates the PRFAQ phase output.
- **PRD_TeenFit.html** — Product Requirements Document with EARS-syntax requirements, personas, success metrics, and architecture. Demonstrates the PRD phase output.
- **DesignSystem_TeenFit.html** — Visual reference page for the "Neon Arcade" design direction: palette, typography, buttons, animations, components, and design principles. Demonstrates the design-system step that precedes screen building.
- **teenfit.css** — Shared design-system CSS: design tokens (`:root` variables), CSS reset, body base, shared keyframes, and the canonical `.btn` family. Demonstrates the `[product-slug].css` standard.
- **Screen_Welcome_TeenFit.html** — Onboarding/landing screen. Demonstrates a full-screen immersive screen with animated background and a single CTA.
- **Screen_Dashboard_TeenFit.html** — Home screen with workout card, progress tracking, achievements, and bottom navigation. Demonstrates the card/glassmorphism patterns.
- **Screen_WorkoutExecution_TeenFit.html** — Active-workout screen with timer, rep counter, and controls. Also demonstrates a sanctioned screen-local override of the shared `.btn` family.
- **ProjectDashboard_TeenFit.html** — The live project dashboard that tracks phase completion and links to every artifact.
- **ClickablePrototype_TeenFit.html** — Single-file interactive prototype with all screens and inline CSS/JS. The sanctioned single-file exception to the modular standard.
- **Prototype_TeenFit.html** — An earlier-generation single-file prototype, kept for comparison with the current modular approach.

(There is no ScreenIndex sample yet; see `plugins/product-toolchest/prompts/ScreenIndex_Template.html` for that artifact's template.)

## Architecture

The screens model the modular prototype standard from the toolchest's prototype guide (`plugins/product-toolchest/prompts/Prototype_Creation_Guide.md`):

- **teenfit.css** holds the shared design tokens and shared component classes (the `[product-slug].css` file that is built FIRST, before any screens).
- **Each `Screen_*.html`** links it via `<link rel="stylesheet" href="teenfit.css">` and keeps screen-specific styles (layouts, one-off components, sanctioned overrides) in its own local `<style>` block, always using `var()` tokens for colors/spacing.
- **ClickablePrototype_TeenFit.html** is the sanctioned single-file exception — all CSS inline is fine there.

Note: these screens' local `<style>` blocks are much larger than the "< 50 lines"
target in the standard because they double as educational references — the
extensive comments explain *why* each design decision was made. New builds
should aim for the lean target; the commentary here is the teaching layer,
not the size norm.
