# Brand & Logo Rules

Self-contained brand-source and logo-verification rules. The full Logo Gate protocol also lives in the prototype skill's `Prototype_Creation_Guide.md` Step 1.1.

## Which company's logo?

**⚠️ The logo must be for the CUSTOMER company — the company this product is being built FOR.** The market-research phase surfaces *competitor* logos and branding. Do NOT use a competitor's, partner's, or sponsor's logo. If uncertain which company is the customer, check `customer_company` in the handoff payload or ask the user.

## Finding the customer's logo (in priority order)

1. **Web image search first:** `"[Customer Name]" logo` — most reliable.
2. **Schema.org / Clearbit / Wikipedia** — check before scraping.
3. **HTML scrape last:** prioritize `alt` text containing the customer name, NOT filenames containing "logo".
4. **Do NOT trust filenames** — `partner-logo.png` in a carousel is not the site logo.

## The Logo Gate (mandatory — all 5 checks must pass)

- [ ] **HTTP 200** — `curl -sI "[URL]" | head -5`
- [ ] **File size 2KB–50KB** — `curl -sI "[URL]" | grep -i content-length`
- [ ] **Downloaded and LOOKED AT the image** — `curl -sL -o /tmp/logo_check.png "[URL]"` then read it
- [ ] **The image shows the CUSTOMER's brand** (not a partner, sponsor, or different company)
- [ ] **Stated out loud:** "This logo belongs to [Customer] because [reason]"

**HTTP 200 alone is NOT verification.** You MUST download and visually confirm the image. If you cannot confidently say it is the customer's logo → **ask the user**. A text placeholder is always better than the wrong company's logo.

**Logo verification loop:** try URL → fetch fails? → try next URL → repeat until success.

## Brand colors & typography

- **Extract brand colors** — visit the customer's website, read exact hex values; use them as CSS variables.
- **Identify typography** — their fonts, or the closest Google Fonts match.

## Where the verified logo goes

- **Market Research:** `<img src="[VERIFIED-URL]">` in the "Brand Assets" section.
- **Design System:** their colors as CSS variables.
- **Prototypes:** logo in header, login screens, and footer.
