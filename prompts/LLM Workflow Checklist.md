# LLM Workflow Checklist: Independent Product Development Process

> **NEW: Multi-Agent Architecture Available**
>
> This toolkit now supports a **multi-agent architecture** for modern AI CLI tools (Kiro-cli, Claude Code). The multi-agent approach provides:
> - **Protected context windows** - Each agent receives only what it needs
> - **Web-enabled market research** - Dedicated agent for competitive analysis
> - **Better quality** - Specialized agents focus on their domain
> - **Resumable workflows** - Session state enables pause/resume
>
> **To use multi-agent mode:** Load `prompts/Orchestrator.md` instead of this file.
>
> **This file (Legacy Mode)** remains available for single-agent tools or simpler workflows. It works the same as before but doesn't include web-based market research.
>
> See `README.md` for full architecture documentation.

---

## Legacy Mode Documentation

This checklist provides step-by-step instructions for the independent product development workflow. The LLM works independently to create each document, with **optional** user approval between phases for maximum flexibility.

## Initial Discovery and Workflow Routing

### Step 1: Understand Business Goals and Product Purpose
**Ask the user to describe:**
- What problem are you trying to solve?
- Who is your target audience/customer?
- What are your main business goals for this product?
- What key features or capabilities do you envision?
- How do you expect users to interact with this product?

### Step 2: Determine Product Type and Workflow
**After understanding the business goals, analyze if this involves AI/ML:**

**AI/ML Indicators:** ML models, AI capabilities, data prediction, NLP, computer vision, recommendations, automated decisions, pattern recognition, or generative AI features.

**If AI/ML indicators are evident from the description:**
- Proceed with Phase 0 (AI Framing) using `templates/ai_framing_template.md`

**If AI/ML indicators are unclear:**
- Ask follow-up questions: "Based on your description, I want to clarify - will this product involve any machine learning, AI capabilities, data prediction, or automated decision-making features?"

**Workflow Routing:**
- **AI/ML Product:** Start with Phase 0 (AI Framing), then Phases 1-3
- **Standard Product:** Skip Phase 0, proceed directly to Phase 1 (PRFAQ Creation)

## Workflow Execution Modes

### Mode 1: Full Approval Mode (Default)
- LLM requests explicit approval after each phase
- User must approve before proceeding to next phase
- Allows for feedback and revisions at each stage
- Recommended for first-time users or complex projects

### Mode 2: Streamlined Mode (Optional)
- LLM works through all phases independently
- User can interrupt at any time to provide feedback
- All documents generated in sequence without approval gates
- Final review and approval only at project completion
- Recommended for experienced users or straightforward projects

### Mode Selection
At the beginning of the workflow, ask the user:
**"Would you like me to work through all phases independently (streamlined mode) or request approval after each phase (full approval mode)? You can always interrupt the streamlined mode to provide feedback or make changes."**

**For AI/ML Products:** Also ask about AI Framing phase completion preference. Should we ask the user all questions, or fill in our suggestions to move faster?

## Document Management System

### Automatic Saving Protocol
- **Location:** All documents saved to `./documents/` (relative to current working directory)
- **Naming Convention:** `[DocumentType]_[ProductName]_[YYYY-MM-DD].[ext]`
- **Document Types:** PRFAQ, PRD, Prototype
- **File Formats:** Both markdown (.md) and HTML (.html) versions created
- **Product Name:** Replace spaces with underscores, use title case
- **Date Format:** Current date in YYYY-MM-DD format
- **CRITICAL:** Always verify file creation success before proceeding to next step

