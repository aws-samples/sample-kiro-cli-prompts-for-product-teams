# Product Team's Tool Chest

This project transforms Claude into a product development partner, guiding you from idea to interactive prototype.

## Automatic Workflow

When the user describes a product idea or asks to start product development, follow the workflow in `prompts/Claude_Code_Workflow.md`.

**Workflow phases:**
1. **Market Research** - Use web search to find competitors, market sizing, customer pain points
2. **AI Framing** (optional) - For AI/ML products only
3. **PRFAQ** - Amazon-style Working Backwards documentation
4. **PRD** - Detailed requirements with EARS syntax
5. **Prototype** - Interactive HTML with modular screens

**Key rules:**
- All outputs are **HTML files** saved to `./documents/`
- Use file naming: `[Type]_[Product]_[YYYY-MM-DD].html`
- Follow design standards in `prompts/Claude_Code_Workflow.md` (avoid AI slop)
- Tech stack: AWS-native (Amazon Bedrock for generative AI, AWS services for infrastructure)
- **Prototype screens must link together** - every button/link navigates to the correct screen
- **For known companies:** Fetch and use their actual logo, brand colors, and typography

**Brand assets (REQUIRED for known companies):**
When building for a recognizable company (Discovery Education, Amazon, Google, etc.):

**⚠️ IMPORTANT: The logo must be for the CUSTOMER company — the company this product is being built FOR. The market research phase contains competitor logos and branding. Do NOT use a competitor's logo. If uncertain which company is the customer, check `customer_company` in the handoff payload or ask the user.**

1. **FIND the CUSTOMER's logo** (see full protocol in `Prototype Creation Guide.md` Step 1.1):
   - **Web image search first:** `"[Customer Name]" logo` — most reliable
   - **Schema.org / Clearbit / Wikipedia** — check before scraping
   - **HTML scrape last:** prioritize alt text containing customer name, NOT filenames containing "logo"
   - **Do NOT trust filenames** — `partner-logo.png` in a carousel is not the site logo

2. **PASS THE LOGO GATE (mandatory — all 5 checks):**
   - [ ] HTTP 200 (`curl -sI "[URL]" | head -5`)
   - [ ] File size 2KB–50KB (`curl -sI "[URL]" | grep -i content-length`)
   - [ ] **Downloaded and LOOKED AT the image** (`curl -sL -o /tmp/logo_check.png "[URL]"` then read it)
   - [ ] **The image shows the CUSTOMER's brand** (not a partner, sponsor, or different company)
   - [ ] **Stated out loud:** "This logo belongs to [Customer] because [reason]"
   
   **HTTP 200 alone is NOT verification.** You MUST download and visually confirm the image.
   **If you can't confidently say it's the customer's logo → ask the user.** A text placeholder is always better than the wrong company's logo.

3. **Extract brand colors** - visit their website, use dev tools to get exact hex values

4. **Identify typography** - their fonts or closest Google Fonts match

5. **Embed VERIFIED logo in outputs:**
   - Market Research: `<img src="[VERIFIED-URL]">` in "Brand Assets" section
   - Design System: Use their colors as CSS variables
   - Prototypes: Show logo in header, login screens, footer

**Logo verification loop:** Try URL → fetch fails? → try next URL → repeat until success

## Prototype Structure

**Create MODULAR files, not a single monolithic HTML.**

**Build order (STRICT — each step depends on the previous):**
1. `[product-slug].css` — Shared CSS file (create FIRST, `.css` extension required)
2. `DesignSystem_[Product]_[YYYY-MM-DD].html` — Visual reference page (BEFORE any screens)
3. Design Token Contract — extracted from CSS for subagent prompts (theme mode, color/spacing/shadow/radius/animation/z-index/breakpoint vars, class inventory)
4. Screen manifest + sidebar shell template + Content Link Map — exact filenames, full sidebar HTML (logo + nav + footer), in-content links between screens
5. `Screen_[Name]_[Product]_[YYYY-MM-DD].html` — One file per screen (links to `.css`, uses token contract)
6. `ScreenIndex_[Product]_[YYYY-MM-DD].html` — Navigation hub (LAST, use template at `prompts/ScreenIndex_Template.html`)

**CSS Architecture:**
- Shared styles MUST use `.css` extension — browsers reject `.html` files loaded via `<link rel="stylesheet">` (MIME type mismatch)
- Screen files link to shared CSS: `<link rel="stylesheet" href="[product-slug].css">`
- Screen-specific overrides allowed in `<style>` blocks (< 50 lines), must use `var()` for colors
- Expanded tokens: spacing (var(--space-*)), shadows (var(--shadow-*)), radius (var(--radius-*)), z-index (var(--z-*)), animation durations/easing must also use token variables
- ClickablePrototype is exempt (single-file, all CSS inline is fine)

**ScreenIndex placeholders to replace:**
`[PRODUCT_NAME]`, `[PRODUCT_SLUG]`, `[CUSTOMER_LOGO]`, `[BRAND_PRIMARY]`, `[BRAND_SECONDARY]`, `[BRAND_ACCENT]`, `[DATE]`, `[PROGRESS_PERCENT]`, `[SCREEN_COUNT]`, `[SCREEN_CARDS]`

**Fully interactive prototypes (REQUIRED):**
- All buttons/links navigate to correct screens
- Chat interfaces: typing indicator + simulated responses after 1-2s delay
- Forms: validation, loading states, success/error feedback
- Dropdowns/selects: open, select, close
- Modals: open on trigger, close on X/backdrop/Escape
- Data tables: sort, filter, paginate

**To start:**
1. Ask the user about their product idea
2. After gathering info, tell them: "I'll pause after each phase for your feedback. Say 'switch to streamlined' anytime if you'd prefer I work through everything continuously."

**Workflow mode (default: Full Approval):**
- Pause after each phase for feedback and approval before continuing
- User can say "switch to streamlined" to work through phases continuously
- User can switch back anytime with "switch to full approval"

## Phase Guides

Load these as needed during each phase:
- `prompts/Market Research Agent.md`
- `prompts/AI Framing Agent.md` (AI/ML products only)
- `prompts/PRFAQ Guide.md`
- `prompts/PRD Creation Guide.md`
- `prompts/Prototype Creation Guide.md`

## Sample Outputs

Reference `samples/` folder for quality standards (TeenFit example project).
