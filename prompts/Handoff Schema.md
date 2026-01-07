# Inter-Agent Handoff Schema

This document defines the structured data contracts for communication between specialized agents in the product development workflow. Each agent receives a condensed handoff payload and produces a structured output for the next phase.

## Design Principles

1. **Minimal Context Transfer**: Only essential information passes between agents
2. **Structured Data**: JSON schemas enable reliable parsing
3. **Artifact References**: Full documents stored as files, handoffs contain summaries + paths
4. **Idempotency**: Any agent can be re-run with the same handoff input
5. **Traceability**: Each handoff includes metadata for debugging

---

## Master Handoff Envelope

All inter-agent communications use this envelope structure:

```json
{
  "handoff_version": "1.0",
  "timestamp": "ISO-8601 datetime",
  "session_id": "uuid",
  "product_name": "string",
  "product_name_slug": "string (underscores, no spaces)",

  "source_agent": {
    "agent_type": "orchestrator | market-research | prfaq | prd | prototype | ai-framing",
    "phase_completed": "string",
    "execution_time_ms": "number"
  },

  "target_agent": {
    "agent_type": "string",
    "phase_to_execute": "string"
  },

  "artifacts": {
    "created": [
      {
        "type": "markdown | html | json",
        "path": "relative path from project root",
        "description": "string"
      }
    ],
    "referenced": ["paths to prior artifacts this agent may need"]
  },

  "payload": {
    // Agent-specific structured data (see below)
  },

  "workflow_state": {
    "is_ai_ml_product": "boolean",
    "execution_mode": "full-approval | streamlined",
    "phases_completed": ["string"],
    "phases_remaining": ["string"],
    "progress_percentage": "number"
  }
}
```

---

## Phase-Specific Payloads

### 1. User → Orchestrator (Initial Input)

```json
{
  "payload": {
    "product_concept": {
      "name": "string",
      "problem_statement": "string (1-3 sentences)",
      "proposed_solution": "string (1-3 sentences)",
      "target_audience": "string",
      "key_features": ["string"],
      "unique_value_proposition": "string"
    },
    "customer_company": {
      "name": "string | null (company this is being built for, if any)",
      "website": "string | null (company website URL for brand research)",
      "industry": "string | null"
    },
    "context_files": ["paths to any CSV, company docs, etc."],
    "preferences": {
      "execution_mode": "full-approval | streamlined",
      "research_depth": "quick | standard | comprehensive",
      "brand_guidelines": "string (optional)"
    }
  }
}
```

### 2. Orchestrator → Market Research Agent

```json
{
  "payload": {
    "research_request": {
      "product_name": "string",
      "problem_statement": "string",
      "proposed_solution": "string",
      "target_audience": "string",
      "industry_vertical": "string",
      "geographic_focus": "string | null",
      "research_depth": "quick | standard | comprehensive"
    },
    "specific_questions": [
      "string (optional specific research questions)"
    ]
  }
}
```

### 3. Market Research Agent → Orchestrator (for routing to PRFAQ)

```json
{
  "payload": {
    "market_research_summary": {
      "market_opportunity": "string (2-3 sentences)",
      "tam": "string (e.g., $50B)",
      "growth_rate": "string (e.g., 12% CAGR)",
      "competitive_position": "string (2-3 sentences)",
      "top_competitors": [
        {
          "name": "string",
          "positioning": "string",
          "pricing_range": "string"
        }
      ],
      "key_customer_pain_points": [
        {
          "pain_point": "string",
          "severity": "critical | high | medium"
        }
      ],
      "differentiation_opportunities": ["string"],
      "recommended_pricing_position": "premium | mid-market | value | freemium",
      "key_risks": ["string"]
    },
    "full_research_path": "documents/MarketResearch_[Product]_[Date].json"
  }
}
```

### 4. Orchestrator → AI Framing Agent (AI/ML Products Only)

```json
{
  "payload": {
    "business_context": {
      "product_name": "string",
      "problem_statement": "string",
      "proposed_ml_capabilities": ["string"],
      "target_business_metrics": ["string"],
      "data_sources_available": ["string"],
      "technical_constraints": ["string"]
    },
    "market_context": {
      "competitor_ml_approaches": ["string"],
      "industry_ml_maturity": "emerging | growing | mature"
    }
  }
}
```

### 5. AI Framing Agent → Orchestrator

```json
{
  "payload": {
    "ai_framing_summary": {
      "ml_problem_statement": "string",
      "input_output_definition": {
        "inputs": ["string"],
        "outputs": ["string"]
      },
      "selected_metrics": [
        {
          "metric": "string",
          "threshold": "string",
          "business_mapping": "string"
        }
      ],
      "data_strategy": "string (2-3 sentences)",
      "feasibility_assessment": "high | medium | low",
      "key_technical_risks": ["string"]
    },
    "full_framing_path": "documents/AIFraming_[Product]_[Date].md"
  }
}
```

### 6. Orchestrator → PRFAQ Agent

```json
{
  "payload": {
    "product_context": {
      "name": "string",
      "problem_statement": "string",
      "proposed_solution": "string",
      "target_audience": "string",
      "key_features": ["string"],
      "unique_value_proposition": "string"
    },
    "market_context": {
      "market_opportunity": "string",
      "competitive_gaps": ["string"],
      "customer_pain_points": ["string"],
      "differentiation_strategy": "string"
    },
    "ai_context": {
      "is_ai_ml_product": "boolean",
      "ml_capabilities_summary": "string | null",
      "ml_success_metrics": ["string"]
    }
  }
}
```

### 7. PRFAQ Agent → Orchestrator

