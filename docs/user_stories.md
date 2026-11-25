# User Stories — Customer Churn Analysis and Retention Strategy

Priorities follow **MoSCoW** (Must / Should / Could / Won't).

---

## US-01 — Executive churn overview
**As** an Executive Leadership team member
**I want** a single view of the churn rate and monthly revenue at risk
**So that** I can decide how much budget to allocate to retention.

**Priority:** Must

```gherkin
Given the analysis pipeline has run successfully
When I open the dashboard
Then I see the overall churn rate and monthly revenue at risk as KPI cards
And the values match outputs/summary.json
```

---

## US-02 — Churn by contract type
**As** a Customer Retention Manager
**I want** to see churn rate by contract type
**So that** I can design a contract-migration campaign.

**Priority:** Must

```gherkin
Given the cleaned dataset
When I view the "Churn rate by contract type" chart
Then I see one bar per contract type
And month-to-month shows the highest churn rate
```

---

## US-03 — Churn by tenure band
**As** a Product Manager
**I want** to see churn rate by tenure band
**So that** I can prioritise onboarding improvements.

**Priority:** Must

```gherkin
Given the cleaned dataset
When I view the "Churn rate by tenure band" chart
Then I see churn rate decreasing as tenure increases
And the 0-6 month band shows the highest churn rate
```

---

## US-04 — Impact of support add-ons
**As** a Product Manager
**I want** to compare churn for customers with and without Tech Support
**So that** I can decide whether to bundle support into fibre plans.

**Priority:** Should

```gherkin
Given the cleaned dataset
When I view the "Churn rate by internet service and tech support" chart
Then I see two bars per internet service (with / without Tech Support)
And the "with Tech Support" bar is lower for fibre customers
```

---

## US-05 — Payment method risk
**As** a Customer Retention Manager
**I want** to see churn rate by payment method
**So that** I can target payment-migration incentives.

**Priority:** Should

```gherkin
Given the cleaned dataset
When I view the "Churn rate by payment method" chart
Then electronic check shows the highest churn rate
And automatic payment methods show the lowest
```

---

## US-06 — High-risk segments
**As** a Marketing Director
**I want** to see the top 10 segments by monthly revenue at risk
**So that** I can allocate retention budget proportionally.

**Priority:** Must

```gherkin
Given the cleaned dataset
When I view the "Top segments by monthly revenue at risk" chart
Then I see at most 10 segments
And each segment has at least 50 customers
And segments are sorted by revenue at risk descending
```

---

## US-07 — Reproducible analysis
**As** a Data Team member
**I want** the analysis to run end-to-end from a single notebook
**So that** I can refresh results when new data arrives.

**Priority:** Must

```gherkin
Given the repository is cloned and requirements installed
When I run notebooks/analysis.py
Then outputs/summary.json is written
And docs/data/*.json files are written
And five PNG charts are saved to outputs/charts/
```

---

## US-08 — SQL exploration
**As** a Data Analyst
**I want** reusable SQL queries for the main business questions
**So that** I can validate the Python results independently.

**Priority:** Should

```gherkin
Given the CSV is loaded into SQLite by scripts/run_sql.py
When I run the SQL scripts in sql/
Then each script returns a result set
And the churn rate by contract matches the notebook output
```

---

## US-09 — Stakeholder presentation
**As** a Marketing Director
**I want** a short slide deck summarising findings and recommendations
**So that** I can present to the executive committee.

**Priority:** Must

```gherkin
Given slides.json exists
When I open the deck
Then I see 6 to 8 slides covering problem, data, method, findings, recommendations and next steps
And each slide has speaker notes
```

---

## US-10 — Excel business model
**As** a Customer Retention Manager
**I want** an Excel model with inputs, formulas and a summary
**So that** I can test retention scenarios with my team.

**Priority:** Should

```gherkin
Given excel_model.json exists
When I open the generated workbook
Then I see an Inputs sheet, a Model sheet with formulas and a Summary sheet
And changing an input recalculates the summary
```

---

## US-11 — Future churn prediction
**As** a Data Team member
**I want** the feature set to be reusable for a churn prediction model
**So that** we can move from descriptive to predictive analytics.

**Priority:** Could

```gherkin
Given the cleaned dataset
When the prediction phase starts
Then the features used in this analysis (contract, tenure, services, payment) are available
And the target variable is_churned is defined
```

---

## US-12 — Data quality checks
**As** a Data Team member
**I want** automated checks on the outputs
**So that** broken runs are caught before the dashboard is published.

**Priority:** Should

```gherkin
Given the pipeline has run
When scripts/check_outputs.py executes
Then it verifies summary.json, dashboard data files and charts exist
And it fails with a non-zero exit code if any artefact is missing
```