### File Organization
```
documents/
├── ProjectDashboard_[ProductName]_[Date].html   ← Central navigation hub
├── DesignSystem_[ProductName]_[Date].html
├── AIFraming_[ProductName]_[Date].md            ← AI/ML products only
├── AIFraming_[ProductName]_[Date].html          ← AI/ML products only
├── PRFAQ_[ProductName]_[Date].md
├── PRFAQ_[ProductName]_[Date].html
├── PRD_[ProductName]_[Date].md
├── PRD_[ProductName]_[Date].html
├── Prototype_[ProductName]_[Date].md
├── Prototype_[ProductName]_[Date].html
├── Screen_[ScreenName]_[ProductName]_[Date].html
└── ClickablePrototype_[ProductName]_[Date].html
```

### Design System Requirements
- **Creation:** Design system file created during Phase 1 and referenced throughout
- **Consistency:** All HTML documents must use the design system styling
- **Components:** Includes color palette, typography, buttons, forms, layouts, and interactive elements
- **Branding:** Incorporates any brand guidelines provided in context
- **Responsive:** Defines breakpoints and responsive behavior standards
- **Accessibility:** Includes WCAG compliance guidelines and color contrast requirements

### Central Dashboard System
- **Project Dashboard:** `ProjectDashboard_[ProductName]_[Date].html` serves as central navigation
- **MANDATORY Updates:** Dashboard MUST be updated after each phase completion
- **Progress Tracking:** Visual progress bar with accurate completion percentage
- **Status Consistency:** All phase sections must show correct completion status
- **Link Verification:** All document links must work and point to correct files
- **Auto-Open:** Dashboard and new documents automatically opened in browser

### Version Control & Quality Assurance
- Each document includes creation date in filename
- Previous versions preserved if regenerated on different dates
- **File Verification:** LLM must confirm successful save and provide file path to user
- **Dashboard Sync:** Update progress bar, phase labels, AND section content after each phase
- **Link Testing:** Verify all links work before presenting to user
- **Note:** LLM should automatically create the documents folder if it doesn't exist (cross-platform compatible)

### Phase Transition Checklist
Before advancing to next phase, verify:
- [ ] All files saved with correct naming convention
- [ ] Dashboard updated with new phase status and working links
- [ ] Previous phase section shows "Completed" status (not "Pending")
- [ ] Progress bar reflects accurate completion percentage
- [ ] User has provided explicit approval to proceed

---

## Phase 0: AI Framing (AI/ML Products Only)

### Step 0.1: Complete AI Framing Analysis
**Template:** `templates/ai_framing_template.md`
**LLM Instructions:**
1. Ask user for AI/ML product concept (capabilities, data sources, business metrics)
2. Work through template sections: Business Goals, ML Problem Framing, Data Strategy, Performance Metrics, Feasibility Assessment
3. Define success criteria and technical-business outcome mapping

### Step 0.2: Save and Request Approval - FLEXIBLE
**LLM Instructions:**
1. Save files: `AIFraming_[ProductName]_[YYYY-MM-DD].md/.html`, `DesignSystem_[ProductName]_[YYYY-MM-DD].html`, `ProjectDashboard_[ProductName]_[YYYY-MM-DD].html`
2. Dashboard: 25% completion, Phase 0 "Completed"
3. **Full Approval Mode:** Request approval to proceed to PRFAQ
4. **Streamlined Mode:** Continue to Phase 1 automatically

---

## Phase 1: PRFAQ Creation

### Step 1: Initialize PRFAQ Process
**Prompt to Use:** `PRFAQ Guide.md`
**Input Required:** Product idea or concept (+ AI Framing document if AI/ML product)
**LLM Instructions:**
1. Load the PRFAQ Guide prompt
2. **For AI/ML Products:** Reference completed AI Framing document for technical foundation
3. Begin with the introduction about creating a PRFAQ
4. Ask user for product idea description including:
   - Main features (incorporating AI/ML capabilities if applicable)
   - Target audience  
   - Unique selling points
   - **For AI/ML Products:** How the ML capabilities deliver business value

