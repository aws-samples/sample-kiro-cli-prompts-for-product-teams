---
name: regenerate-screen-index
description: Rebuild the ScreenIndex navigation hub from the Screen_*.html files actually present in documents/ — after adding, removing, or renaming prototype screens. Keywords: regenerate the screen index, rebuild the index, index is out of date, update the navigation hub.
---

# Regenerate ScreenIndex

Rebuild `documents/ScreenIndex_[Product]_[YYYY-MM-DD].html` from the screens that exist on disk — never from memory of what was built.

## Procedure

1. **Inventory reality:** `ls documents/Screen_*.html` — this list is the source of truth. Parse `[Name]`, `[Product]`, `[Date]` from each filename.
2. **Recover brand context** from the existing ScreenIndex (if present) or `documents/[product-slug].css`: `[CUSTOMER_LOGO]`, `[BRAND_PRIMARY]`, `[BRAND_SECONDARY]`, `[BRAND_ACCENT]`. If neither exists, ask the user.
3. **Regenerate wholesale** from `references/ScreenIndex_Template.html` (never str-replace structural HTML in the old file). Replace all placeholders: `[PRODUCT_NAME]`, `[PRODUCT_SLUG]`, `[CUSTOMER_LOGO]`, `[BRAND_PRIMARY]`, `[BRAND_SECONDARY]`, `[BRAND_ACCENT]`, `[DATE]` (today), `[PROGRESS_PERCENT]`, `[SCREEN_COUNT]` (count from step 1), `[SCREEN_CARDS]` (one card per screen found).
4. **Per-card rules:** the entry-point screen (Dashboard, or the first in nav order) gets `screen-card entry-point`; every card's link href must be the exact filename from step 1; per-card `[THUMBNAIL_URL]` gets a real thumbnail or the `.screen-preview-placeholder` fallback — never the literal placeholder.
5. **Verify before declaring done:** every `Screen_*.html` on disk has exactly one card; every card href resolves to a file on disk (`grep -o 'href="Screen_[^"]*"'` against `ls`); no `[` placeholder tokens remain (`grep -c '\[[A-Z_]*\]'` → 0).
6. `open` the regenerated file and report: screens indexed, screens added/removed vs the previous index.

## References

| Need | Read |
|------|------|
| Nav-hub template | `references/ScreenIndex_Template.html` |

Path is relative to this skill directory, so it resolves wherever the plugin is installed.
