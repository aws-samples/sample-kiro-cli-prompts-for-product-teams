---
inclusion: manual
---

# Prototype Guide

This steering file guides the creation of distinctive, production-grade interactive prototypes. Apply design standards from `#steering/design-standards.md`.

## Design Philosophy

Create **visually striking and memorable** interfaces that avoid generic "AI slop" aesthetics. Commit to a BOLD aesthetic direction and execute it with precision.

## Pre-Prototype Checklist

Before building any screens:

1. **Load PRD requirements** - Know what screens and flows are needed
2. **Research existing product** - If modifying an existing product, fetch and analyze it first
3. **Research customer brand** - If building for a real company, get their brand assets
4. **Establish aesthetic direction** - Choose and document your design approach
5. **Define the memorable element** - What's the ONE thing people will remember?

## Existing Product Research

If this prototype modifies or extends an existing product:

1. **Search for the product:** "[Product Name] app", "[Product Name] screenshots", "[Product Name] UI"
2. **Fetch the product website/app store page** to understand current design
3. **Document existing patterns:**
   - Current color scheme
   - Navigation structure
   - Component styles
   - Interaction patterns
4. **Faithfully recreate existing components** - Match the current product's look and feel exactly
5. **Only add/modify what's specified** - Don't redesign components that aren't changing

When recreating existing UI:
- Match exact colors, spacing, typography
- Replicate button styles, form inputs, cards
- Copy navigation patterns and layout structure
- The prototype should look like it belongs in the existing product

## Customer Brand Research

If building for a specific company, use web_search to find brand assets.

**⚠️ IMPORTANT: Do NOT use web_fetch to download images/logos. web_fetch is for HTML pages only. Use curl for image verification.**

**Search queries:**
```
"[Company Name] brand guidelines"
"[Company Name] design system"
"[Company Name] logo"
"[Company Name] press kit"
```

**Fetch and analyze the company website.**

**Extract from website:**
- Primary and secondary colors (exact hex values)
- Typography (font families)
- Button and form styles
- Navigation patterns
- Visual tone

**Get the logo:**
- Search for "[Company Name] logo png" or "[Company Name] logo svg"
- Check their press kit or media page for official logo files
- **Verify with curl:** `curl -sI "[LOGO_URL]" | head -5` - must show 200 OK
- If URL fails (404/403), try another URL until one works
- If no logo available, use a text placeholder styled in their brand font

**Apply:** Use their exact colors, fonts, logos, and patterns. Only use creative direction for unspecified elements.

## Aesthetic Direction Selection

Choose ONE direction based on product type:

| Product Type | Direction | Key Traits |
|-------------|-----------|------------|
| Enterprise B2B | Luxury/Refined | Serif fonts, gold accents, subtle shadows |
| Developer Tools | Retro-Futuristic | Dark mode, neon glows, monospace |
| Consumer Apps | Playful | Rounded corners, bouncy animations, bright |
| Content Platforms | Editorial | Strong typography, dramatic whitespace |
| Dashboards | Industrial | Dense data, functional, efficient |
| Wellness/Health | Organic | Earth tones, soft curves, calm |

## Anti-Patterns (NEVER USE)

- Generic fonts: Inter, Roboto, Arial, system-ui defaults
- Cliche colors: Purple-to-blue gradients on white
- Predictable layouts: Uniform card grids
- Bootstrap/Tailwind defaults without customization
- Flat solid backgrounds without texture
- Excessive emojis: Only use emojis when essential to the design tone (e.g., playful apps for younger audiences). For most products, avoid emojis entirely - use icons or typography instead.

## Typography by Direction

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

## Color Strategy (60-30-10 Rule)

- **60%** Dominant (surface/background)
- **30%** Secondary (text, borders)
- **10%** Accent (CTAs, highlights)

## Motion & Animation

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

## Screen Requirements

### Required Screens
- Dashboard/Home (main entry point)
- Core workflow screens (from user flows)
- Authentication (login, signup)
- Settings/Preferences

### Required States
- Loading states (skeleton screens)
- Empty states (no data scenarios)
- Error states (failure scenarios)
- Success confirmations

### Responsive Breakpoints
- Desktop: 1024px+
- Tablet: 768px-1023px
- Mobile: <768px

## Interactive Features (CRITICAL - FULLY FUNCTIONAL)

**Every prototype must be FULLY CLICKABLE and INTERACTIVE. No dead ends.**

### Navigation (All Links Work)
- Working navigation between all screens
- Every button navigates to appropriate screen
- "Back" buttons return to previous screen
- Breadcrumbs are clickable
- Mobile menu toggle works