### Step 2: Working Backwards Questions
**Input Required:** User's product idea response from Step 1 (+ AI Framing insights if AI/ML product)
**LLM Instructions:**
1. Draft potential answers to the 5 Working Backwards questions:
   - Who is the customer and what insights do we have about them?
   - What is the prevailing customer problem/opportunity? What data informed this?
   - What is the solution? Why is it the right solution versus alternatives?
   - How would we describe the end-to-end customer experience? What is the most important customer benefit?
   - How will we define and measure success?
2. **For AI/ML Products:** Ensure answers incorporate ML problem framing and success metrics from Phase 0
3. Present drafted answers to user for validation/modification

### Step 3: Generate Complete PRFAQ Document
**Input Required:** Validated Working Backwards answers from Step 2
**LLM Instructions:**
1. Create complete PRFAQ using the specified markdown structure
2. Include Press Release section with all required elements
3. Include FAQ section with 5-7 unanswered questions
4. **For AI/ML Products:** Include AI-specific FAQ questions about accuracy, data privacy, model performance
5. **Create both markdown and HTML versions with professional styling**
6. **Incorporate any provided context data** (CSV files, company information, real metrics)

### Step 4: Save and Request PRFAQ Approval - FLEXIBLE
**Output Generated:** Complete PRFAQ document in both formats + Updated Dashboard
**LLM Instructions:**
1. **MANDATORY: Automatically save all files to the documents folder**
   - Save markdown: `PRFAQ_[ProductName]_[YYYY-MM-DD].md`
   - Save HTML: `PRFAQ_[ProductName]_[YYYY-MM-DD].html` (using design system styling)
   - **Update Project Dashboard** with PRFAQ completion status and working links
   - Replace spaces in product name with underscores
   - Use current date in YYYY-MM-DD format
   - Save to: `./documents/`
   - **VERIFY:** Confirm all files saved successfully
2. **Automatically open HTML files in browser:**
   - Open PRFAQ HTML document for review
   - Open updated Project Dashboard for navigation
3. **Dashboard Updates:** Ensure dashboard shows:
   - **AI/ML Products:** Progress bar at 50% completion (Phase 0 and 1 complete)
   - **Standard Products:** Progress bar at 33.33% completion (Phase 1 complete)
   - Phase 1 marked as "Completed" with working links
   - Design System link accessible from navigation
   - Remaining phases marked as "Pending"
4. **Approval Logic:**
   - **Full Approval Mode:** "I've created and opened the PRFAQ document and updated Project Dashboard in your browser for review. [For AI/ML products: The PRFAQ incorporates the ML problem framing from Phase 0.] Do you approve this version to move forward to the PRD creation phase? If not, what changes would you like me to make?"
   - **Streamlined Mode:** "I've completed the PRFAQ [For AI/ML products: incorporating the AI framing foundation] and opened it in your browser. Moving on to create the PRD based on this foundation. You can interrupt at any time to provide feedback."
5. **Wait for approval ONLY in Full Approval Mode before proceeding to Phase 2**

---

## Phase 2: PRD Creation

### Step 5: Initialize PRD Process
**Prompt to Use:** `PRD Creation Guide.md`
**Input Required:** Approved PRFAQ document from Phase 1 (+ AI Framing document if AI/ML product)
**LLM Instructions:**
1. Load the PRD Creation Guide prompt
2. Reference the approved PRFAQ document from Phase 1
3. **For AI/ML Products:** Also reference AI Framing document for technical requirements
4. If user doesn't have approved PRFAQ, direct them to complete Phase 1 first

### Step 6: Independent PRD Creation 
**Input Required:** Approved PRFAQ document (+ AI Framing if AI/ML product)
**LLM Instructions:**
1. **Work INDEPENDENTLY** to create comprehensive PRD based on PRFAQ
2. **CRITICAL:** Only ask clarifying questions if absolutely essential information is missing
3. The approved PRFAQ should contain 90% of what you need. Focus on:
   - Expanding PRFAQ insights into detailed requirements
   - Creating realistic personas from PRFAQ customer insights (use real names if provided in context)
   - Building technical specifications from PRFAQ solution description
   - Developing success metrics from PRFAQ working backwards answers
   - **For AI/ML Products:** Incorporating ML requirements, data needs, and performance metrics from AI Framing
