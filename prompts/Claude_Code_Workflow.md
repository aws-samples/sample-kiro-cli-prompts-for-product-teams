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
Discovery → Market Research → [AI Framing] → PRFAQ → PRD → Prototype
                               (optional)
```

| Phase | Output | Guide to Load |
|-------|--------|---------------|
| 1 | Market Research | `Market Research Agent.md` |
| 1b | AI Framing (ML products only) | `AI Framing Agent.md` |
| 2 | PRFAQ | `PRFAQ Guide.md` |
| 3 | PRD | `PRD Creation Guide.md` |
| 4 | Prototype | `Prototype Creation Guide.md` |

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
> "I'll work through 4 phases: Market Research → PRFAQ → PRD → Prototype. By default, I'll pause after each phase for your feedback. If you'd prefer I work through everything continuously, just say 'switch to streamlined' at any time."

### Determine if AI/ML product:
**AI/ML indicators:** ML models, predictions, NLP, computer vision, recommendations, automated decisions, pattern recognition, generative AI.

- **If AI/ML:** Include Phase 1b (AI Framing) after Market Research
- **If standard:** Skip Phase 1b, go directly to PRFAQ

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

### Phase 1: Market Research

**Load:** `prompts/Market Research Agent.md`

> **Important:** Use web search to find real competitor data, pricing, market reports, and customer reviews. Don't make up data.

**Conduct web-based research:**
1. **Competitive Landscape** (3-5 competitors)
   - Product offerings and positioning
   - Pricing models with actual figures
   - Strengths and weaknesses
2. **Market Sizing**
   - TAM (Total Addressable Market) with sources
   - SAM (Serviceable Addressable Market)
   - SOM (Serviceable Obtainable Market)
3. **Customer Pain Points**
   - From reviews, forums, social media
   - Specific quotes and examples
   - Unmet needs in current solutions
4. **Pricing Intelligence**
   - Competitor pricing tiers
   - Industry benchmarks
5. **Brand Research** (if building for existing company)
   - Logo, colors, typography
   - Brand voice and positioning

**Save:**
- `documents/MarketResearch_[Product]_[YYYY-MM-DD].html`

**Checkpoint:**
- [ ] TAM/SAM/SOM with dollar figures and sources
- [ ] At least 3 competitors with real pricing
- [ ] Pain points are specific, not generic
- [ ] No placeholder text (TBD, TODO, [insert])
- [ ] File saved successfully

> **Full Approval Mode:** STOP here. Present summary and wait for user approval before proceeding.

---

### Phase 1b: AI Framing (AI/ML Products Only)

**Load:** `prompts/AI Framing Agent.md`

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

**Load:** `prompts/PRFAQ Guide.md`

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

**Load:** `prompts/PRD Creation Guide.md`

**Create from PRFAQ and Market Research:**
1. User personas with detailed profiles
2. Requirements in EARS syntax (When/The/Shall)
3. User stories with acceptance criteria
4. Success metrics and business model
5. Technical constraints (AWS/Anthropic stack)
6. MLP Testing Plan (mandatory)

**Save:**
- `documents/PRD_[Product]_[YYYY-MM-DD].html`
- `documents/DesignSystem_[Product]_[YYYY-MM-DD].html`

**Checkpoint:**
- [ ] Personas based on market research customer insights
- [ ] Requirements traceable to PRFAQ
- [ ] Competitive positioning informed by research
- [ ] Testing plan included
- [ ] Design system created (follows design standards)
- [ ] Tech stack uses AWS-native services
- [ ] Files saved successfully

> **Full Approval Mode:** STOP here. Present summary and wait for user approval before proceeding.

---

### Phase 4: Prototype

**Load:** `prompts/Prototype Creation Guide.md`

**Create from PRD (modular structure required):**
1. **Design System first** - shared CSS tokens and components
2. User flow mapping
3. Information architecture
4. **Individual screen HTML files** (NOT one monolithic file)
5. Clickable prototype with navigation
6. Form validation and interactions
7. Project Dashboard (navigation hub)

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
- `documents/DesignSystem_[Product]_[YYYY-MM-DD].html` (create FIRST)
- `documents/ScreenIndex_[Product]_[YYYY-MM-DD].html` (navigation hub)
- `documents/Screen_[Name]_[Product]_[YYYY-MM-DD].html` (one per screen)
- `documents/ClickablePrototype_[Product]_[YYYY-MM-DD].html`
- `documents/ProjectDashboard_[Product]_[YYYY-MM-DD].html`

**Checkpoint:**
- [ ] Design system created FIRST with shared CSS
- [ ] Modular structure (separate files per screen)
- [ ] All PRD screens implemented
- [ ] **All buttons and links navigate to correct screens**
- [ ] **User flows completable end-to-end**
- [ ] Forms have validation
- [ ] Responsive on mobile/tablet/desktop
- [ ] Realistic data (no Lorem ipsum)
- [ ] Follows design standards (no AI slop)
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
├── ProjectDashboard_[Product]_[Date].html    (navigation hub)
├── MarketResearch_[Product]_[Date].html      (Phase 1)
├── AIFraming_[Product]_[Date].html           (Phase 1b - AI/ML only)
├── PRFAQ_[Product]_[Date].html               (Phase 2)
├── PRD_[Product]_[Date].html                 (Phase 3)
├── DesignSystem_[Product]_[Date].html        (shared CSS)
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
- [ ] Market research informs PRFAQ customer problem
- [ ] Personas consistent across PRFAQ → PRD → Prototype
- [ ] Competitive positioning consistent throughout
- [ ] Success metrics coherent across documents
- [ ] Technical constraints carried forward

### Prototype Specific:
- [ ] **Modular structure** (NOT single monolithic file)
- [ ] Design system created FIRST
- [ ] Every PRD screen included
- [ ] All workflows completable end-to-end
- [ ] Mobile responsive on all screens
- [ ] Form validation works
- [ ] Navigation between all screens works
- [ ] Data consistent across screens
- [ ] **No AI slop** (see Design Standards)

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
- Modular file structure (not monolithic)
- Design system created first
- All screens from PRD implemented
- Navigation works between all screens
- No AI slop aesthetics

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
