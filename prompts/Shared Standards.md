# Shared Standards

This document contains standards and conventions that ALL specialized agents must follow. Reference this file to ensure consistency across the workflow.

---

## File Naming Conventions

### Document Files
```
[DocumentType]_[ProductNameSlug]_[YYYY-MM-DD].[ext]
```

| Document Type | Example |
|--------------|---------|
| Market Research | `MarketResearch_TeenFit_[YYYY-MM-DD].json` |
| AI Framing | `AIFraming_TeenFit_[YYYY-MM-DD].md` |
| PRFAQ | `PRFAQ_TeenFit_[YYYY-MM-DD].md` |
| PRD | `PRD_TeenFit_[YYYY-MM-DD].md` |
| Design System | `DesignSystem_TeenFit_[YYYY-MM-DD].html` |
| Prototype Spec | `Prototype_TeenFit_[YYYY-MM-DD].md` |
| Individual Screen | `Screen_Dashboard_TeenFit_[YYYY-MM-DD].html` |
| Clickable Prototype | `ClickablePrototype_TeenFit_[YYYY-MM-DD].html` |
| Project Dashboard | `ProjectDashboard_TeenFit_[YYYY-MM-DD].html` |

### Product Name Slug Rules
- Replace spaces with underscores
- Use PascalCase for words
- Remove special characters
- Examples:
  - "Teen Fit App" → `TeenFit_App`
  - "AI-Powered CRM" → `AIPowered_CRM`
  - "Real-Time Analytics" → `RealTime_Analytics`

### Directory Structure
```
project_root/
├── prompts/                    # Agent prompts (read-only)
├── templates/                  # Templates (read-only)
└── documents/                  # Generated artifacts
    ├── handoffs/              # Inter-agent communication logs
    └── [all generated files]
```

---

## HTML Document Standards

### Required Meta Tags
```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="generator" content="Product Development Toolkit">
    <meta name="created" content="[YYYY-MM-DD]">
    <meta name="product" content="[Product Name]">
    <meta name="phase" content="[Phase Name]">
    <title>[Document Title] - [Product Name]</title>
</head>
```

### Typography Scale
```css
:root {
    --font-family-primary: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
    --font-family-mono: 'SF Mono', 'Monaco', 'Consolas', monospace;

    --font-size-xs: 0.75rem;    /* 12px */
    --font-size-sm: 0.875rem;   /* 14px */
    --font-size-base: 1rem;     /* 16px */
    --font-size-lg: 1.125rem;   /* 18px */
    --font-size-xl: 1.25rem;    /* 20px */
    --font-size-2xl: 1.5rem;    /* 24px */
    --font-size-3xl: 1.875rem;  /* 30px */
    --font-size-4xl: 2.25rem;   /* 36px */

    --line-height-tight: 1.25;
    --line-height-normal: 1.5;
    --line-height-relaxed: 1.75;
}
```

### Spacing Scale
```css
:root {
    --space-1: 0.25rem;   /* 4px */
    --space-2: 0.5rem;    /* 8px */
    --space-3: 0.75rem;   /* 12px */
    --space-4: 1rem;      /* 16px */
    --space-5: 1.25rem;   /* 20px */
    --space-6: 1.5rem;    /* 24px */
    --space-8: 2rem;      /* 32px */
    --space-10: 2.5rem;   /* 40px */
    --space-12: 3rem;     /* 48px */
    --space-16: 4rem;     /* 64px */
}
```

### Default Color Palette
Use these as defaults when no brand guidelines are provided:

```css
:root {
    /* Primary */
    --color-primary-50: #eff6ff;
    --color-primary-100: #dbeafe;
    --color-primary-500: #3b82f6;
    --color-primary-600: #2563eb;
    --color-primary-700: #1d4ed8;

    /* Neutral */
    --color-gray-50: #f9fafb;
    --color-gray-100: #f3f4f6;
    --color-gray-200: #e5e7eb;
    --color-gray-300: #d1d5db;
    --color-gray-500: #6b7280;
    --color-gray-700: #374151;
    --color-gray-900: #111827;

    /* Semantic */
    --color-success: #10b981;
    --color-warning: #f59e0b;
    --color-error: #ef4444;
    --color-info: #3b82f6;
}
```

### Responsive Breakpoints
```css
/* Mobile first approach */
/* Base styles apply to mobile (< 640px) */

@media (min-width: 640px) {
    /* Small tablets and large phones */
}

@media (min-width: 768px) {
    /* Tablets */
}

@media (min-width: 1024px) {
    /* Laptops and desktops */
}

@media (min-width: 1280px) {
    /* Large screens */
}
```

---

## Markdown Document Standards

### Document Header
```markdown
# [Document Title]
_[Document Type] for [Product Name]_

**Date:** [Month Day, Year]
**Version:** 1.0
**Status:** [Draft | Review | Approved]

---
```