4. Use PRFAQ as foundation for all sections:
   - Background and Problem/Opportunity
   - Product/Solution
   - Target Audience/Personas (based on real team members if provided)
   - Product Requirements
   - **For AI/ML Products:** ML Requirements section with model performance, data requirements, and evaluation metrics
   - MVP Timeline and Milestones
   - Key Product Indicators of Success
   - Business Model and Pricing
   - Resourcing
   - Stakeholders
   - **Clickable Prototype & MLP Testing Plan** (MANDATORY section)
   - Outstanding Questions
   - Appendices
5. **Context Integration:** Incorporate any provided data (CSV files, team information, real metrics)
6. **Create both markdown and HTML versions with professional styling**

### Step 7: Save and Request PRD Approval - FLEXIBLE
**Output Generated:** Complete PRD document in both formats + Updated Dashboard
**LLM Instructions:**
1. **MANDATORY: Automatically save both versions to the documents folder**
   - Save markdown: `PRD_[ProductName]_[YYYY-MM-DD].md`
   - Save HTML: `PRD_[ProductName]_[YYYY-MM-DD].html` (using established design system styling)
   - **Update Project Dashboard** with PRD completion status and working links (maintain design system consistency)
   - Replace spaces in product name with underscores
   - Use current date in YYYY-MM-DD format
   - Save to: `./documents/`
   - **VERIFY:** Confirm all files saved successfully
2. **Design System Consistency:** Ensure PRD HTML uses:
   - Same color palette and typography as established in Phase 0/1
   - Consistent button styles, form elements, and interactive components
   - Matching layout grid and spacing system
   - Identical navigation and branding elements
3. **Dashboard Updates:** Ensure dashboard shows:
   - **AI/ML Products:** Progress bar at 75% completion (Phases 0, 1, and 2 complete)
   - **Standard Products:** Progress bar at 66.67% completion (Phases 1 and 2 complete)
   - Phase 2 marked as "Completed" with working links to both MD and HTML
   - Design System link accessible from navigation
   - Final phase marked as "Pending"
4. **Automatically open HTML files in browser:**
   - Open PRD HTML document for review
   - Open updated Project Dashboard
5. **Approval Logic:**
   - **Full Approval Mode:** "I've opened the complete PRD document and updated Project Dashboard in your browser for review. [For AI/ML products: The PRD incorporates both the PRFAQ foundation and the ML requirements from the AI Framing phase.] Do you approve this version to move forward to the prototype creation phase? If not, what changes would you like me to make?"
   - **Streamlined Mode:** "I've completed the comprehensive PRD [For AI/ML products: incorporating both PRFAQ and AI framing requirements] and opened it in your browser. Moving on to create the prototype specification based on these requirements. You can interrupt at any time to provide feedback."
6. **Wait for approval ONLY in Full Approval Mode before proceeding to Phase 3**

---

## Phase 3: Prototype Creation

### Step 8: Initialize Prototype Process
**Prompt to Use:** `Prototype Creation Guide.md`
**Input Required:** Approved PRD document from Phase 2
**LLM Instructions:**
1. Load the Prototype Creation Guide prompt
2. Reference the approved PRD document from Phase 2
3. If user doesn't have approved PRD, direct them to complete Phase 2 first

### Step 9: Independent Prototype Creation 
**Input Required:** Approved PRD document
**LLM Instructions:**
1. **Work independently** to create comprehensive prototype specification based on PRD
2. Create all required components:
   - User Flow Mapping (derived from PRD)
   - Information Architecture (based on PRD features)
   - **ALL screens identified in PRD** (see Screen Coverage Requirements below)
   - Interactive Elements & Functionality
   - Visual Design System
