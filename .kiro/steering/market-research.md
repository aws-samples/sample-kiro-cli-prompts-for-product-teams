---
inclusion: manual
---

# Market Research Guide

This steering file guides market research using built-in web search and fetch capabilities. Include this when conducting competitive analysis or market sizing.

## ⛔ CRITICAL TOOL RESTRICTIONS

### 1. NEVER use web_fetch for binary files
- web_fetch is ONLY for HTML pages
- For logo verification: `curl -sI "[URL]" | head -5`

### 2. BLOCKED SITES - Never fetch or use URLs from:
- ❌ logos.fandom.com
- ❌ fandom.com (any subdomain)
- ❌ wikipedia.org image URLs
- ❌ wikimedia.org
- ❌ Any wiki site

### 3. APPROVED logo sources ONLY:
- ✅ Official company website (company.com/press, company.com/media)
- ✅ clearbit.com/logo or logo.clearbit.com
- ✅ brandfetch.com

**If search results show fandom/wiki URLs, SKIP THEM completely.**

## Using Built-in Tools

Use the built-in **web_search** tool to find information and **web_fetch** tool to retrieve and analyze web page content. These tools are available without any additional configuration.

- **web_search**: Search the web for information on competitors, market data, and customer insights
- **web_fetch**: Fetch HTML pages to extract detailed information like pricing and features

**⚠️ IMPORTANT: Do NOT use web_fetch to download binary files (images, logos, PDFs). web_fetch is for HTML pages only. Use curl for image/logo verification.**

## Research Protocol

### 1. Competitive Landscape

**Search queries to run:**
```
"[industry] [solution type] companies"
"[industry] [solution type] startups"
"alternatives to [similar product]"
"[target audience] [problem] solutions"
```

**For each competitor found (3-7), fetch their website to analyze.**

**Extract from each:**
- Company name and positioning
- Target customer segment
- Pricing model and tiers
- Key features and differentiators
- Strengths and weaknesses

### 2. Market Sizing

**Search queries:**
```
"[industry] market size [current year]"
"[industry] market forecast CAGR"
"[target segment] spending on [category]"
```

**Document:**
- TAM (Total Addressable Market) with source
- SAM (Serviceable Addressable Market)
- SOM (Serviceable Obtainable Market)
- Growth rate and trends

### 3. Customer Insights

**Search queries:**
```
"[target audience] challenges [problem area]"
"[product category] reviews complaints"
"[target audience] buying behavior"
```

**Document:**
- Top 3-5 pain points with severity
- Current workarounds
- Buying criteria
- Price sensitivity indicators

### 4. Pricing Intelligence

**Search queries:**
```
"[competitor name] pricing"
"[category] pricing benchmarks"
"[industry] SaaS pricing models"
```

**Document:**
- Price range (low/mid/high)
- Common pricing models
- Recommended positioning

## Output Format

Save findings to `./documents/MarketResearch_[ProductName]_[YYYY-MM-DD].html` with these sections:

- **Executive Summary** (2-3 sentences)
- **Market Size** (TAM/SAM/SOM with cited sources)
- **Competitor Analysis** (3-5 competitors with positioning, pricing, strengths/weaknesses)
- **Customer Pain Points** (ranked by severity)
- **Pricing Recommendation**
- **Key Risks and Opportunities**
- **Customer Branding** (if applicable): logo URL, primary/secondary colors, fonts

**Do NOT create .md or .json files.** All documents must be styled HTML that opens in a browser.

## Research Depth Levels

| Level | Competitors | Market Data | Time |
|-------|-------------|-------------|------|
| Quick | 3 | TAM only | 10-15 min |
| Standard | 5 | TAM/SAM/SOM | 20-30 min |
| Comprehensive | 7+ | Full analysis | 45-60 min |

## Customer Brand Research

If building for a specific company:

**⚠️ Do NOT use web_fetch to download logos. Use curl instead.**

1. **Search:** "[Company Name] logo png" or "[Company Name] logo svg"
2. **Check:** Press kit or media page for official logo files
3. **Verify with curl:** `curl -sI "[LOGO_URL]" | head -5` - must show 200 OK
4. **If URL fails (404/403):** Try another URL until one works
5. **Extract:** Brand colors from their website (exact hex values)
6. **Note:** If logo unavailable, use styled text placeholder

## Best Practices

1. **Cite sources** - Note URLs for key claims
2. **Verify recency** - Prefer data from last 12 months
3. **Cross-reference** - Don't rely on single source for key metrics
4. **Note limitations** - Document when data is unavailable
5. **Be specific** - Use actual numbers, not vague terms
6. **Fetch pages** - Don't rely on search snippets alone
