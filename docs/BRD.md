# Business Requirements Document — Customer Churn Analysis and Retention Strategy

**Project:** Telecom Churn Analysis and Retention Strategy
**Market:** Canada
**Version:** 1.0
**Owner:** Customer Retention Manager
**Author:** Data & Analytics team

---

## 1. Context

The operator serves a mixed residential base across Canada (DSL, fibre-optic and phone-only
customers). Churn has been rising in the last four quarters, driven by aggressive competitor
promotions and a shift toward month-to-month subscriptions. The executive team has asked for a
data-driven view of **who is churning, why, and what to do about it** — with a clear link between
retention actions and protected recurring revenue.

The analysis uses the public **IBM Telco Customer Churn** sample dataset (7,043 customers) as a
representative proxy for the operator's own CRM extract. The methodology and dashboard are
designed to be re-pointed at the production data warehouse with minimal change.

## 2. Objectives

1. Quantify the current churn rate and the monthly recurring revenue at risk.
2. Identify the customer segments with the highest churn propensity.
3. Explain the main churn drivers (contract, tenure, services, payment method).
4. Recommend targeted retention actions with an expected impact on churn and revenue.
5. Deliver a reusable dashboard and analysis pipeline for ongoing monitoring.

## 3. Scope

### In scope
- Descriptive analysis of the IBM Telco Customer Churn dataset (7,043 rows, 21 columns).
- SQL exploration queries (`sql/01…05`).
- Python analysis notebook producing charts, `outputs/summary.json` and dashboard data files.
- Static HTML dashboard (`docs/index.html`) driven by `docs/dashboard.json`.
- Business recommendations and a stakeholder presentation deck.

### Out of scope
- Production deployment of a churn prediction model (a future phase).
- Integration with the live CRM / billing system.
- Pricing strategy changes and competitor benchmarking.
- Customer-level PII handling (dataset is anonymised).

## 4. Stakeholders

| Stakeholder | Role | Interest |
|---|---|---|
| Marketing Director | Sponsor | Retention campaign design, budget allocation |
| Customer Retention Manager | Business owner | Segment targeting, offer design |
| Product Managers | Consumers | Service bundle and add-on strategy |
| Data Team | Delivery | Data quality, pipeline, dashboard |
| Executive Leadership | Decision makers | Revenue protection, KPI tracking |

## 5. Business Requirements

| ID | Requirement | Priority |
|---|---|---|
| BR-01 | Report the overall churn rate and monthly revenue at risk. | Must |
| BR-02 | Break down churn by contract type, tenure band, internet service and payment method. | Must |
| BR-03 | Identify the top 10 customer segments by monthly revenue at risk. | Must |
| BR-04 | Quantify the impact of support add-ons (Tech Support, Online Security) on churn. | Should |
| BR-05 | Provide a dashboard refreshed from the analysis outputs. | Must |
| BR-06 | Recommend retention actions with expected impact and cost. | Must |
| BR-07 | Enable a future churn prediction model using the same feature set. | Could |

## 6. Functional Requirements

| ID | Requirement | Acceptance criteria |
|---|---|---|
| FR-01 | Load and clean the CSV dataset (impute blank `TotalCharges`, standardise categories). | Notebook runs end-to-end with no missing values. |
| FR-02 | Compute KPIs: churn rate, avg monthly charges, avg tenure, revenue at risk, avg CLV. | Values written to `outputs/summary.json`. |
| FR-03 | Produce five charts saved to `outputs/charts/*.png`. | Files exist and render correctly. |
| FR-04 | Write dashboard data files to `docs/data/*.json` as list of records. | Files parse as JSON arrays. |
| FR-05 | Render dashboard from `docs/dashboard.json` with KPI cards and 5 charts. | Dashboard loads without console errors. |
| FR-06 | Provide SQL queries answering the five business questions. | Each file returns a result set via `scripts/run_sql.py`. |
| FR-07 | Provide a stakeholder presentation (6–8 slides). | `slides.json` validates against schema. |

## 7. KPIs

| KPI | Definition | Target |
|---|---|---|
| Churn Rate | Churned customers / total customers | Reduce by 2 pp in 12 months |
| Customer Lifetime Value | Avg of `MonthlyCharges × tenure` | Increase by 10% |
| Average Monthly Charges | Mean of `MonthlyCharges` | Maintain or grow |
| Tenure Distribution | Share of customers by tenure band | Shift toward 25+ months |
| Churn by Contract Type | Churn rate per contract | Month-to-month < 30% |
| Churn by Service Usage | Churn rate per internet service / add-on | Fibre churn < 25% |
| Revenue at Risk | Sum of `MonthlyCharges` for churned customers | Reduce by 20% |

## 8. Assumptions

- The IBM Telco sample is representative of the operator's customer base.
- `TotalCharges` blanks correspond to new customers (tenure = 0) and can be imputed as
  `MonthlyCharges × tenure`.
- Monthly charges are in CAD.
- Churn is defined as voluntary termination within the observation window.

## 9. Risks

| Risk | Likelihood | Impact | Mitigation |
|---|---|---|---|
| Sample not representative of live base | Medium | High | Validate distributions against CRM extract before rollout |
| Retention offers cannibalise margin | Medium | Medium | Model offer cost vs protected revenue per segment |
| Data quality issues in production feed | Medium | Medium | Add data-quality checks to pipeline (`scripts/check_outputs.py`) |
| Stakeholder misalignment on priorities | Low | Medium | Review BRD and dashboard with Marketing Director before launch |
| Privacy / PII exposure | Low | High | Use anonymised data; no PII in dashboard or slides |
