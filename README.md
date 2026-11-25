# Customer Churn Analysis and Retention Strategy — Telecom Operator (Canada)

[![Analysis](https://github.com/bmmahdi/telecom-churn-analysis-retention/actions/workflows/analysis.yml/badge.svg)](https://github.com/bmmahdi/telecom-churn-analysis-retention/actions/workflows/analysis.yml) ![Python](https://img.shields.io/badge/Python-pandas-1f4e79?style=flat-square) ![SQL](https://img.shields.io/badge/SQL-SQLite-1f4e79?style=flat-square) ![Business Analysis](https://img.shields.io/badge/Business-Analysis-1f4e79?style=flat-square)

## Business problem

A Canadian telecom operator is losing customers faster than it can acquire them. Churn is
concentrated in month-to-month, fibre-optic and first-year customers, and retention today is
**reactive** — triggered only when a customer calls to cancel, with generic discounts that erode
margin. Leadership needs a data-driven answer to three questions:

1. **Who** is churning, and which segments carry the most revenue at risk?
2. **Why** are they churning — which contract, tenure, service and payment factors drive it?
3. **What** targeted retention actions will reduce churn and protect recurring revenue?

This project answers those questions with SQL exploration, a Python analysis notebook, a
dashboard and a stakeholder deck — all reproducible from the repository.

## Dataset

- **Source:** [IBM Telco Customer Churn sample dataset](https://raw.githubusercontent.com/IBM/telco-customer-churn-on-icp4d/master/data/Telco-Customer-Churn.csv) (public, widely used for churn analytics).
- **Size:** 7,043 customers × 21 attributes.
- **Fields:** demographics (gender, senior, partner, dependents), services (phone, internet,
  security, backup, protection, support, streaming), account (contract, billing, payment,
  charges, tenure) and the target `Churn`.
- **Licence:** the dataset is a public sample published by IBM for educational and analytical
  use. It contains no real customer PII. Cite the source above when reusing.

## Approach

1. **SQL exploration** (`sql/01…05`) — five queries answering the core business questions
   (churn by contract, tenure band, internet + support, payment method, high-risk segments).
2. **Python analysis** (`notebooks/analysis.py`) — load, clean (impute blank `TotalCharges`,
   standardise categories), derive `is_churned`, `tenure_band`, `revenue_at_risk`, compute KPIs,
   produce five charts and write dashboard data files.
3. **Dashboard** (`docs/index.html` + `docs/dashboard.json` + `docs/data/*.json`) — KPI cards
   and five charts for stakeholder review.
4. **Business artefacts** — BRD, user stories, AS-IS / TO-BE process maps, Excel retention
   model and a stakeholder slide deck.

## Repository structure

```
.
├── data/
│   └── telco_churn.csv
├── sql/
│   ├── 01_churn_rate_by_contract.sql
│   ├── 02_churn_by_tenure_band.sql
│   ├── 03_churn_by_internet_and_support.sql
│   ├── 04_churn_by_payment_method.sql
│   └── 05_high_risk_segments.sql
├── notebooks/
│   └── analysis.py
├── scripts/
│   ├── run_sql.py
│   └── check_outputs.py
├── docs/
│   ├── index.html
│   ├── dashboard.json
│   ├── data/
│   ├── BRD.md
│   ├── user_stories.md
│   └── process_map.md
├── outputs/
│   ├── summary.json
│   ├── charts/
│   └── sql/
├── excel_model.json
├── slides.json
├── requirements.txt
└── README.md
```

## How to run

```bash
# 1. Install dependencies
pip install -r requirements.txt

# 2. Run the SQL exploration (writes outputs/sql/*.csv)
python scripts/run_sql.py

# 3. Run the analysis notebook (writes outputs/summary.json, outputs/charts/*.png, docs/data/*.json)
python notebooks/analysis.py

# 4. Verify all artefacts exist
python scripts/check_outputs.py

# 5. Open the dashboard
#    Serve the docs/ folder, e.g.:
python -m http.server 8000 --directory docs
#    then open http://localhost:8000/
```

## Key findings

_The analysis runs automatically with GitHub Actions; findings appear here when it finishes._

## Dashboard

📊 Dashboard: published with the project.

## Skills demonstrated

- **SQL** — window-free aggregation queries, conditional aggregation, segment ranking.
- **Python** — pandas data cleaning and transformation, numpy, matplotlib visualisation.
- **Data analysis** — churn driver analysis, segment prioritisation, revenue-at-risk modelling.
- **Data visualisation** — five charts + a static HTML dashboard driven by JSON.
- **ETL** — reproducible pipeline from CSV → SQLite → JSON → dashboard.
- **Data modelling** — Excel retention model with inputs, formulas and summary.
- **Communication** — BRD, user stories, process maps, stakeholder slide deck.
- **Stakeholder management** — requirements mapped to KPIs and recommendations.
- **Problem-solving** — translating churn drivers into targeted retention actions.

## Author

**Mohamed El Mahdi Benchouikh** · [Portfolio](https://bmmahdi.github.io/)