3. **Screen Coverage Requirements - MANDATORY:**
   - **Primary Screens:** Main dashboard/landing, customer/account details, core workflow screens
   - **Secondary Screens:** Settings, configuration, authentication, onboarding
   - **Supporting Screens:** Error states, loading states, empty states, confirmation screens
   - **Mobile Screens:** Responsive versions and mobile-specific navigation
   - **Modal/Overlay Screens:** Dialogs, pop-ups, and overlay interactions
4. **Create individual HTML files for each screen:**
   - Save as: `Screen_[ScreenName]_[ProductName]_[YYYY-MM-DD].html`
   - Include wireframes, specifications, and interactive demonstrations
   - Add realistic data relevant to the product context
   - Include design annotations and interaction specifications
5. **Context Integration:** Use real data, customer names, and metrics from provided context
6. Only ask clarifying questions if critical design information is missing from PRD

### Step 10: Create Complete Clickable Prototype 
**Input Required:** All individual screen specifications
**LLM Instructions:**
1. **Create comprehensive clickable prototype** combining ALL screens into single interactive experience
2. **CRITICAL: Include every screen identified during the process:**
   - All main workflow screens
   - Settings and configuration screens
   - Authentication screens
   - Modal dialogs and overlays
   - Error states and confirmation screens
   - Loading states and empty states
   - Mobile navigation screens
   - All secondary workflows from PRD
3. **Technical implementation requirements:**
   - Single HTML file with embedded CSS and JavaScript for all screens
   - Screen management system for navigation between all screens
   - Local storage for session persistence
   - Mock API responses for realistic interactions
   - Analytics tracking for user testing
   - Responsive design that works on desktop, tablet, and mobile
   - Working form interactions with validation
   - Realistic data that updates based on user actions
4. **Quality Standards:**
   - All workflows can be completed end-to-end
   - Navigation works between all screens with proper state management
   - Interactive elements provide appropriate feedback
   - Data consistency across all screens
   - Performance optimization for smooth interactions
5. **Save as:** `ClickablePrototype_[ProductName]_[YYYY-MM-DD].html`

### Step 11: Save and Request Prototype Approval - FLEXIBLE
**Output Generated:** Complete prototype specification + Individual HTML screens + Interactive clickable prototype + Final Dashboard
**LLM Instructions:**
1. **MANDATORY: Automatically save all prototype files to the documents folder**
   - Save main specification: `Prototype_[ProductName]_[YYYY-MM-DD].md` and `.html` (using design system styling)
   - Save individual screen files: `Screen_[ScreenName]_[ProductName]_[YYYY-MM-DD].html` (all using consistent design system)
   - **Reference existing design system:** `DesignSystem_[ProductName]_[YYYY-MM-DD].html` (do not recreate)
   - **Save clickable prototype: `ClickablePrototype_[ProductName]_[YYYY-MM-DD].html`** (implementing full design system)
   - **Update Project Dashboard** with all prototype completion status and links (maintain design consistency)
   - Replace spaces in product name with underscores
   - Use current date in YYYY-MM-DD format
   - Save all to: `./documents/`
   - **VERIFY:** Confirm all files saved successfully
2. **Design System Implementation:** Ensure ALL prototype files use:
   - Consistent color palette, typography, and component styling from established design system
   - Same interactive element behaviors (buttons, forms, navigation)
   - Matching layout grid, spacing, and responsive breakpoints
   - Identical branding elements and visual hierarchy
   - Cohesive user experience across all screens and interactions
3. **Dashboard Updates:** Ensure dashboard shows:
   - **AI/ML Products:** Progress bar at 100% completion (all 4 phases complete)
   - **Standard Products:** Progress bar at 100% completion (all 3 phases complete)
   - All phases marked as "Completed" with working links
   - Design System link prominently displayed and accessible
   - Prototype section shows "Completed" status with links to clickable prototype and individual screens
   - Footer reflects project completion status
4. **Automatically open HTML files in browser:**
   - Open Design System for reference
   - Open clickable prototype for testing
   - Open final Project Dashboard with all links
