# Review Lenses

Self-contained definitions for the on-demand review lenses the `product-reviewer` runs. Run ONE lens at a time, named in the prompt. Each produces findings with specific `file:element` references and concrete fixes; do not fix unless asked.

## Customer Interview Simulator

_Roleplay as personas to stress-test product_

Roleplay as each PRD persona:

1. Adopt their mindset and frustrations
2. React honestly to the product pitch
3. Ask skeptical questions they would ask
4. Identify what would make them NOT use this
5. What would make them evangelists?

Be real, not nice.

## Competitive Response Analyzer

_Predict competitor reactions_

For each competitor:
1. How might they respond?
2. What can they quickly copy?
3. Likely pricing response?

Our defensible advantages:
- What's hard to replicate?
- What moats can we build?

Save to documents/CompetitiveAnalysis_[Product]_[Date].html

## Risk Analyzer

_Identify risks and mitigations_

Analyze risks:

1. Product risks (fit, usability, adoption)
2. Business risks (competition, timing, resources)

For each: Likelihood, Impact, Mitigation

Save to documents/RiskAnalysis_[Product]_[Date].html

## Feature Prioritizer (RICE)

_Prioritize features using RICE framework_

Score each PRD feature using RICE:

- Reach: How many users affected?
- Impact: How much improvement? (3=massive, 2=high, 1=medium, 0.5=low)
- Confidence: How sure are we? (100%, 80%, 50%)
- Effort: Person-weeks to build

RICE = (Reach × Impact × Confidence) / Effort

Rank features by score.

## Accessibility Auditor

_Check WCAG compliance_

Audit prototype for WCAG AA:

- [ ] Color contrast (4.5:1 text, 3:1 UI)
- [ ] Keyboard navigation works
- [ ] Focus indicators visible
- [ ] ARIA labels on interactive elements
- [ ] Alt text on images
- [ ] Form labels associated

Report issues with fixes.

## Interactivity & Link Checker

_Verify all prototype interactions and links work_

Check all Screen_*.html files for FULL INTERACTIVITY:

**Navigation:**
1. List every href in each file
2. Verify target file exists
3. Check for broken links
4. Verify user flows completable end-to-end
5. Grep for href=\"#\" in all Screen_*.html — flag as dead links
6. Grep for javascript:void in all Screen_*.html — flag as dead links
7. Every actionable element (card, button, CTA) should link to a real screen, not # or void

**Interactions:**
8. Chat interfaces have mocked responses (typing indicator, simulated replies)
9. Forms have JavaScript for validation, loading, success/error states
10. Dropdowns have onclick/onchange handlers
11. Modals have open/close functionality
12. Data tables have sort/filter/paginate handlers (if applicable)

Report broken links AND missing interactions. Prototype must be FULLY CLICKABLE.
