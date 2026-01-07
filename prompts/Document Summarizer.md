# Document Summarizer Utility

This utility provides instructions for condensing phase outputs into efficient handoff payloads. Use this when preparing outputs for the next agent to minimize context consumption while preserving critical information.

## Purpose

Full documents (PRFAQ, PRD, etc.) can be 2000-5000+ tokens. Handoff summaries should be **~500 tokens** containing only what the next agent needs.

## Summarization Principles

1. **Preserve Decisions**: Keep key choices and their rationale
2. **Extract Essentials**: Pull out structured data (metrics, requirements, personas)
3. **Drop Formatting**: Remove markdown formatting, examples, verbose explanations
4. **Reference Artifacts**: Point to file paths instead of copying content
5. **Maintain Consistency**: Use exact names, values, and terminology

## Summarization Templates by Document Type

### Market Research → PRFAQ Handoff

**Input**: Full Market Research Brief (1500+ tokens)
**Output**: ~400 tokens

```json
{
  "market_research_summary": {
    "market_opportunity": "[2-3 sentence synthesis of TAM and growth]",
    "competitive_position": "[2-3 sentences on gaps and differentiation]",
    "top_competitors": [
      {"name": "...", "positioning": "...", "weakness": "..."}
    ],
    "customer_pain_points": [
      {"pain": "...", "severity": "critical|high|medium"}
    ],
    "pricing_guidance": "[recommended positioning and price range]",
    "key_risks": ["...", "..."]
  }
}
```

**What to DROP:**
- Full competitor feature lists
- All research source URLs (keep top 3)
- Detailed market sizing calculations
- Industry trend details beyond top 3
- Customer buying criteria details

**What to KEEP:**
- TAM figure and growth rate
- Top 3-5 competitors with positioning
- Top 3-5 pain points with severity
- Pricing recommendation
- Key differentiation opportunities

---

### AI Framing → PRFAQ/PRD Handoff

**Input**: Full AI Framing Document (1000+ tokens)
**Output**: ~300 tokens

```json
{
  "ai_framing_summary": {
    "ml_problem_statement": "[1-2 sentence problem definition]",
    "inputs_outputs": {
      "inputs": ["..."],
      "outputs": ["..."]
    },
    "key_metrics": [
      {"metric": "...", "target": "...", "business_impact": "..."}
    ],
    "data_strategy": "[1-2 sentences on data approach]",
    "feasibility": "high|medium|low",
    "technical_risks": ["...", "..."]
  }
}
```

**What to DROP:**
- Full metric selection guide
- Detailed evaluation methodology
- Complete checklist items
- Extended technical-business mapping

**What to KEEP:**
- ML problem statement (Given X, predict Y)
- Selected metrics with thresholds (top 3-5)
- Data strategy summary
- Feasibility assessment
- Top technical risks

---

### PRFAQ → PRD Handoff

**Input**: Full PRFAQ Document (1500+ tokens)
**Output**: ~400 tokens

```json
{
  "prfaq_summary": {
    "headline": "[press release headline]",
    "customer_definition": "[2-3 sentences from Working Backwards Q1]",
    "problem_statement": "[2-3 sentences from Working Backwards Q2]",
    "solution_description": "[2-3 sentences from Working Backwards Q3]",
    "key_benefit": "[single most important benefit]",
    "success_metrics": ["...", "...", "..."],
    "faq_themes": ["...", "...", "..."]
  },
  "working_backwards": {
    "customer": "[50-100 words]",
    "problem": "[50-100 words]",
    "solution": "[50-100 words]",
    "experience": "[50-100 words]",
    "success": "[50-100 words]"
  }
}
```

**What to DROP:**
- Full press release prose
- Complete FAQ questions and context
- Formatting and section headers
- Internal notes and assumptions
- Verbose explanations

**What to KEEP:**
- Headline (for tone/positioning)
- Working Backwards answers (condensed)
- Key benefit statement
- Success metrics list
- Main FAQ themes (not full questions)

---

### PRD → Prototype Handoff

**Input**: Full PRD Document (3000+ tokens)
**Output**: ~500 tokens

