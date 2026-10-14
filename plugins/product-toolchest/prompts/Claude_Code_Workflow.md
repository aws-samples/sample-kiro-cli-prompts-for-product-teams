# Product Development Workflow for Claude Code & Cursor

> **Load this file to transform Claude into your product development partner.**
>
> This workflow guides you from idea to interactive prototype with professional HTML deliverables at each step.

---

## Quick Start

1. **Copy this folder** to your project: `cp -r prompts/ your-project/prompts/`
2. **Start Claude Code or Cursor** in your project directory
3. **Load this file** and describe your product idea
4. **Choose your mode**: Full Approval (pause after each phase) or Streamlined (work through all phases)

---

## Workflow Overview

```
Discovery → Deep Market Research → [AI Framing] → PRFAQ → PRD → Prototype
                                    (optional)
```

| Phase | Output | Guide to Load |
|-------|--------|---------------|
| 1 | Deep Market Research (6 dimensions, 120+ sources) | `Deep_Research_Agent.md` |
| 1b | AI Framing (ML products only) | `AI_Framing_Agent.md` |
| 2 | PRFAQ | `PRFAQ_Guide.md` |
| 3 | PRD | `PRD_Creation_Guide.md` |
| 4 | Prototype | `Prototype_Creation_Guide.md` |

**Internal sub-steps (not user-visible phases):**
- Technology Research runs inside Phase 3 (PRD) — see `PRD_Creation_Guide.md` Step 1.5
- Prototype Spec runs at the start of Phase 4 (Prototype) — see `Prototype_Spec_Guide.md`

**All outputs:** Standalone HTML files saved to `./documents/`

---

## Step 1: Discovery

### Ask the user:
- What problem are you trying to solve?
- Who is your target audience/customer?
- What are your main business goals?
- What key features do you envision?
- How will users interact with this product?
- Is this for an existing company? (for brand research)

### Inform user about workflow mode:
After gathering initial information, tell the user:
> "I'll work through 4 phases: Deep Market Research → PRFAQ → PRD → Prototype. By default, I'll pause after each phase for your feedback. If you'd prefer I work through everything continuously, just say 'switch to streamlined' at any time."

### Determine if AI/ML product:
**AI/ML indicators:** ML models, predictions, NLP, computer vision, recommendations, automated decisions, pattern recognition, generative AI.

- **If AI/ML:** Include Phase 1b (AI Framing) after Deep Market Research
- **If standard:** Skip Phase 1b, go directly to PRFAQ

### Immediately begin research:
After gathering the user's answers and informing them of the mode, proceed directly to Phase 1 (Deep Market Research). Do NOT ask permission to start research — begin immediately.

### Workflow Modes

**Full Approval Mode (default):**
- After completing each phase, **STOP and wait for user approval** before proceeding
- Present a summary of what was created and ask: "Ready to proceed to the next phase, or would you like changes?"
- If you have questions or need clarification, **ask and wait for a response** before continuing
- Do NOT proceed to the next phase until the user explicitly approves

**Streamlined Mode:**
- Work through all phases continuously without stopping
- User can interrupt at any time to provide feedback
- If interrupted, pause and address feedback before resuming

> **Users can switch modes at any time** by saying "switch to streamlined" or "switch to full approval"

---

## Step 2: Execute Phases

### Phase 1: Deep Research

**Load:** `prompts/Deep_Research_Agent.md`

> **Important:** Use web search to find real data. Don't make up statistics. This phase conducts rigorous multi-dimensional research across 6 parallel tracks.

**Conduct deep research across 6 dimensions:**
1. **Industry Landscape** — market size, growth, regulation, disruption, emerging segments
2. **Competitive Intelligence** (5-7 competitors) — products, pricing, strategy, gaps, funding
3. **Customer & Persona Deep Dive** — pain points, workflow friction, buying behavior, unmet needs
4. **Technology Radar** — emerging tech mapped to AWS services, feasibility assessment
5. **Adjacent Innovation** — startups, product launches, cross-industry approaches
6. **Policy, Risk & Opportunity Landscape** — legislation, compliance, procurement, industry risks (security/backlash/lawsuits), emerging opportunities, blue ocean signals

