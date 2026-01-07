---
inclusion: manual
---

# PRFAQ Guide

This steering file guides PRFAQ creation using Amazon's "Working Backwards" methodology. Include this when creating Press Release and FAQ documents.

## Working Backwards Questions

Before writing, answer these 5 questions:

1. **Who is the customer and what insights do we have about them?**
2. **What is the prevailing customer problem/opportunity?**
3. **What is the solution? Why is it the right solution versus alternatives?**
4. **How would we describe the end-to-end customer experience?**
5. **How will we define and measure success?**

## PRFAQ Document Structure

```markdown
# [Product Name]: [Attention-Grabbing Headline]

_Press Release and Frequently Asked Questions_

**Date:** [Month Day, Year]

---

## Press Release

### [Compelling Headline That Captures the News]

**[City, State]** — [Date] — [Opening paragraph: What is being announced and why it matters]

[Problem paragraph: The customer pain point this addresses]

[Solution paragraph: How the product solves this problem uniquely]

"[Quote from company spokesperson about vision and impact]," said [Name], [Title] at [Company].

[Customer benefit paragraph: Specific value customers will receive]

[Getting started paragraph: How customers can begin using the product]

[Closing paragraph: Broader impact and call to action]

---

## Frequently Asked Questions

### Customer Questions

1. **Who is this for?**
2. **How does it work?**
3. **What does it cost?**
4. **How do I get started?**
5. **What support is available?**

### Technical Questions (if AI/ML product)

6. **What data do you need?**
7. **How accurate is it?**

### Business Questions

8. **Does it integrate with [existing tools]?**
9. **Is my data secure?**
10. **What's on the roadmap?**

---

## Internal Notes

### Working Backwards Summary
- **Customer:** [Brief customer definition]
- **Problem:** [Core problem statement]
- **Solution:** [Solution approach]
- **Experience:** [Key experience elements]
- **Success:** [Success metrics]

### Key Assumptions to Validate
- [Assumption 1]
- [Assumption 2]
- [Assumption 3]
```

## Writing Guidelines

### Press Release Tone
- Written as if the product already exists
- Customer-focused, not feature-focused
- Clear, jargon-free language
- Specific and concrete
- Grounded in market reality
- Avoid excessive emojis unless essential to the product's tone (e.g., playful apps for younger audiences)

### FAQ Guidelines
- Questions customers would actually ask
- Address concerns and objections
- Provide substantive answers
- 5-10 questions covering:
  - Who/what/why
  - How it works
  - Pricing and availability
  - Getting started
  - Technical requirements (if applicable)

### For AI/ML Products
- Explain AI capabilities in customer terms
- Address trust and transparency concerns
- Include questions about data privacy

## Using Market Research

If you have market research from the web_search and web_fetch tools, incorporate:
- Competitive gaps into differentiation story
- Customer pain points into problem statement
- Pricing intelligence into FAQ

## Output Files

Save to `./documents/`:
- `PRFAQ_[ProductSlug]_[YYYY-MM-DD].html`

**Do NOT create .md files.** All documents must be styled HTML that opens in a browser.

## Quality Checklist

- [ ] Press release tells a compelling story
- [ ] Customer problem is clearly articulated
- [ ] Solution differentiation is evident
- [ ] FAQs address real customer concerns
- [ ] Market research insights incorporated
- [ ] AI/ML aspects explained accessibly (if applicable)