### Forms (Full Mock Behavior)
- Form validation with inline error messages
- Loading states during "submission" (spinner, disabled button)
- Success states with confirmation messages
- Error states with retry options
- Auto-focus on first field

### Chat Interfaces (MOCKED CONVERSATIONS)
If the prototype includes any chat or messaging:
- **Pre-populated conversation history** with realistic messages
- **Typing indicator** appears after user sends message
- **Simulated AI/bot responses** appear after 1-2 second delay
- **Multiple response variations** - different messages on different sends
- Input field clears after send
- Messages scroll into view
- Timestamp display on messages

```javascript
// Example chat mock
function simulateChat(userMessage) {
    showTypingIndicator();
    setTimeout(() => {
        hideTypingIndicator();
        const responses = [
            "I understand. Let me help you with that...",
            "Great question! Here's what I found...",
            "Based on your request, I recommend..."
        ];
        addBotMessage(responses[Math.floor(Math.random() * responses.length)]);
    }, 1500);
}
```

### Dropdowns & Selects (Functional)
- Clicking opens dropdown menu
- Options are selectable
- Selection updates the displayed value
- Dropdown closes after selection

### Modals & Dialogs (Functional)
- Open on trigger (button click, action)
- Close on X button, backdrop click, Escape key
- Form modals process and close
- Confirmation dialogs have working Yes/No buttons

### Data Tables (Interactive)
- Sort columns on header click
- Filter/search updates visible rows
- Pagination navigates between pages
- Row selection highlights row
- Action buttons on rows work

### Hover & Click States
- Buttons show hover/active states
- Cards have hover effects
- Links show hover underline/color change
- Interactive elements have cursor: pointer

### Loading States
- Skeleton screens for initial load
- Spinners for actions in progress
- Progress bars for multi-step operations
- Disabled states prevent double-clicks

### Toast Notifications
- Success toasts for completed actions
- Error toasts for failed actions
- Auto-dismiss after 3-5 seconds
- Manual dismiss with X button

### Mobile Interactions
- Hamburger menu toggles sidebar
- Swipe gestures where appropriate
- Pull-to-refresh visual (if applicable)
- Bottom sheet modals on mobile

## Output Files - MODULAR STRUCTURE (REQUIRED)

**DO NOT create a single monolithic HTML file.** Create separate files for each screen.

Save to `./documents/`:

### 1. Design System (create FIRST)
```
DesignSystem_[Product]_[YYYY-MM-DD].html
```
Contains:
- CSS variables (colors, fonts, spacing)
- Shared component styles (buttons, inputs, cards, navigation)
- Animation definitions
- This file is referenced by all screen files via `<link>` tag

### 2. Individual Screen Files (one per screen)
```
Screen_Dashboard_[Product]_[YYYY-MM-DD].html
Screen_Login_[Product]_[YYYY-MM-DD].html
Screen_Settings_[Product]_[YYYY-MM-DD].html
Screen_[ScreenName]_[Product]_[YYYY-MM-DD].html
```
Each screen file:
- Links to the shared DesignSystem CSS
- Contains only that screen's HTML and screen-specific JS
- Has working navigation links to other Screen_*.html files
- Is fully functional standalone

### 3. Screen Index (navigation hub)
```
ScreenIndex_[Product]_[YYYY-MM-DD].html
```
A visually striking navigation hub for reviewers. **Use the template at `.kiro/steering/templates/ScreenIndex_Template.html`**

**ScreenIndex must include:**
- Customer logo (from verified brand assets)
- Customer brand colors as CSS variables
- Links to all Screen_*.html files with visual cards
- Links to documentation (Design System, Market Research, PRFAQ, PRD)
- Progress indicator showing completion status
- Last updated timestamp
- Entry point screen highlighted (Dashboard) spanning 2 columns