**Research protocol:**
- 8-12 iterative web searches per dimension (adapt queries based on findings)
- Fetch actual pages for pricing, features, and specifics (don't rely on snippets)
- Cross-reference findings across dimensions
- Flag contradictions where sources disagree

**Quality gate (standard depth):**
- Minimum 120 unique sources total
- Minimum 15 sources per dimension
- If any dimension falls below minimum, run additional searches until met

**Save:**
- `documents/MarketResearch_[Product]_[YYYY-MM-DD].html`

**Checkpoint:**
- [ ] Minimum 120 unique sources (standard depth) or 150+ (comprehensive)
- [ ] Each dimension has 15+ sources (standard) or 20+ (comprehensive)
- [ ] Quality gate passed (no unresolved dimension deficits)
- [ ] TAM/SAM/SOM with dollar figures and cited sources
- [ ] At least 5 competitors with real pricing (fetched from their sites)
- [ ] Pain points ranked by severity × frequency with sources
- [ ] Technology radar maps capabilities to specific AWS services
- [ ] Relevance tiers assigned to all sources (primary/supporting/background)
- [ ] Every data claim has a superscript source citation link
- [ ] Sources section grouped by dimension with relevance tier tags
- [ ] Cross-dimensional insights noted (where findings corroborate)
- [ ] Contradictions flagged explicitly
- [ ] No placeholder text (TBD, TODO, [insert])
- [ ] File saved successfully

> **Full Approval Mode:** STOP here. Present summary and wait for user approval before proceeding.

---

### Phase 1b: AI Framing (AI/ML Products Only)

**Load:** `prompts/AI_Framing_Agent.md`

**Create:**
1. Business goals and ML problem framing
2. ML problem type (classification, regression, etc.)
3. Input/output schemas
4. Data strategy and requirements
5. Performance metrics and thresholds
6. Feasibility assessment

**Save:**
- `documents/AIFraming_[Product]_[YYYY-MM-DD].html`

**Checkpoint:**
- [ ] ML problem type clearly defined
- [ ] Success metrics with specific thresholds
- [ ] Data requirements documented
- [ ] Feasibility assessment complete
- [ ] File saved successfully

> **Full Approval Mode:** STOP here. Present summary and wait for user approval before proceeding.

---

### Phase 2: PRFAQ

**Load:** `prompts/PRFAQ_Guide.md`

**Step 0: Challenge Check (internal — do not present as separate step to user)**
Before writing the PRFAQ, critically examine the research inputs. Ask yourself:
1. Is the pain point we identified actually severe enough to build a product around, or are we overweighting vocal minorities?
2. Are we cherry-picking research that confirms our hypothesis while ignoring disconfirming evidence?
3. What's the strongest argument that this market doesn't actually want a new solution?
4. Which competitor could ship this feature next quarter and make our product irrelevant?
5. Are the TAM/SAM numbers realistic or aspirational? What would make them collapse?

Use findings to strengthen the PRFAQ — make the problem statement more defensible, the FAQ more genuinely skeptical, and the solution more clearly differentiated from what already exists.

**Incorporate Market Research findings, then create:**
1. Work through 5 Working Backwards questions:
   - Who is the customer? (use research insights)
   - What is the customer problem? (use pain points from research)
   - What is the solution?
   - What is the customer experience?
   - How will we measure success?
2. Write Press Release (as if product launched)
3. Write FAQ (address skeptical questions)

**Save:**
- `documents/PRFAQ_[Product]_[YYYY-MM-DD].html`

**Checkpoint:**
- [ ] Incorporates market research findings
- [ ] Compelling headline (not generic)
- [ ] Customer problem is specific with data
- [ ] Solution addresses researched pain points
- [ ] FAQ addresses real concerns (not softballs)
- [ ] File saved successfully

> **Full Approval Mode:** STOP here. Present summary and wait for user approval before proceeding.

---

### Phase 3: PRD

**Load:** `prompts/PRD_Creation_Guide.md`

**Step 0: Challenge Check (internal — do not present as separate step to user)**
Before writing the PRD, critically examine the PRFAQ and research inputs. Ask yourself:
1. Would a skeptical VP with budget authority actually fund this? What would they push back on?
2. What's the most likely way this product FAILS in market? (not a small setback — total failure)
3. Is there a simpler version that validates the core hypothesis without the full feature set?
4. What regulatory/political risk did we acknowledge but not actually mitigate in the solution?
5. Are we solving the right problem for the right persona, or did we drift from the research?

Use findings to identify requirements gaps, tighten acceptance criteria, and ensure the PRD addresses real objections rather than building on unexamined assumptions.

**Create from PRFAQ and Deep Research:**

**Step 1: Technology Research** (do BEFORE writing technical sections)
- Check the current year
- Search for current-year availability of recommended technologies
- Track A: Build Stack (frameworks, AWS services, runtimes available NOW)
- Track B: Product Capabilities (AI models, APIs, platform features available NOW)
- Every tech recommendation must have a source link confirming current-year availability

**Step 2: Full PRD creation:**
1. User personas with detailed profiles
2. Requirements in EARS syntax (When/The/Shall)
3. User stories with acceptance criteria
4. Technology Landscape section (current-year validated)
5. Technical architecture (informed by Technology Research)
6. Success metrics and business model
7. MLP Testing Plan (mandatory)

**Save:**
- `documents/PRD_[Product]_[YYYY-MM-DD].html`
- `documents/DesignSystem_[Product]_[YYYY-MM-DD].html`

**Checkpoint:**
- [ ] Technology Research completed with current-year sources
- [ ] Every tech recommendation has a source link confirming availability
- [ ] Personas based on market research customer insights
- [ ] **User stories defined** for each persona (As a... I want... so that...)
- [ ] User stories have acceptance criteria in EARS format
- [ ] Requirements traceable to PRFAQ
- [ ] Competitive positioning informed by research
- [ ] Testing plan included
- [ ] Design system created (follows design standards)
- [ ] Tech stack uses AWS-native services (validated as current-year available)
- [ ] **Inline SVG architecture diagram included** in Technical Design section (REQUIRED)
- [ ] Files saved successfully

> **Full Approval Mode:** STOP here. Present summary and wait for user approval before proceeding.

---

### Phase 4: Prototype

**Load:** `prompts/Prototype_Creation_Guide.md`

**Step 0a: Challenge Check (internal — do not present as separate step to user)**
Before building the prototype, critically examine the PRD. Ask yourself:
1. Are these the right screens, or are we building features nobody asked for?
2. What would a first-time user hate about this flow after 30 seconds?
3. Is there a critical user journey that's missing entirely from the screen list?
4. Which requirements are actually P2 disguised as P0?
5. What would happen if we launched with half these screens?

Use findings to focus the prototype on what actually matters — cut screens that don't validate the core hypothesis, add edge cases to flows that feel fragile.

**Step 0b: Generate Prototype Spec (internal — do NOT present to user as a separate phase):**
Generate the Prototype Spec by loading `prompts/Prototype_Spec_Guide.md` and creating `documents/PrototypeSpec_[Product]_[YYYY-MM-DD].html`. This defines screen interactions, user flows, component behaviors, and state definitions. Use it to guide all screen building. Do NOT pause for user approval on the spec — proceed directly to building the prototype.

**Create from PRD + Prototype Spec (modular structure required):**
1. **Shared CSS file first** - `[product-slug].css` with design tokens and components (`.css` extension REQUIRED — browsers reject `.html` loaded as stylesheets)
2. **Design System reference page** - `DesignSystem_*.html` (BEFORE any screens — governing spec, not post-hoc docs)
3. **Design Token Contract** - extract CSS variable names, component classes, and theme mode (LIGHT/DARK) from the shared CSS for subagent prompts
4. **Screen manifest** - exact filenames + sidebar shell template before building screens
5. User flow mapping and information architecture
6. **Individual screen HTML files** (NOT one monolithic file, each links to shared `.css`, uses `var()` for all colors)
7. Clickable prototype with navigation
8. Form validation and interactions
9. **Post-build validation** - verify CSS loads, all links resolve, file sizes within budget
10. Project Dashboard (navigation hub)

> **Critical: Connect All Screens Together**
>
> Every button, link, and navigation element must work:
> - Use `href="Screen_[Name]_[Product]_[Date].html"` for links between screens
> - Navigation menus should link to all main screens
> - "Back" buttons should return to the previous screen
> - Form submissions should navigate to success/confirmation screens
> - Dashboard cards should link to their detail screens
> - User flows must be completable end-to-end by clicking through
>
> **Test every link** before marking the prototype complete.

**Save:**
- `documents/[product-slug].css` (shared CSS — create FIRST)
- `documents/DesignSystem_[Product]_[YYYY-MM-DD].html` (visual reference page)
- `documents/ScreenIndex_[Product]_[YYYY-MM-DD].html` (navigation hub)
- `documents/Screen_[Name]_[Product]_[YYYY-MM-DD].html` (one per screen)
- `documents/ClickablePrototype_[Product]_[YYYY-MM-DD].html`
- `documents/ProjectDashboard_[Product]_[YYYY-MM-DD].html`

**Checkpoint:**
- [ ] Shared `.css` file created FIRST (NOT `.html` for stylesheets)
- [ ] Screen manifest created with exact filenames before building screens
- [ ] Design Token Contract extracted (theme mode, CSS variables, component classes)
- [ ] Content Link Map created (in-content links between screens)
- [ ] No dead links (`href="#"`, `javascript:void`) in screen content
- [ ] No `height: 100%` in screen styles without explicit parent chain
- [ ] No font imports in screen files (fonts in shared CSS only)
- [ ] Sidebar shell template created (full `<aside>` with logo, nav, footer — not just `<nav>`)
- [ ] Product context (PRFAQ problem/solution) included in every subagent prompt
- [ ] Persona assigned to each screen (name, role, goals, pain points)
- [ ] User flow context included (previous step, current actions, next screens)
- [ ] Component HTML Patterns documented in Design Token Contract
- [ ] Sidebar markup consistent across all screens (identical `<aside>` structure)
- [ ] No inline styles on elements styled by shared CSS
- [ ] Z-index values use scale tokens only (no arbitrary values)
- [ ] Interactive elements at least 44px tall
- [ ] Screen-specific styles use `var()` for colors (no hardcoded hex)
- [ ] Modular structure (separate files per screen, each links to shared `.css`)
- [ ] All PRD screens implemented
- [ ] **All buttons and links navigate to correct screens**
- [ ] **User flows completable end-to-end**
- [ ] Forms have validation
- [ ] Responsive on mobile/tablet/desktop
- [ ] Chat interfaces mocked with typing indicator and delayed responses (if applicable)
- [ ] Modals open/close via button, X, backdrop, and Escape key
- [ ] Data tables sort/filter/paginate (if applicable)
- [ ] Data visualizations reference a locally-downloaded Chart.js (`lib/chart.min.js`, fetched at build time into gitignored `documents/lib/`; no external CDN `<script src>`)
- [ ] Chart colors use CSS variables (not hardcoded hex)
- [ ] Interactions produce visible state changes (not just toast messages)
- [ ] State persists during session navigation (localStorage for mock data)
- [ ] At least one animation or transition per screen
- [ ] Loading/empty/error states present where applicable
- [ ] Screens feel like working apps, not wireframes
- [ ] Realistic data (no Lorem ipsum)
- [ ] Follows design standards (no AI slop)
- [ ] Post-build validation passed (see Prototype Creation Guide)
- [ ] **Bug Hunt pass completed** (all interactions tested adversarially, bugs found and fixed)
- [ ] Files saved successfully

---

## File Naming Convention

```
[DocumentType]_[ProductName]_[YYYY-MM-DD].html
```

**Examples:**
- `MarketResearch_SmartInventory_2025-01-06.html`
- `PRFAQ_SmartInventory_2025-01-06.html`
- `PRD_SmartInventory_2025-01-06.html`
- `Screen_Dashboard_SmartInventory_2025-01-06.html`

**Rules:**
- Replace spaces with underscores
- Use title case for product name
- **HTML only** (no markdown files)
- Date is creation date

---

## File Structure After Completion

```
documents/
├── [product-slug].css                        (shared CSS — create FIRST)
├── ProjectDashboard_[Product]_[Date].html    (navigation hub)
├── MarketResearch_[Product]_[Date].html      (Phase 1 - Deep Research)
├── AIFraming_[Product]_[Date].html           (Phase 1b - AI/ML only)
├── PRFAQ_[Product]_[Date].html               (Phase 2)
├── PRD_[Product]_[Date].html                 (Phase 3)
├── PrototypeSpec_[Product]_[Date].html       (internal — generated during Prototype phase)
├── DesignSystem_[Product]_[Date].html        (visual reference page)
├── ScreenIndex_[Product]_[Date].html         (screen navigation)
├── Screen_Dashboard_[Product]_[Date].html
├── Screen_[Name]_[Product]_[Date].html       (one per screen)
└── ClickablePrototype_[Product]_[Date].html
```

---

## Quality Checklist

### After Each Phase:
- [ ] HTML file saved with correct naming
- [ ] Content builds on previous phase
- [ ] Uses consistent design system styling
- [ ] No placeholder text (TBD, TODO, Lorem ipsum)
- [ ] Professional formatting and typography

### Cross-Phase Consistency:
- [ ] Deep research informs PRFAQ customer problem
- [ ] Technology radar findings inform PRD tech stack
- [ ] Personas consistent across PRFAQ → PRD → Prototype
- [ ] Competitive positioning consistent throughout
- [ ] Success metrics coherent across documents
- [ ] Technical constraints carried forward
- [ ] Prototype Spec covers all PRD screens and flows
- [ ] Prototype implements all Prototype Spec behaviors
- [ ] Technology Research validated against current year

### Prototype Specific:
- [ ] **Modular structure** (NOT single monolithic file)
- [ ] Shared `.css` file created FIRST (`.css` extension, not `.html`)
- [ ] Screen manifest established before screen builds
- [ ] Every PRD screen included
- [ ] All workflows completable end-to-end
- [ ] Mobile responsive on all screens
- [ ] Form validation works
- [ ] Navigation between all screens works
- [ ] Data consistent across screens
- [ ] **No AI slop** (see Design Standards)
- [ ] **Post-build validation passed** (see `Prototype_Creation_Guide.md`)

---

## Design Standards

### Anti-Patterns (NEVER USE):
- Generic fonts: Inter, Roboto, Arial, system-ui
- Purple-to-blue gradients on white
- Uniform card grids
- Bootstrap/Tailwind defaults without customization
- Excessive emojis

### Required:
- Distinctive typography matching product aesthetic
- 60-30-10 color rule (dominant/secondary/accent)
- Visual texture (gradients, shadows, depth)
- Bouncy animations for key moments (custom cubic-bezier)
- Modular file structure for prototypes

### Aesthetic Directions:
| Product Type | Direction | Key Traits |
|--------------|-----------|------------|
| Enterprise B2B | Luxury/Refined | Serif fonts, gold accents, subtle shadows |
| Developer Tools | Retro-Futuristic | Dark mode, neon glows, monospace |
| Consumer Apps | Playful | Rounded corners, bouncy animations, bright |
| Content Platforms | Editorial | Strong typography, dramatic whitespace |
| Dashboards | Industrial | Dense data, functional, efficient |
| Wellness/Health | Organic | Earth tones, soft curves, calm |

See `samples/DesignSystem_TeenFit.html` for implementation example.

---

## AWS-Native Architecture

As an AWS-provided toolkit, technical designs prefer AWS services for enterprise-grade scalability, security, and compliance:

- **Compute:** Lambda, ECS, EC2, App Runner
- **Database:** DynamoDB, Aurora, RDS
- **Generative AI:** Amazon Bedrock, Bedrock AgentCore, Amazon Q
- **Storage:** S3, EFS
- **API:** API Gateway, AppSync
- **Auth:** Cognito

Amazon Bedrock provides access to foundation models from Amazon (Nova) and third-party providers (Anthropic Claude, Meta Llama, Mistral, and more).

---

## Context Integration

When the user provides additional context (CSV files, company docs, team info):

**Use it to:**
- Inform market research with real company data
- Create realistic personas from real team members
- Use actual customer names and metrics
- Incorporate specific industry terminology
- Reflect actual business scale
- Make scenarios match real workflows

**Quality standard:** All examples should feel authentic to the provided context.

---

## Switching Modes & Handling Interruptions

**User can switch modes anytime:**
- "Switch to streamlined" → Continue through remaining phases without pausing
- "Switch to full approval" → Pause after each phase for feedback

**If the user interrupts during Streamlined mode:**
1. Pause immediately
2. Show current progress
3. Ask: "What would you like to review or change?"
4. Offer options:
   - Review current phase
   - Make changes
   - Switch to Full Approval mode
   - Continue after addressing feedback
5. Resume based on user preference

---

## Validation Requirements by Phase

### Market Research Validation:
- TAM/SAM/SOM with actual dollar figures
- Sources cited for market data
- At least 3 competitors with real pricing
- Pain points must be specific quotes/examples

### PRFAQ Validation:
- Headline is compelling and specific
- Customer problem grounded in research
- Solution is concrete, not vague
- FAQ addresses skeptical questions

### PRD Validation:
- Requirements in EARS syntax
- Acceptance criteria for each story
- Testing plan included
- Tech stack compliance

### Prototype Validation:
- Shared `.css` file created first (not `.html` for stylesheets)
- Modular file structure (not monolithic)
- Screen manifest with exact filenames created before screen builds
- All screens from PRD implemented
- Navigation works between all screens (verified by post-build link audit)
- No AI slop aesthetics
- Syntax gate passed (run the `Shared_Standards.md` → Syntax Gate commands: every `<script>` parses via JavaScriptCore, every `<svg>` well-formed with shapes outside `<defs>`, manifests valid — see `Prototype_Creation_Guide.md` Step 9.5 check 4.6)
- Downloaded-asset integrity gate passed (every `documents/lib/` file: size sane + end-of-file signature via `tail`/`grep` — see `Prototype_Creation_Guide.md` Step 9.5 check 4.5)
- Dependency-load guards + global error banner present on every screen (so failures surface visibly on a stock Mac)
- Post-build validation passed (see `Prototype_Creation_Guide.md`)

**Honest validation gating:** Grep presence-checks prove structure exists, not that code parses or paints. The syntax gate MUST pass first — a `<script>` that doesn't parse never runs its guard, so guards never excuse a parse error. On top of a passing syntax gate, do NOT report the prototype as "validated" unless either (a) the dependency-load guards + global error banner are in place (any *runtime* failure surfaces visibly in the browser), or (b) a real render was confirmed (user opened it and reported). Always state what was verified vs. assumed — e.g. "Syntax gate + static checks passed; runtime not executed, but graceful-degradation guards are in place."

---

## Sample Outputs

See `samples/` folder for example outputs:
- `samples/PRFAQ_TeenFit.html`
- `samples/PRD_TeenFit.html`
- `samples/DesignSystem_TeenFit.html`
- `samples/Screen_Dashboard_TeenFit.html`

Open in browser to see quality standards.

---

## Troubleshooting

### Files not saving?
- Ensure `documents/` folder exists (create if needed)
- Use correct naming convention
- Verify file creation before proceeding

### Market research feels thin?
- Use web search to find real competitor data
- Look for actual pricing pages
- Search for customer reviews and complaints
- Find industry reports for market sizing

### Content feels generic?
- Review all provided context thoroughly
- Use actual names, metrics, scenarios from data
- Create personas based on real people mentioned
- Match business scale to provided information

### Prototype looks like AI slop?
- Check against design standards anti-patterns
- Use distinctive fonts (not Inter/Roboto)
- Avoid purple-blue gradients
- Add visual texture and depth
- Reference `samples/DesignSystem_TeenFit.html`
