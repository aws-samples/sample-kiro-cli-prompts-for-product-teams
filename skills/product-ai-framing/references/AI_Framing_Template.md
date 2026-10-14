# ML Problem Framing

Application Name:  
Task Name: 

---
## Business Goal Identification
*Business goal identification is the most important phase of the ML lifecycle. An organization considering ML should have a clear idea of the problem to be solved, and the business value to be gained.*

- [ ] Understand business requirements
- [ ] Align affected stakeholders with this initiative
- [ ] Form a business question
- [ ] Identify critical, must-have features
- [ ] Consider new business processes that might come out of this implementation
- [ ] Consider how business value can be measured using business metrics

### Who are the stakeholders and how are they aligned?

### What specific business value will this ML solution deliver?
*The business problem to be solved and specific business metrics the solution will impact*

### What new business processes might emerge from this implementation?
*Business processes and workflows this solution fits into. The user experience while using the solution*

### What are the critical, must-have features and metrics for success?
*Features include AI capabilities that need to be validated in our solution and it's components.*

---
## ML Problem Framing
*In this phase, the business problem is framed as a machine learning problem: what is observed and what should be predicted.*

- [ ] Define criteria for a successful outcome of the project
- [ ] Establish an observable and quantifiable performance metric for the project, such as accuracy
- [ ] Define the relationship between the technical metric (for example, accuracy) and the business outcome (for example, sales)
- [ ] Help ensure business stakeholders understand and agree with the defined performance metrics
- [ ] Formulate the ML question in terms of inputs, desired outputs, and the performance metric to be optimized

### ML Approach Validation
- [ ] Evaluate options for achieving the business goal
- [ ] Determine accuracy requirements vs cost and scalability of each approach
- [ ] Assess if simple business rules could achieve the same outcome
- [ ] Validate sufficient relevant, high-quality training data is available
- [ ] Evaluate whether ML is the right approach

### ML Problem Definition
*The problem to be solved, stated in terms of inputs and outputs. Given X, output Y*

#### What is the ML Problem Statement?
*Description of the problem statement*

#### What is observed (inputs) and what should be predicted (outputs)?
*Detailed description of the inputs and outputs. Include an example if possible.*

### Performance Metrics and Success Criteria
*The quality requirements that will be used to evalute the solution and it's components.*

#### What are the features of a high quality output?
*Fast enough. Accurate enough. High recall for a given task. Raising the right citations. What are the factors that impact the fit for this use-case?*

#### What are the features of a low quality output?
*The most important ways an output might be poor quality. Evaluations will include these cases checking behavior.*

#### What are the baseline performance metrics to compare against?
*Metrics from existing processes. Target metrics based on best-effort guesses might be updated with qualitative feedback later.*

### Metric Selection Guide
*Select applicable metrics for your evaluation. Delete metrics that don't apply to your use case.*

#### **Quality & Accuracy Metrics**
- [ ] **Correctness** - Measures if the model's response is factually correct and accurate
- [ ] **Completeness** - Evaluates if the response addresses all parts of the input request
- [ ] **Accuracy** - Proportion of correct predictions made by the model (traditional ML metric)
- [ ] **Precision** - True positives / (True positives + False positives)
- [ ] **Recall** - True positives / (True positives + False negatives)
- [ ] **F1-Score** - Harmonic mean of precision and recall
- [ ] **BLEU** - Bilingual evaluation score for text similarity (default threshold 0.5)
- [ ] **ROUGE-N** - Recall-oriented evaluation for text summarization (default threshold 0.75)
- [ ] **METEOR** - Metric for evaluation of translation with explicit ordering (default threshold 0.5)
- [ ] **GLEU** - Google-BLEU score for text similarity (default threshold 0.5)

#### **Coherence & Logic Metrics**
- [ ] **Logical Coherence** - Checks for logical gaps, inconsistencies, and contradictions in responses
- [ ] **Following Instructions** - Evaluates whether the model respects exact directions in the prompt
- [ ] **Relevance** - Measures how focused the response is on the given question
- [ ] **Context Faithfulness** - Ensures response uses provided context without hallucination
- [ ] **Context Relevance** - Ensures context is relevant to the original query
- [ ] **Context Recall** - Ensures ground truth information appears in the provided context

#### **Style & Readability Metrics**
- [ ] **Professional Style and Tone** - Evaluates appropriate business/professional communication style
- [ ] **Readability** - Assesses terminological and linguistic complexity for target audience
- [ ] **Helpfulness** - Holistic evaluation of how useful the response is for the user's needs

#### **Safety & Bias Metrics**
- [ ] **Harmfulness** - Detects harmful content including violence, hate, inappropriate material
- [ ] **Stereotyping** - Identifies content based on stereotypes (positive or negative)
- [ ] **Refusal** - Detects when model appropriately refuses inappropriate requests
- [ ] **Guardrails** - Ensures output doesn't contain harmful content using safety filters

#### **Technical Performance Metrics**
- [ ] **Latency** - Response time below specified threshold (milliseconds)
- [ ] **Cost** - Computational cost below threshold (for models with cost info)
- [ ] **Perplexity** - Language model uncertainty measure (lower is better)
- [ ] **Token Usage** - Tracks prompt, completion, and total token consumption

#### **Content Structure Metrics**
- [ ] **Is-JSON** - Validates output is properly formatted JSON
- [ ] **Contains-JSON** - Checks if output contains valid JSON structure
- [ ] **Is-HTML/XML** - Validates proper HTML or XML formatting
- [ ] **Is-SQL** - Validates SQL query syntax and structure
- [ ] **Function Call Validation** - Ensures function calls match expected schema

#### **Similarity & Matching Metrics**
- [ ] **Semantic Similarity** - Embeddings-based cosine similarity above threshold
- [ ] **Exact Match (Equals)** - Output matches expected value exactly
- [ ] **Contains** - Output contains specified substring(s)
- [ ] **Regex Match** - Output matches specified regular expression pattern
- [ ] **Levenshtein Distance** - Character-level edit distance below threshold

#### **Domain-Specific Metrics**
- [ ] **Answer Relevance** - Ensures LLM output relates to original query (RAG systems)
- [ ] **Conversation Relevance** - Maintains relevance throughout multi-turn conversations
- [ ] **Factuality** - Adherence to given facts using OpenAI evaluation methods
- [ ] **Classification** - Runs output through custom classifier for domain-specific categories

#### **Custom Evaluation Metrics**
- [ ] **JavaScript Custom** - Custom validation using JavaScript functions
- [ ] **Python Custom** - Custom validation using Python scripts
- [ ] **LLM Rubric** - Uses language model to grade against custom criteria
- [ ] **G-Eval** - Chain-of-thought evaluation based on custom criteria
- [ ] **Model-Graded Closed QA** - LLM-based evaluation for question-answering tasks

### Technical-Business Outcome Mapping
- [ ] Map the technical outcome to a business outcome
- [ ] Define clear relationships between technical metrics and business KPIs

#### How does each technical metric (accuracy, precision, recall) translate to business impact?

#### What technical performance threshold is required to achieve business objectives?