### Section Formatting
- Use `##` for major sections
- Use `###` for subsections
- Use `####` sparingly for sub-subsections
- Include horizontal rules (`---`) between major sections

### Lists and Tables
- Use bullet points for unordered lists
- Use numbered lists for sequences or priorities
- Use tables for comparative data
- Align table columns for readability

### Code and Technical Content
- Use inline code for `file names`, `commands`, and `technical terms`
- Use fenced code blocks with language specification for code samples
- Include comments in code samples when helpful

---

## Quality Checklist (All Agents)

Before completing any phase output, verify:

### Content Quality
- [ ] All required sections are present
- [ ] Content is specific, not generic placeholder text
- [ ] Data and examples are realistic (use provided context if available)
- [ ] No lorem ipsum or "TBD" placeholders remain
- [ ] Terminology is consistent throughout

### File Quality
- [ ] File saved to correct location (`./documents/`)
- [ ] File naming convention followed exactly
- [ ] Both markdown and HTML versions created (where applicable)
- [ ] HTML is valid and renders correctly
- [ ] All internal links work

### Handoff Quality
- [ ] Output structured per Handoff Schema
- [ ] Summary fields are under 500 characters
- [ ] All required fields populated
- [ ] Artifact paths are correct and files exist

---

## Accessibility Standards

All HTML documents must meet WCAG 2.1 AA:

### Color Contrast
- Normal text: 4.5:1 minimum contrast ratio
- Large text (18px+ or 14px+ bold): 3:1 minimum
- UI components: 3:1 minimum

### Keyboard Navigation
- All interactive elements focusable via Tab
- Visible focus indicators
- Logical tab order
- No keyboard traps

### Screen Reader Support
- Semantic HTML structure
- Alt text for images
- ARIA labels for icons and controls
- Proper heading hierarchy

### Motion and Animation
- Respect `prefers-reduced-motion`
- No auto-playing animations over 5 seconds
- Pause/stop controls for animations

---

## Error Message Standards

### User-Facing Errors
```
[What happened] + [Why it happened] + [What to do next]
```

Example:
```
Unable to save document. The documents folder doesn't exist.
Please create a 'documents' folder in your project directory.
```

### Agent Handoff Errors
```json
{
  "error": {
    "code": "DESCRIPTIVE_ERROR_CODE",
    "message": "Human-readable description",
    "context": {
      "phase": "string",
      "attempted_action": "string"
    },
    "recovery": ["Suggested action 1", "Suggested action 2"]
  }
}
```

---

## Context Integration Rules

When user provides context files (CSV, company docs, etc.):

### DO
- Use actual names, values, and metrics from provided data
- Create personas based on real team members mentioned
- Reflect actual business scale and complexity
- Use industry-specific terminology from context
- Reference specific products, customers, or scenarios

### DON'T
- Ignore provided context in favor of generic examples
- Make up data when real data is available
- Use placeholder names when real names are provided
- Override user-provided metrics with assumptions

### Priority Order
1. Explicitly stated user requirements
2. Data from provided context files
3. Information from market research
4. Reasonable industry defaults

---

## Version Control

### Document Versioning
- Date in filename serves as version identifier
- Previous versions preserved (not overwritten)
- Major revisions get new date

### Change Tracking
For significant revisions:
```markdown
## Revision History

| Date | Version | Changes | Author |
|------|---------|---------|--------|
| [Date] | 1.0 | Initial creation | AI Agent |
| [Date] | 1.1 | Updated personas per user feedback | AI Agent |
```

---

## Aesthetic Direction Examples

These complete examples demonstrate how to implement distinctive visual directions. Use these as templates when no customer brand is specified.

### Example 1: Luxury/Refined (Enterprise B2B)

**Direction**: Sophisticated, premium, trustworthy
**Best for**: Enterprise tools, financial products, professional services

```css
@import url('https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@400;600;700&family=DM+Sans:wght@400;500;600&display=swap');

:root {
  /* Typography */
  --font-display: 'Cormorant Garamond', serif;
  --font-body: 'DM Sans', sans-serif;

  /* Colors - Warm neutrals with gold accent */
  --color-surface: #FDFBF7;
  --color-surface-elevated: #FFFFFF;
  --color-text-primary: #1A1A1A;
  --color-text-secondary: #6B6B6B;
  --color-accent: #C9A227;
  --color-accent-muted: rgba(201, 162, 39, 0.1);
  --color-border: #E8E4DC;

  /* Shadows - Subtle, layered */
  --shadow-sm: 0 1px 2px rgba(0,0,0,0.04);
  --shadow-md: 0 4px 12px rgba(0,0,0,0.06);
  --shadow-lg: 0 8px 24px rgba(0,0,0,0.08);

  /* Borders - Refined */
  --radius-sm: 4px;
  --radius-md: 8px;
  --radius-lg: 12px;
}

/* Signature: Elegant underline on headings */
h1::after {
  content: '';
  display: block;
  width: 60px;
  height: 2px;
  background: var(--color-accent);
  margin-top: 16px;
}
```

