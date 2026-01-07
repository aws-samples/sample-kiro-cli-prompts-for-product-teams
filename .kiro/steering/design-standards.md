---
inclusion: always
---

# Design Standards

This steering file provides visual design standards for all prototype and UI work. Apply these consistently across all generated HTML/CSS.

## Design Philosophy

Create **distinctive, production-grade interfaces** that avoid generic "AI slop" aesthetics. Every prototype should be visually striking and memorable.

## Anti-Patterns (NEVER USE)

- Generic fonts: Inter, Roboto, Arial, system-ui defaults
- Cliché colors: Purple-to-blue gradients on white
- Predictable layouts: Uniform card grids
- Bootstrap/Tailwind defaults without customization
- Flat solid backgrounds without texture
- Excessive emojis: Only use emojis when essential to the design tone (e.g., playful apps for younger audiences). For most products, use icons or typography instead.

## Aesthetic Directions

Choose ONE direction based on product type:

| Product Type | Direction | Key Traits |
|-------------|-----------|------------|
| Enterprise B2B | Luxury/Refined | Serif fonts, gold accents, subtle shadows |
| Developer Tools | Retro-Futuristic | Dark mode, neon glows, monospace |
| Consumer Apps | Playful | Rounded corners, bouncy animations, bright |
| Content Platforms | Editorial | Strong typography, dramatic whitespace |
| Dashboards | Industrial | Dense data, functional, efficient |
| Wellness/Health | Organic | Earth tones, soft curves, calm |

## Typography

**Font Pairings by Direction:**

```css
/* Luxury */
--font-display: 'Cormorant Garamond', serif;
--font-body: 'DM Sans', sans-serif;

/* Retro-Futuristic */
--font-display: 'Space Grotesk', sans-serif;
--font-mono: 'JetBrains Mono', monospace;

/* Playful */
--font-display: 'Nunito', sans-serif;

/* Editorial */
--font-display: 'Fraunces', serif;
--font-body: 'DM Sans', sans-serif;

/* Industrial */
--font-display: 'IBM Plex Sans', sans-serif;
--font-mono: 'IBM Plex Mono', monospace;

/* Organic */
--font-display: 'Lora', serif;
--font-body: 'Source Sans 3', sans-serif;
```

## Color Strategy

Follow 60-30-10 rule:
- **60%** Dominant (surface/background)
- **30%** Secondary (text, borders)
- **10%** Accent (CTAs, highlights)

## Motion

Focus on high-impact moments:
1. **Page Load**: Staggered reveals with animation-delay
2. **Transitions**: Smooth crossfades between screens
3. **Hover States**: Subtle but noticeable transforms
4. **Success/Error**: Celebratory or attention-grabbing feedback

```css
:root {
  --duration-fast: 200ms;
  --duration-normal: 300ms;
  --ease-out: cubic-bezier(0.16, 1, 0.3, 1);
  --ease-bounce: cubic-bezier(0.34, 1.56, 0.64, 1);
}
```

## Customer Brand Research

If building for a specific company:

1. **Search**: `"[Company]" brand guidelines`
2. **Fetch**: Company website homepage
3. **Extract**: Colors, fonts, button styles, patterns
4. **Apply**: Use their exact colors and patterns
5. **Extend**: Only use creative direction for unspecified elements

## File Naming

**Use modular file structure** (NOT a single monolithic file):

```
documents/
├── DesignSystem_[Product]_[Date].html    (shared CSS - create FIRST)
├── ScreenIndex_[Product]_[Date].html     (navigation hub)
├── Screen_Dashboard_[Product]_[Date].html
├── Screen_[Name]_[Product]_[Date].html   (one per screen)
└── ProjectDashboard_[Product]_[Date].html
```

## Quality Checklist

- [ ] Distinctive fonts (NOT generic)
- [ ] Color hierarchy (dominant + accent)
- [ ] Animations present
- [ ] Visual texture (gradients, shadows)
- [ ] Layout has spatial interest
- [ ] Mobile responsive
- [ ] WCAG AA contrast compliance