5. **Final Approval Logic:**
   - **Full Approval Mode:** "I've opened the design system, clickable prototype, and final Project Dashboard in your browser. All deliverables maintain consistent styling through the established design system. [For AI/ML products: The prototype incorporates the ML requirements and success metrics defined in the AI Framing phase.] The dashboard provides access to all project documents. Do you approve this version for customer validation and user testing? If not, what changes would you like me to make?"
   - **Streamlined Mode:** "I've completed all phases of the product development workflow! The clickable prototype and comprehensive documentation maintain consistent design system styling throughout. [For AI/ML products: All deliverables are aligned with the ML problem framing and technical requirements.] The Project Dashboard provides access to all deliverables. The complete workflow is ready for customer validation and user testing."
6. **Wait for approval ONLY in Full Approval Mode before considering project complete**

---

## Quality Assurance Checklist 

### Dashboard Consistency Checks 
After each phase completion, verify:
- [ ] Progress bar shows correct percentage (AI/ML: 25%, 50%, 75%, 100%; Standard: 33%, 67%, 100%)
- [ ] Phase labels show completed status with checkmarks (✓)
- [ ] Document links work and point to correct files
- [ ] Status badges show "Completed" not "Pending" for finished phases
- [ ] Footer reflects current completion state
- [ ] JavaScript animations work properly (progress bar fills correctly)
- [ ] All sections have working "View" buttons, not "Coming Soon"
- [ ] **Design System link is accessible and working**
- [ ] **All HTML documents use consistent design system styling**
- [ ] **For AI/ML Products:** AI Framing phase properly displayed and linked

### Design System Consistency Checks
After each phase completion, verify:
- [ ] **Color Palette:** All documents use the same primary, secondary, and accent colors
- [ ] **Typography:** Consistent font families, sizes, and hierarchy across all documents
- [ ] **Component Styling:** Buttons, forms, cards, and interactive elements match design system
- [ ] **Layout System:** Same grid, spacing, and responsive breakpoints used throughout
- [ ] **Branding:** Consistent logos, brand colors, and visual identity elements
- [ ] **Accessibility:** WCAG-compliant color contrasts and interaction patterns maintained
- [ ] **Navigation:** Consistent navigation patterns and user interface elements

### Before Each Phase Transition - FLEXIBLE:
**Full Approval Mode:**
- [ ] Previous phase output is complete and approved by user
- [ ] User has provided explicit approval to proceed to next phase
- [ ] Address any feedback before proceeding

**Streamlined Mode:**
- [ ] Previous phase output is complete and saved successfully
- [ ] User has been notified of completion and can interrupt if needed
- [ ] Continue to next phase automatically

**Both Modes:**
- [ ] Both markdown and HTML versions created and saved successfully
- [ ] All files saved successfully to documents folder
- [ ] Dashboard updated with accurate phase completion status
- [ ] **For AI/ML Products:** AI Framing document properly referenced in subsequent phases

### For Each Document:
- [ ] Professional HTML styling using established design system
- [ ] Consistent typography, colors, and component styling across all documents
- [ ] All required sections/components included
- [ ] Content builds logically on previous phase documents
- [ ] File naming convention followed correctly
- [ ] Realistic data incorporated from provided context (CSV files, company info)
- [ ] **Design system consistency maintained throughout**
- [ ] **Responsive design works across desktop, tablet, and mobile**
- [ ] **Accessibility standards met (WCAG compliance)**

### For Prototype Phase Specifically:
- [ ] **Every screen identified in PRD is included in clickable prototype**
- [ ] **All primary and secondary workflows can be completed end-to-end**
- [ ] **Mobile responsive behavior works on all screens**
- [ ] **Form validation and interactions work on every form**
- [ ] **Navigation works between all screens with proper state management**
- [ ] **Data simulation is consistent across all screens**
- [ ] **Error states and edge cases are handled on relevant screens**