### Example 2: Retro-Futuristic (Tech/Gaming)

**Direction**: Neon-lit, dark, energetic
**Best for**: Gaming, developer tools, entertainment, tech startups

```css
@import url('https://fonts.googleapis.com/css2?family=Space+Grotesk:wght@400;500;700&family=JetBrains+Mono:wght@400;500&display=swap');

:root {
  /* Typography */
  --font-display: 'Space Grotesk', sans-serif;
  --font-body: 'Space Grotesk', sans-serif;
  --font-mono: 'JetBrains Mono', monospace;

  /* Colors - Dark with neon accents */
  --color-surface: #0A0A0F;
  --color-surface-elevated: #14141F;
  --color-text-primary: #FFFFFF;
  --color-text-secondary: #8888AA;
  --color-accent: #00FFD1;
  --color-accent-secondary: #FF00AA;
  --color-accent-muted: rgba(0, 255, 209, 0.15);
  --color-border: #2A2A3F;

  /* Glow effects */
  --glow-accent: 0 0 20px rgba(0, 255, 209, 0.4);
  --glow-secondary: 0 0 20px rgba(255, 0, 170, 0.4);

  /* Borders - Sharp */
  --radius-sm: 2px;
  --radius-md: 4px;
  --radius-lg: 8px;
}

/* Signature: Glowing borders on focus/hover */
.card:hover {
  box-shadow: var(--glow-accent);
  border-color: var(--color-accent);
}

/* Gradient mesh background */
body {
  background:
    radial-gradient(at 20% 80%, rgba(0, 255, 209, 0.1) 0%, transparent 50%),
    radial-gradient(at 80% 20%, rgba(255, 0, 170, 0.1) 0%, transparent 50%),
    var(--color-surface);
}
```

### Example 3: Playful/Toy-like (Consumer Apps)

**Direction**: Friendly, approachable, fun
**Best for**: Consumer apps, kids products, social platforms, fitness

```css
@import url('https://fonts.googleapis.com/css2?family=Nunito:wght@400;600;700;800&display=swap');

:root {
  /* Typography */
  --font-display: 'Nunito', sans-serif;
  --font-body: 'Nunito', sans-serif;

  /* Colors - Bright and cheerful */
  --color-surface: #FFFFFF;
  --color-surface-elevated: #F8F9FF;
  --color-text-primary: #2D3047;
  --color-text-secondary: #6B7280;
  --color-accent: #6366F1;
  --color-accent-secondary: #F472B6;
  --color-success: #10B981;
  --color-warning: #FBBF24;

  /* Shadows - Playful, colorful */
  --shadow-sm: 0 2px 8px rgba(99, 102, 241, 0.1);
  --shadow-md: 0 4px 16px rgba(99, 102, 241, 0.15);
  --shadow-lg: 0 8px 32px rgba(99, 102, 241, 0.2);

  /* Borders - Very rounded */
  --radius-sm: 8px;
  --radius-md: 16px;
  --radius-lg: 24px;
  --radius-full: 9999px;
}

/* Signature: Bouncy hover animations */
.button {
  transition: transform 0.2s cubic-bezier(0.34, 1.56, 0.64, 1);
}
.button:hover {
  transform: translateY(-2px) scale(1.02);
}

/* Gradient backgrounds */
.hero {
  background: linear-gradient(135deg, #6366F1 0%, #8B5CF6 50%, #F472B6 100%);
}
```

### Example 4: Editorial/Magazine (Content Platforms)

**Direction**: Sophisticated typography, dramatic whitespace
**Best for**: Media, publications, portfolios, content platforms

```css
@import url('https://fonts.googleapis.com/css2?family=Fraunces:opsz,wght@9..144,400;9..144,600;9..144,700&family=Inter:wght@400;500&display=swap');

:root {
  /* Typography - Strong contrast */
  --font-display: 'Fraunces', serif;
  --font-body: 'Inter', sans-serif;

  /* Colors - High contrast, minimal */
  --color-surface: #FAFAFA;
  --color-surface-elevated: #FFFFFF;
  --color-text-primary: #0A0A0A;
  --color-text-secondary: #717171;
  --color-accent: #E11D48;
  --color-border: #E5E5E5;

  /* Shadows - Subtle */
  --shadow-sm: 0 1px 3px rgba(0,0,0,0.05);
  --shadow-md: 0 4px 6px rgba(0,0,0,0.07);

  /* Borders - Minimal */
  --radius-sm: 0;
  --radius-md: 2px;
  --radius-lg: 4px;
}

/* Signature: Dramatic type scale */
h1 { font-size: 4rem; line-height: 1.1; letter-spacing: -0.02em; }
h2 { font-size: 2.5rem; line-height: 1.2; }

/* Pull quotes */
blockquote {
  font-family: var(--font-display);
  font-size: 2rem;
  border-left: 4px solid var(--color-accent);
  padding-left: 24px;
  margin: 48px 0;
}
```