**Replace these placeholders in the template:**
- `[PRODUCT_NAME]` - Product name
- `[PRODUCT_SLUG]` - URL-safe product name
- `[CUSTOMER_LOGO]` - Verified logo URL from market research
- `[BRAND_PRIMARY]` - Primary brand color hex (e.g., #007DC3)
- `[BRAND_SECONDARY]` - Secondary brand color hex
- `[BRAND_ACCENT]` - Accent color hex
- `[DATE]` - Current date (YYYY-MM-DD)
- `[PROGRESS_PERCENT]` - Completion percentage (0-100)
- `[SCREEN_COUNT]` - Number of screens
- `[SCREEN_CARDS]` - Generated screen card HTML

### File Structure Example
```
./documents/
├── DesignSystem_[Product]_[YYYY-MM-DD].html      (shared styles)
├── ScreenIndex_[Product]_[YYYY-MM-DD].html       (navigation hub)
├── Screen_Dashboard_[Product]_[YYYY-MM-DD].html  (main entry point)
├── Screen_Login_[Product]_[YYYY-MM-DD].html      (auth)
├── Screen_[Feature1]_[Product]_[YYYY-MM-DD].html (from PRD)
├── Screen_[Feature2]_[Product]_[YYYY-MM-DD].html (from PRD)
└── Screen_Settings_[Product]_[YYYY-MM-DD].html   (settings)
```

### Why Modular?
- **Easier to review** - Stakeholders can open individual screens
- **Easier to iterate** - Change one screen without touching others
- **Realistic navigation** - Tests actual user flows between pages
- **Smaller files** - Each file stays manageable

### Navigation Between Screens

**CRITICAL: Every button, link, and navigation element must work.**

Use relative links to connect screens:
```html
<a href="Screen_Dashboard_[Product]_[YYYY-MM-DD].html">Dashboard</a>
<a href="Screen_Settings_[Product]_[YYYY-MM-DD].html">Settings</a>
```

**Connect these elements:**
- Navigation menus → link to all main screens
- Dashboard cards → link to detail screens
- "Back" buttons → return to previous screen
- Form submissions → navigate to success/confirmation screens
- Call-to-action buttons → navigate to appropriate next step

**Test every link** by clicking through all user flows before marking complete.

## Quality Checklist

### Functional (FULLY INTERACTIVE)
- [ ] All PRD screens implemented
- [ ] **All buttons and links navigate to correct screens**
- [ ] **User flows completable end-to-end by clicking through**
- [ ] **Chat interfaces have mocked responses** (if applicable)
- [ ] **Forms submit with loading → success/error states**
- [ ] **Dropdowns/selects are functional**
- [ ] **Modals open/close correctly**
- [ ] **Data tables sort/filter/paginate** (if applicable)
- [ ] Forms have validation and feedback
- [ ] Responsive at all breakpoints
- [ ] Keyboard navigation works
- [ ] WCAG AA contrast compliance

### Design Quality
- [ ] Aesthetic direction documented
- [ ] Distinctive fonts (NOT generic)
- [ ] Color hierarchy (dominant + accent)
- [ ] Animations present for key moments
- [ ] Visual texture (not flat solid colors)
- [ ] Layout has spatial interest
- [ ] Memorable element is noticeable
- [ ] Would excite stakeholders

### Anti-Pattern Check
- [ ] NO purple-blue gradients on white
- [ ] NO Bootstrap/Tailwind defaults
- [ ] NO uniform card grids
- [ ] NO Inter/Roboto/Arial fonts

## Completion Requirements (DO NOT STOP UNTIL DONE)

**The prototype is not complete until ALL of the following are true:**

### Structure Requirements
1. **Modular files created** - NOT a single monolithic HTML file
2. **DesignSystem file exists** - Shared CSS created first
3. **ScreenIndex file exists** - Navigation hub for all screens
4. **Individual Screen files** - One HTML file per screen from PRD

### Functional Requirements
5. **Every component is fully mocked up** - No placeholder components, no "TODO" elements
6. **All interactions work** - Every button, link, form, and navigation element is functional
7. **Cross-screen navigation works** - Links between Screen_*.html files work correctly
8. **Forms submit and show feedback** - Validation, loading states, success/error responses
9. **Chat interfaces are mocked** - If chat exists, it shows typing indicators and simulated responses
10. **Dropdowns/selects work** - Click to open, select option, value updates
11. **Modals work** - Open on trigger, close on X/backdrop/Escape
12. **Data tables are interactive** - Sort, filter, paginate all functional (if applicable)
13. **Data is realistic** - Real-looking names, numbers, dates - no "Lorem ipsum" or "Test User"
14. **Responsive layouts work** - Desktop, tablet, and mobile all functional

### After Creating Each Screen
- **Open the screen file in the browser** to verify it renders correctly
- Run: `open ./documents/Screen_[Name]_[Product]_[YYYY-MM-DD].html` (macOS)
- Verify navigation links work
- Check responsive breakpoints

**Do not stop or ask for confirmation until the prototype meets all these requirements.**

If you encounter an issue:
- Fix it immediately
- Do not leave incomplete work
- Do not ask "should I continue?" - just finish the prototype