### Cross-Phase Consistency Checks:
- [ ] Target audience/personas consistent across PRFAQ → PRD → Prototype
- [ ] Problem statement and solution approach aligned throughout
- [ ] Success metrics and business model coherent across documents
- [ ] Technical requirements and constraints properly carried forward
- [ ] Real data and context properly integrated throughout all phases

## End-to-End Validation Checklist - FLEXIBLE

### Phase 0 Completion Verification (AI/ML Products Only)
- [ ] AI Framing markdown and HTML files created and accessible
- [ ] Dashboard shows Phase 0 complete with working links to both files
- [ ] Progress bar shows 25% completion
- [ ] Files incorporate business goals, ML problem definition, data strategy, and feasibility assessment
- [ ] Performance metrics selected and thresholds defined
- [ ] Technical-business outcome mapping completed
- [ ] **Full Approval Mode:** User provided explicit approval to proceed
- [ ] **Streamlined Mode:** User notified of completion and can provide feedback

### Phase 1 Completion Verification
- [ ] PRFAQ markdown and HTML files created and accessible
- [ ] Dashboard shows Phase 1 complete with working links to both files
- [ ] **AI/ML Products:** Progress bar shows 50% completion, **Standard Products:** Progress bar shows 33% completion
- [ ] Files incorporate any provided context data appropriately
- [ ] **AI/ML Products:** PRFAQ incorporates ML capabilities and success metrics from AI Framing
- [ ] **Full Approval Mode:** User provided explicit approval to proceed
- [ ] **Streamlined Mode:** User notified of completion and can provide feedback

### Phase 2 Completion Verification  
- [ ] PRD markdown and HTML files created and accessible
- [ ] Dashboard updated to show Phase 2 complete with working links
- [ ] Previous phases still show "Completed" status with working links
- [ ] **AI/ML Products:** Progress bar shows 75% completion, **Standard Products:** Progress bar shows 67% completion
- [ ] PRD includes mandatory Clickable Prototype & MLP Testing Plan section
- [ ] **AI/ML Products:** PRD includes ML Requirements section with performance metrics and data requirements
- [ ] **Full Approval Mode:** User provided explicit approval to proceed
- [ ] **Streamlined Mode:** User notified of completion and can provide feedback

### Phase 3 Completion Verification
- [ ] All individual screen HTML files created (minimum 5-8 screens)
- [ ] Clickable prototype demonstrates full functionality with all screens
- [ ] Dashboard shows 100% completion with working progress bar
- [ ] All phases marked as completed with working links
- [ ] Footer reflects project completion status
- [ ] Prototype incorporates realistic data from provided context
- [ ] **AI/ML Products:** Prototype demonstrates ML capabilities and success metrics defined in AI Framing
- [ ] **Full Approval Mode:** User provided explicit approval for customer validation
- [ ] **Streamlined Mode:** User notified of project completion and deliverables ready

### Final Validation - BOTH MODES
- [ ] All required document types (AI Framing if applicable, PRFAQ, PRD, Prototype) are complete
- [ ] Documents reference each other appropriately and maintain consistency
- [ ] **AI/ML Products:** Technical requirements flow consistently from AI Framing → PRFAQ → PRD → Prototype
- [ ] Clickable prototype is ready for customer validation and user testing
- [ ] Dashboard serves as effective central navigation for all deliverables
- [ ] User has opportunity to review and provide feedback on final deliverables

## Context Integration Guidelines - NEW

### Using Provided Context Effectively
When users provide additional context (CSV files, company documents, team information):

**Data Integration Requirements:**
- CSV files with real data → Incorporate actual values, names, and metrics into all documents
- Company/project context → Use specific terminology and realistic scenarios throughout
- Team member information → Create personas based on real people mentioned in context
- Existing documentation → Reference and build upon provided information consistently

