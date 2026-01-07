# Product Team's Tool Chest

A comprehensive toolkit that transforms AI coding assistants into your personal product development partner. Go from idea to interactive prototype with specialized support for AI/ML products.

## Overview

This toolkit provides **steering files for [Kiro](https://kiro.dev)** that guide an AI assistant through a complete product development workflow:

> **What is Kiro?** Kiro is an AI-powered IDE that uses "steering files" to guide AI behavior with project-specific instructions. Steering files are markdown documents in `.kiro/steering/` that provide context, workflows, and constraints. When you work in Kiro, these files automatically shape how the AI assistant responds - no manual prompting required.

```
Discovery → Market Research → PRFAQ → PRD → Prototype
```

Each phase produces professional deliverables as styled HTML documents that can be viewed in a browser and shared with stakeholders.

## Quick Start (Kiro)

1. **Copy steering files** to your project:
   ```bash
   cp -r .kiro/steering/* your-project/.kiro/steering/
   cp .kiro/hooks.json your-project/.kiro/
   ```

2. **Open your project in Kiro** and describe your product idea

3. **The workflow runs automatically:**
   - Market research with web search
   - PRFAQ (Press Release / FAQ) using Working Backwards methodology
   - PRD with detailed requirements
   - Interactive HTML prototype with modular screens

All outputs are **standalone HTML files** that open directly in any browser - no build step or server required. Share them with stakeholders by simply sending the files.

## Workflow Phases

### Phase 1: Market Research
- Competitive landscape analysis (3-5 competitors)
- Market sizing (TAM/SAM/SOM with sources)
- Customer pain points research
- Pricing intelligence
- Customer brand research (logo, colors) if applicable

**Output:** `MarketResearch_[Product]_[Date].html`

### Phase 1b: AI Framing (Optional)
Only for AI/ML products. Defines:
- ML problem type (classification, regression, etc.)
- Input/output schemas
- Success metrics and thresholds
- Training data requirements

### Phase 2: PRFAQ
Amazon-style Working Backwards documentation:
- Press Release (as if product already launched)
- FAQ addressing customer and business questions
- Incorporates market research findings

**Output:** `PRFAQ_[Product]_[Date].html`

### Phase 3: PRD (Requirements)
Implementation-ready specification:
- User personas with detailed profiles
- Requirements in EARS syntax (When/The/Shall format)
- User stories with acceptance criteria
- Success metrics and business model
- Technical constraints (AWS/Anthropic stack only)

**Output:** `PRD_[Product]_[Date].html` + `.kiro/specs/[product]/requirements.md`

### Phase 4: Prototype
Interactive HTML prototype with:
- **Modular file structure** (not monolithic)
- Distinctive visual design (no generic "AI slop")
- Working navigation between screens
- Form validation and feedback
- Responsive layouts (desktop, tablet, mobile)
- Realistic data (no Lorem ipsum)

**Output:**
```
documents/
├── DesignSystem_[Product]_[Date].html    (shared CSS)
├── ScreenIndex_[Product]_[Date].html     (navigation hub)
├── Screen_Dashboard_[Product]_[Date].html
├── Screen_[Name]_[Product]_[Date].html   (one per screen)
└── ProjectDashboard_[Product]_[Date].html
```

## File Structure

```
CLAUDE.md                       (auto-loads in Claude Code)
.cursorrules                    (auto-loads in Cursor)

.kiro/
├── steering/
│   ├── product-workflow.md     (main orchestration - always loaded)
│   ├── design-standards.md     (visual standards - always loaded)
│   ├── market-research.md      (research guide - manual)
│   ├── prfaq-guide.md          (PRFAQ guide - manual)
│   ├── prd-guide.md            (PRD guide - manual)
│   └── prototype-guide.md      (prototype guide - manual)
└── hooks.json                  (agent hooks for automation)

prompts/                        (Claude Code / Cursor workflow)
├── Claude_Code_Workflow.md     (main workflow guide)
├── Market Research Agent.md
├── PRFAQ Guide.md
├── PRD Creation Guide.md
└── Prototype Creation Guide.md

documents/                      (auto-generated outputs)
├── MarketResearch_*.html
├── PRFAQ_*.html
├── PRD_*.html
├── DesignSystem_*.html
├── Screen_*.html
└── ProjectDashboard_*.html

samples/                        (example outputs for reference)
├── DesignSystem_TeenFit.html
├── PRFAQ_TeenFit.html
├── PRD_TeenFit.html
└── Screen_*.html
```

## Steering Files

| File | Inclusion | Purpose |
|------|-----------|---------|
| `product-workflow.md` | always | Main workflow orchestration |
| `design-standards.md` | always | Visual design standards |
| `market-research.md` | manual | Web-based research guide |
| `prfaq-guide.md` | manual | PRFAQ creation guide |
| `prd-guide.md` | manual | PRD and Kiro spec guide |
| `prototype-guide.md` | manual | Prototype creation guide |

## Agent Hooks

Pre-configured hooks in `.kiro/hooks.json` provide 26 PM-focused agents:

**Automatic Validation (on file save):**
- Market Research, PRFAQ, PRD, AI Framing validators
- Design System Consistency (prevents AI slop)
- Tech Stack Validator (prefers AWS-native services)

**Core Workflow (manual):**
- Run Market Research → Create PRFAQ → Create PRD → Create Prototype

**Research & Analysis:**
- Customer Interview Simulator (roleplay as personas)
- Competitive Response Analyzer
- User Journey Mapper
- Risk Analyzer
- Competitor Feature Matrix

**Strategy:**
- Feature Prioritizer (RICE)
- A/B Test Hypothesis Generator

**Prototype & UX:**
- Microcopy Writer
- Onboarding Flow Designer
- Accessibility Auditor (WCAG)

**Team & Communication:**
- Stakeholder Update Generator
- Demo Script Writer
- Meeting Notes to Requirements

See `.kiro/hooks.json` for the full hook configuration.

## Design Standards

The toolkit enforces distinctive design to avoid generic "AI slop":

**Anti-Patterns (never use):**
- Generic fonts: Inter, Roboto, Arial
- Purple-to-blue gradients on white
- Uniform card grids
- Bootstrap/Tailwind defaults
- Excessive emojis (unless essential to product tone)

**Required:**
- Distinctive typography per aesthetic direction
- 60-30-10 color rule (dominant/secondary/accent)
- Bouncy animations for key moments
- Visual texture (gradients, shadows, depth)
- Modular file structure for prototypes

## Validation

Each phase includes validation checkpoints:
- Completeness - All required sections present
- Quality - Content is specific and sourced
- Consistency - Aligns with previous phases
- Format - Correct naming conventions

The workflow will not proceed until validation passes.

## AWS-Native Architecture

As an AWS-provided toolkit, PRD technical designs prefer AWS services for enterprise-grade scalability, security, and compliance:

- **Compute:** Lambda, ECS, EC2, App Runner
- **Database:** DynamoDB, Aurora, RDS
- **Generative AI:** Amazon Bedrock, Bedrock AgentCore, Amazon Q
- **Storage:** S3, EFS
- **API:** API Gateway, AppSync
- **Auth:** Cognito

Amazon Bedrock provides access to foundation models from Amazon (Nova) and third-party providers (Anthropic Claude, Meta Llama, Mistral, and more).

## Claude Code / Cursor Mode

For Claude Code or Cursor, copy the auto-loading config files to your project:

```bash
cp CLAUDE.md your-project/       # For Claude Code
cp .cursorrules your-project/    # For Cursor
cp -r prompts/ your-project/prompts/
```

The workflow loads automatically when you open your project. Just describe your product idea and the AI will guide you through the phases.

See `prompts/Claude_Code_Workflow.md` for the complete workflow guide.

## Requirements

- **[Kiro](https://kiro.dev)** (recommended) - AI-powered IDE with native steering file support
- **Or** any AI coding assistant with file system access (Claude Code, Cursor, etc.)
- Web search capability for market research phase (built into most AI tools)

## Output Format

All documents are generated as **self-contained HTML files**:
- No external dependencies beyond Google Fonts CDN
- Open directly in any browser (`open documents/PRD_MyProduct_2025-01-06.html`)
- Print to PDF for offline sharing
- Fully styled with professional formatting

## Sample Files

The `samples/` folder includes example outputs from a "TeenFit" project:

```
samples/
├── DesignSystem_TeenFit.html      (design tokens & components)
├── PRFAQ_TeenFit.html             (press release & FAQ)
├── PRD_TeenFit.html               (product requirements)
├── Screen_Dashboard_TeenFit.html  (prototype screen)
├── Screen_Welcome_TeenFit.html    (prototype screen)
└── Screen_WorkoutExecution_TeenFit.html
```

Open any sample in your browser to see the output quality and design standards. The Design System sample includes extensive comments explaining the design philosophy.

## Security

See [CONTRIBUTING](CONTRIBUTING.md#security-issue-notifications) for more information.

## License

This library is licensed under the MIT-0 License. See the LICENSE file.