```json
{
  "prd_summary": {
    "product_overview": "[2-3 sentences]",
    "personas": [
      {
        "name": "...",
        "role": "...",
        "primary_need": "...",
        "key_workflow": "..."
      }
    ],
    "core_requirements": [
      {
        "id": "REQ-001",
        "requirement": "...",
        "priority": "P0|P1|P2",
        "acceptance_criteria": ["..."]
      }
    ],
    "screens_needed": ["Dashboard", "Detail View", "Settings", "..."],
    "user_flows": [
      {"name": "...", "steps": ["...", "...", "..."]}
    ],
    "success_kpis": [
      {"metric": "...", "target": "..."}
    ],
    "business_model": {
      "pricing_tiers": ["..."],
      "revenue_model": "..."
    }
  }
}
```

**What to DROP:**
- Full persona narratives (keep summary)
- Detailed requirement descriptions
- Complete acceptance criteria lists (keep top 2-3 per req)
- Timeline and milestone details
- Resourcing section
- Stakeholder details
- Appendices
- Outstanding questions

**What to KEEP:**
- Persona names, roles, and primary needs
- P0 and P1 requirements with key acceptance criteria
- All identified screens
- Primary user flows (steps only)
- Success KPIs with targets
- Pricing tier names and revenue model

---

## Summarization Quality Checklist

Before sending a handoff, verify:

### Size Check
- [ ] Total payload is under 600 tokens
- [ ] Each summary field is under 100 words
- [ ] Lists have 3-7 items (not exhaustive)

### Content Check
- [ ] All names/terms match source document exactly
- [ ] Numbers and metrics are accurate
- [ ] No placeholder text remains
- [ ] Critical decisions are preserved

### Completeness Check
- [ ] Next agent has enough to work independently
- [ ] No circular references (don't say "see document")
- [ ] Artifact paths are included for full details

### Consistency Check
- [ ] Product name matches across all fields
- [ ] Persona names consistent
- [ ] Terminology aligned with source

---

## Token Estimation Guide

Rough token counts for planning:

| Content Type | Approx Tokens |
|-------------|---------------|
| 100 words | ~130 tokens |
| 1 JSON object (5 fields) | ~50 tokens |
| 1 persona summary | ~80 tokens |
| 1 requirement summary | ~60 tokens |
| 1 user flow (5 steps) | ~40 tokens |

**Target**: 400-600 tokens per handoff payload

---

## Example: Full Summarization

### Input (PRFAQ excerpt - ~800 tokens)
```markdown
# TeenFit: Gamified Fitness for the Next Generation

## Press Release

**San Francisco, CA** — January 3, 2026 — TeenFit today announced the launch of its revolutionary fitness app designed specifically for teenagers aged 13-18. The app combines gamification, social challenges, and age-appropriate workout routines to make fitness fun and engaging for a generation that struggles with traditional exercise approaches.

Today's teenagers face unprecedented challenges with physical activity. Studies show that only 24% of teens get the recommended 60 minutes of daily physical activity, leading to rising obesity rates and associated health issues. Traditional fitness apps, designed for adults, fail to engage teenagers with their clinical interfaces and one-size-fits-all approaches.

TeenFit solves this by creating an experience that feels more like a game than a workout. Users earn XP, unlock achievements, compete with friends, and progress through levels as they complete workouts...

[continues for 600 more words]
```

### Output (Summarized - ~150 tokens)
```json
{
  "prfaq_summary": {
    "headline": "TeenFit: Gamified Fitness for the Next Generation",
    "customer_definition": "Teenagers aged 13-18 who struggle with traditional fitness approaches. Only 24% get recommended daily activity.",
    "problem_statement": "Traditional fitness apps fail to engage teens with clinical interfaces. Rising obesity rates and health issues result from inactivity.",
    "solution_description": "Gamified fitness app with XP, achievements, social challenges, and age-appropriate workouts that feels like a game.",
    "key_benefit": "Makes fitness fun and engaging for teenagers",
    "success_metrics": ["Daily active users", "Workout completion rate", "30-day retention"],
    "faq_themes": ["Safety/parental controls", "Social features", "Pricing"]
  }
}
```

**Reduction**: 800 tokens → 150 tokens (81% reduction)

---

## Integration with Agents

Each agent should:

1. **On Completion**: Run summarization before handoff
2. **Validate Size**: Check token count is under limit
3. **Include Paths**: Always reference full artifact paths
4. **Log Both**: Save full output AND summary for debugging

The Orchestrator will:
1. Receive full agent output
2. Apply summarization template
3. Validate handoff payload
4. Route to next agent with minimal context