```json
{
  "payload": {
    "prfaq_summary": {
      "headline": "string",
      "customer_definition": "string (2-3 sentences)",
      "problem_statement": "string (2-3 sentences)",
      "solution_description": "string (2-3 sentences)",
      "key_customer_benefit": "string",
      "success_metrics": ["string"],
      "launch_approach": "string",
      "top_faq_themes": ["string"]
    },
    "working_backwards_answers": {
      "who_is_customer": "string",
      "what_is_problem": "string",
      "what_is_solution": "string",
      "customer_experience": "string",
      "success_definition": "string"
    },
    "full_prfaq_path": "documents/PRFAQ_[Product]_[Date].md"
  }
}
```

### 8. Orchestrator → PRD Agent

```json
{
  "payload": {
    "prfaq_context": {
      "customer_definition": "string",
      "problem_statement": "string",
      "solution_description": "string",
      "key_benefits": ["string"],
      "success_metrics": ["string"]
    },
    "market_context": {
      "competitors": [{"name": "string", "positioning": "string"}],
      "pricing_guidance": "string",
      "market_size": "string"
    },
    "ai_context": {
      "is_ai_ml_product": "boolean",
      "ml_requirements_summary": "string | null",
      "ml_metrics": ["string"]
    },
    "user_provided_context": {
      "team_members": [{"name": "string", "role": "string"}],
      "company_info": "string",
      "technical_constraints": ["string"]
    }
  }
}
```

### 9. PRD Agent → Orchestrator

```json
{
  "payload": {
    "prd_summary": {
      "product_overview": "string (2-3 sentences)",
      "personas": [
        {
          "name": "string",
          "role": "string",
          "primary_need": "string"
        }
      ],
      "core_requirements": [
        {
          "requirement": "string",
          "priority": "P0 | P1 | P2",
          "persona": "string"
        }
      ],
      "mvp_scope": ["string"],
      "success_kpis": [
        {
          "metric": "string",
          "target": "string"
        }
      ],
      "business_model": {
        "pricing_tiers": ["string"],
        "revenue_model": "string"
      },
      "screens_identified": ["string"]
    },
    "full_prd_path": "documents/PRD_[Product]_[Date].md"
  }
}
```

### 10. Orchestrator → Prototype Agent

```json
{
  "payload": {
    "prd_context": {
      "product_name": "string",
      "product_overview": "string",
      "personas": [
        {
          "name": "string",
          "role": "string",
          "primary_workflow": "string"
        }
      ],
      "core_requirements": ["string"],
      "screens_to_build": ["string"],
      "user_flows": [
        {
          "flow_name": "string",
          "steps": ["string"]
        }
      ]
    },
    "design_context": {
      "brand_guidelines": "string | null",
      "existing_design_system_path": "string | null",
      "platform_targets": ["web", "mobile", "tablet"],
      "customer_company": {
        "name": "string | null (real company this is being built for)",
        "website": "string | null (company website URL)",
        "industry": "string | null"
      },
      "aesthetic_preferences": {
        "direction": "string | null",
        "mood": "string | null",
        "avoid": ["string | null"]
      }
    },
    "data_context": {
      "sample_data_files": ["paths"],
      "realistic_data_requirements": ["string"]
    }
  }
}
```

### 11. Prototype Agent → Orchestrator (Final)

```json
{
  "payload": {
    "prototype_summary": {
      "screens_created": [
        {
          "screen_name": "string",
          "path": "string",
          "primary_persona": "string"
        }
      ],
      "user_flows_implemented": ["string"],
      "interactive_features": ["string"],
      "design_system_path": "string",
      "clickable_prototype_path": "string"
    },
    "testing_readiness": {
      "ready_for_user_testing": "boolean",
      "test_scenarios": ["string"],
      "known_limitations": ["string"]
    }
  }
}
```

---

## File Storage Convention

All artifacts follow this naming:

```
documents/
├── handoffs/
│   ├── handoff_[session-id]_[source]_to_[target]_[timestamp].json
│   └── ...
├── MarketResearch_[ProductSlug]_[YYYY-MM-DD].json
├── AIFraming_[ProductSlug]_[YYYY-MM-DD].md
├── AIFraming_[ProductSlug]_[YYYY-MM-DD].html
├── PRFAQ_[ProductSlug]_[YYYY-MM-DD].md
├── PRFAQ_[ProductSlug]_[YYYY-MM-DD].html
├── PRD_[ProductSlug]_[YYYY-MM-DD].md
├── PRD_[ProductSlug]_[YYYY-MM-DD].html
├── DesignSystem_[ProductSlug]_[YYYY-MM-DD].html
├── Prototype_[ProductSlug]_[YYYY-MM-DD].md
├── Screen_[ScreenName]_[ProductSlug]_[YYYY-MM-DD].html
├── ClickablePrototype_[ProductSlug]_[YYYY-MM-DD].html
└── ProjectDashboard_[ProductSlug]_[YYYY-MM-DD].html
```

---

## Handoff Validation Rules

Before sending a handoff, the source agent MUST verify:

1. **Required Fields**: All non-nullable fields are populated
2. **Artifact Existence**: All referenced file paths exist
3. **Data Consistency**: Names, metrics, and key facts match across payload
4. **Size Limits**: Payload summary fields are under 500 characters each
5. **Valid Enums**: All enum values match allowed options

---

## Error Handoff

If an agent fails or cannot complete its phase:

```json
{
  "payload": {
    "error": {
      "code": "RESEARCH_FAILED | GENERATION_FAILED | VALIDATION_FAILED | USER_CANCELLED",
      "message": "string",
      "partial_output": { /* whatever was completed */ },
      "recovery_suggestions": ["string"]
    }
  }
}
```

The orchestrator can then:
1. Retry the failed agent
2. Request user intervention
3. Skip to next phase with degraded input
4. Abort workflow