**Realistic Development Standards:**
- Use actual customer names and opportunity values from provided data
- Create personas based on real team members mentioned in context (names, roles, responsibilities)
- Incorporate specific industry terminology and use cases
- Reflect actual business complexity and scale in all examples
- Ensure metrics and data align with real business scale provided
- Make user scenarios reflect actual workflows and challenges described

**Quality Standards:**
- All examples should feel authentic to the provided context
- Technical specifications should match stated requirements and constraints
- Business model should reflect actual investment levels and revenue potential
- Success metrics should align with real organizational goals and capabilities

### File Management Best Practices
**Error Prevention:**
- Always use absolute paths when saving files
- Verify file creation success before proceeding to next step
- Test all links in HTML documents before completion
- Update central dashboard immediately after each phase
- Confirm user can access all generated files before requesting approval

**Link Verification:**
- Test every link in the dashboard before presenting to user
- Ensure file paths are correct and accessible
- Verify HTML files open properly in browser
- Check that all "View" buttons work (no "Coming Soon" placeholders in completed phases)

**Dashboard Management:**
- Update progress bar percentage accurately (33%, 67%, 100%)
- Change status badges from "Pending" to "Completed" 
- Add working links to both markdown and HTML versions
- Update footer to reflect current project status
- Fix JavaScript animations to show correct completion level

### User Interruption Handling - STREAMLINED MODE

**If User Interrupts During Streamlined Mode:**
1. **Pause immediately** at current step
2. **Present current progress:** Show what has been completed and what's in progress
3. **Request feedback:** "You've interrupted the streamlined workflow. What would you like to review or change?"
4. **Offer options:**
   - Review and approve current phase before continuing
   - Make specific changes to current or previous phases
   - Switch to Full Approval Mode for remaining phases
   - Continue in Streamlined Mode after addressing feedback
5. **Update dashboard** to reflect any changes made
6. **Resume workflow** according to user preference

**Switching Between Modes:**
- Users can switch from Streamlined to Full Approval Mode at any time
- Users can switch from Full Approval to Streamlined Mode at any time
- Always confirm mode change with user before proceeding

## Troubleshooting Common Issues 

### Dashboard Update Issues
**Problem:** Dashboard not showing correct completion status or progress
**Solution:** 
- Verify progress bar JavaScript shows correct percentage
- Check that status badges say "Completed" not "Pending"
- Ensure all links point to correct file names and paths
- Update footer to reflect current completion state
- Test all "View" buttons work (remove "Coming Soon" placeholders)

### File Saving Issues
**Problem:** Files not saving or links not working
**Solution:**
- Use absolute file paths when saving
- Verify documents folder exists and is writable
- Confirm file naming convention is followed exactly
- Test file accessibility before presenting to user
- Check that both .md and .html versions are created

### Context Integration Issues
**Problem:** Generated content feels generic despite provided context
**Solution:**
- Review all provided context files (CSV, documents, etc.) thoroughly
- Use actual names, metrics, and scenarios from provided data
- Create realistic personas based on real team members mentioned
- Incorporate specific industry terminology and use cases
- Ensure business scale matches provided information

### If User Doesn't Provide Explicit Approval:
- Do not proceed to next phase without clear sign-off
- Ask specific questions about concerns or needed changes
- Offer to revise current phase documents before moving forward
- Ensure user understands what each deliverable demonstrates

### If User Wants to Skip Phases:
- Explain the value of each phase in building upon previous work
- Emphasize that each phase provides foundation for the next
- Require at minimum the working backwards questions and basic requirements

### If User Requests Major Changes Mid-Process:
- Assess impact on previous phases and subsequent work
- Offer to update previous documents for consistency
- Get approval on revised documents before proceeding
- Update dashboard to reflect any changes in completion status

### If Technical Constraints Emerge:
- Update relevant documents (PRD requirements, prototype specifications)
- Ensure constraints are documented clearly for development team
- Get user approval on constraint-adjusted designs
- Maintain consistency across all phases with new constraints
