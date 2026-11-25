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

- Overall churn rate is 26.54% (1,869 of 7,043 customers), with $139,130.85 in monthly revenue at risk.
- Contract type is the strongest churn driver: month-to-month churn is 42.71% versus 11.27% for one-year and 2.83% for two-year contracts.
- Churn is heavily front-loaded: 47.44% of first-year customers churn, and the 0-6 month band peaks at 52.94%, falling to 9.51% for 49+ months.
- Fiber optic customers without TechSupport or OnlineSecurity churn at 55.01% (971 of 1,765), versus 14.17% with both services.
- Electronic check payers churn at 49.77% with paperless billing, versus 10.0% for credit card automatic payers without paperless billing.
- The highest-risk segment is month-to-month fiber optic seniors (57.86% churn, $32,169.05 monthly revenue at risk), followed by month-to-month fiber optic non-seniors (53.22%, $68,312.95 at risk).

**Recommendations**
- Incentivize month-to-month customers to move to one- or two-year contracts (e.g., discounts, loyalty perks), targeting the 3,875 month-to-month base where churn is 42.71%.
- Bundle TechSupport and OnlineSecurity into fiber optic plans, especially for the 1,765 fiber customers without both services who churn at 55.01%.
- Launch a first-year onboarding and retention program (welcome offers, proactive support) to address the 47.44% first-year churn, and promote automatic payment methods to reduce the 49.77% electronic-check churn.

<details><summary>🇫🇷 Résumé en français</summary>

Cette analyse de 7 043 clients télécom révèle un taux de résiliation de 26,54 %, mettant 139 130,85 $ de revenus mensuels à risque. La résiliation se concentre sur les contrats sans engagement, les clients récents, les utilisateurs de fibre optique sans services de support/sécurité et les payeurs par chèque électronique.

- Le taux de résiliation global est de 26,54 % (1 869 clients sur 7 043), avec 139 130,85 $ de revenus mensuels à risque.
- Le type de contrat est le principal facteur : 42,71 % de résiliation en sans engagement contre 11,27 % à un an et 2,83 % à deux ans.
- La résiliation est concentrée en début de vie client : 47,44 % la première année, avec un pic de 52,94 % entre 0 et 6 mois, contre 9,51 % après 49 mois.
- Les clients fibre optique sans TechSupport ni OnlineSecurity résilient à 55,01 % (971 sur 1 765), contre 14,17 % avec les deux services.
- Les payeurs par chèque électronique avec facturation dématérialisée résilient à 49,77 %, contre 10,0 % pour les paiements par carte automatique sans papier.
- Le segment le plus à risque est celui des seniors sans engagement en fibre optique (57,86 % de résiliation, 32 169,05 $ à risque), suivi des non-seniors sans engagement en fibre (53,22 %, 68 312,95 $ à risque).

</details>

## Dashboard

📊 **Interactive dashboard:** https://bmmahdi.github.io/telecom-churn-analysis-retention/

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