### Example 5: Industrial/Utilitarian (Dashboards)

**Direction**: Dense, efficient, data-focused
**Best for**: Admin tools, analytics, operations dashboards

```css
@import url('https://fonts.googleapis.com/css2?family=IBM+Plex+Sans:wght@400;500;600&family=IBM+Plex+Mono:wght@400;500&display=swap');

:root {
  /* Typography - Clear, efficient */
  --font-display: 'IBM Plex Sans', sans-serif;
  --font-body: 'IBM Plex Sans', sans-serif;
  --font-mono: 'IBM Plex Mono', monospace;

  /* Colors - Muted, professional */
  --color-surface: #F4F4F4;
  --color-surface-elevated: #FFFFFF;
  --color-text-primary: #161616;
  --color-text-secondary: #525252;
  --color-accent: #0F62FE;
  --color-border: #E0E0E0;

  /* Data visualization colors */
  --color-data-1: #0F62FE;
  --color-data-2: #6929C4;
  --color-data-3: #1192E8;
  --color-data-4: #005D5D;
  --color-data-5: #9F1853;

  /* Tight spacing */
  --space-xs: 4px;
  --space-sm: 8px;
  --space-md: 12px;
  --space-lg: 16px;

  /* Borders - Functional */
  --radius-sm: 2px;
  --radius-md: 4px;
}

/* Signature: Dense data tables */
.data-table {
  font-size: 13px;
  border-collapse: collapse;
}
.data-table td {
  padding: 8px 12px;
  border-bottom: 1px solid var(--color-border);
}

/* Status indicators */
.status-dot {
  width: 8px;
  height: 8px;
  border-radius: 50%;
  display: inline-block;
}
```

### Example 6: Organic/Natural (Wellness)

**Direction**: Calm, grounded, natural
**Best for**: Wellness, sustainability, healthcare, mindfulness

```css
@import url('https://fonts.googleapis.com/css2?family=Lora:wght@400;500;600&family=Source+Sans+3:wght@400;500;600&display=swap');

:root {
  /* Typography - Warm, readable */
  --font-display: 'Lora', serif;
  --font-body: 'Source Sans 3', sans-serif;

  /* Colors - Earth tones */
  --color-surface: #FAF9F6;
  --color-surface-elevated: #FFFFFF;
  --color-text-primary: #2D3E32;
  --color-text-secondary: #5F7161;
  --color-accent: #4A7C59;
  --color-accent-warm: #C17F59;
  --color-border: #E2DED5;

  /* Soft shadows */
  --shadow-sm: 0 2px 8px rgba(45, 62, 50, 0.06);
  --shadow-md: 0 4px 16px rgba(45, 62, 50, 0.08);

  /* Rounded, soft borders */
  --radius-sm: 8px;
  --radius-md: 16px;
  --radius-lg: 24px;
}

/* Signature: Organic shapes */
.blob {
  border-radius: 60% 40% 30% 70% / 60% 30% 70% 40%;
}

/* Nature-inspired background */
body {
  background:
    radial-gradient(at 0% 100%, rgba(74, 124, 89, 0.05) 0%, transparent 50%),
    radial-gradient(at 100% 0%, rgba(193, 127, 89, 0.05) 0%, transparent 50%),
    var(--color-surface);
}
```

### Selecting an Aesthetic Direction

| Product Type | Recommended Aesthetic | Rationale |
|-------------|----------------------|-----------|
| Enterprise SaaS | Luxury/Refined | Conveys trust and professionalism |
| Developer Tools | Retro-Futuristic or Industrial | Appeals to technical users |
| Consumer Mobile | Playful/Toy-like | Encourages engagement |
| Content Platform | Editorial/Magazine | Emphasizes readability |
| Health/Wellness | Organic/Natural | Creates calm, trusted feel |
| Gaming/Entertainment | Retro-Futuristic | Matches audience expectations |
| Financial Services | Luxury/Refined | Conveys stability and trust |
| Admin Dashboard | Industrial/Utilitarian | Prioritizes efficiency |

---

## Performance Guidelines

### HTML File Size
- Individual screens: < 100KB
- Clickable prototype: < 500KB
- Optimize images if included

### Load Time Targets
- Dashboard: < 2 seconds
- Individual documents: < 1 second
- Clickable prototype: < 3 seconds

### Browser Support
- Chrome (last 2 versions)
- Firefox (last 2 versions)
- Safari (last 2 versions)
- Edge (last 2 versions)
